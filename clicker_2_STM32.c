
#define MPU6050_ADDRESS 0x68
#define WHO_AM_I        0x75
#define GYRO_CONFIG     0x1B
#define ACCEL_CONFIG    0x1C
#define SELF_TEST_X     0x0D
#define SELF_TEST_Y     0x0E
#define SELF_TEST_Z     0x0F
#define SELF_TEST_A     0x10

sbit LD1 at ODR12_GPIOE_ODR_bit;
sbit LD2 at ODR15_GPIOE_ODR_bit;

// Initializes UART on PA0 and PA1 pins
void init_uart4() {
     UART4_Init_Advanced(9600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_UART4_PA01);
     Delay_ms(200);
}

// Initializes I2C on pins PB10 and PB11 with 100Kbps rate
void init_i2c2() {
     I2C2_Init_Advanced(100000, &_GPIO_MODULE_I2C2_PB10_11);
}

unsigned char readByte(unsigned char registerAddress) {
     unsigned char read_data[1];
     read_data[0] = registerAddress;

     I2C2_Start();
     I2C2_Write(MPU6050_ADDRESS, read_data, 1, END_MODE_RESTART);
     I2C2_Read(MPU6050_ADDRESS, read_data, 1, END_MODE_STOP);

     return read_data[0];
}

void readBytes(unsigned char registerAddress, int count, unsigned char *buffer) {
     buffer[0] = registerAddress;

     I2C2_Start();
     I2C2_Write(MPU6050_ADDRESS, buffer, 1, END_MODE_RESTART);
     I2C2_Read(MPU6050_ADDRESS, buffer, count, END_MODE_STOP);
}

void writeByte(unsigned char registerAddress, unsigned char byte){
     unsigned char write_data[2];
     write_data[0] = registerAddress;
     write_data[1] = byte;

     I2C2_Start();
     I2C2_Write(MPU6050_ADDRESS, write_data, 2, END_MODE_STOP);
}


// Requests ID from mpu6050 0x68 reg and returns 0 on success, otherwise return 1
int checkMPU6050() {
    if (readByte(WHO_AM_I) !=  'h') { // Ascii for 'h' is 0x68
       UART4_Write_Text("Failed to read 'WHO AM I' from MPU6050\r\n");
       return 1;
    }

    UART4_Write_Text("Read 'WHO AM I' from MPU6050\r\n");
    return 0;
}

// Execute self test and return 0 on success, otherwise return 1
int selfTestMPU6050() {
    unsigned char rdx, rdy, rdz, rda;                 // Register/raw data
    unsigned char stax, stay, staz, stgx, stgy, stgz; // Extracted self test values from register data
    float ftax, ftay, ftaz, ftgx, ftgy, ftgz;         // Factory trim values calculated using self test values
    float dpax, dpay, dpaz, dpgx, dpgy, dpgz;         // Deviation percentage calculated from self test and factory trim values
    
    // Initialize internal self test for accel and gyro
    writeByte(ACCEL_CONFIG, 0xF0);
    writeByte(GYRO_CONFIG, 0xE0);
    Delay_ms(250);
    
    // Register/raw data
    rdx = readByte(SELF_TEST_X);
    rdy = readByte(SELF_TEST_Y);
    rdz = readByte(SELF_TEST_Z);
    rda = readByte(SELF_TEST_A);
    
    // Self test accelerometer values
    stax = ((rdx >> 3) & 0x1C) | ((rda >> 4) & 0x03);
    stay = ((rdy >> 3) & 0x1C) | ((rda >> 2) & 0x03);
    staz = ((rdz >> 3) & 0x1C) | ((rda >> 0) & 0x03);
    
    // Self test gyroscope values
    stgx = rdx & 0x1F;
    stgy = rdy & 0x1F;
    stgz = rdy & 0x1F;

    // Factory trim accelerometer values
    ftax = (4096.0*0.34)*(pow((0.92/0.34), (((float)stax - 1.0)/30.0)));
    ftay = (4096.0*0.34)*(pow((0.92/0.34), (((float)stay - 1.0)/30.0)));
    ftaz = (4096.0*0.34)*(pow((0.92/0.34), (((float)staz - 1.0)/30.0)));
    
    // Factory trim gyroscope values
    ftgx =  ( 25.0*131.0)*(pow(1.046, ((float)stgx - 1.0)));
    ftgy =  (-25.0*131.0)*(pow(1.046, ((float)stgy - 1.0)));
    ftgz =  ( 25.0*131.0)*(pow(1.046, ((float)stgz - 1.0)));
    
    // Deviation percentage values
    dpax = 100.0 + 100.0*((float)stax - ftax)/ftax;
    dpay = 100.0 + 100.0*((float)stay - ftay)/ftay;
    dpaz = 100.0 + 100.0*((float)staz - ftaz)/ftaz;
    dpgx = 100.0 + 100.0*((float)stgx - ftgx)/ftgx;
    dpgy = 100.0 + 100.0*((float)stgy - ftgy)/ftgy;
    dpgz = 100.0 + 100.0*((float)stgz - ftgz)/ftgz;
    
    // Check if DPs are less than 1 percent
    if (dpax > 1f | dpay > 1f | dpaz > 1f | dpgx > 1f | dpgy > 1f | dpgz > 1f) {
       return 1;
    }
    
    return 0;
}


void main() {
     // Leds for testing
     GPIO_Digital_Output(&GPIOE_BASE, _GPIO_PINMASK_12 | _GPIO_PINMASK_15);
     LD1 = 0;
     LD2 = 0;

     init_uart4();
     init_i2c2();

     if (checkMPU6050() == 1) {
        return;
     }
     
     if (selfTestMPU6050() == 1) {
        return;
     }
     
     

     LD1 = 1;
     LD2 = 1;
     while(1);
}