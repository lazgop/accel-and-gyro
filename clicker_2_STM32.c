#include <stdint.h>

#define MPU6050_ADDRESS 0x68
#define WHO_AM_I        0x75
#define GYRO_CONFIG     0x1B
#define ACCEL_CONFIG    0x1C
#define SELF_TEST_X     0x0D
#define SELF_TEST_Y     0x0E
#define SELF_TEST_Z     0x0F
#define SELF_TEST_A     0x10
#define PWR_MGMT_1      0x6B
#define PWR_MGMT_2      0x6C
#define INT_ENABLE      0x38
#define FIFO_EN         0x23
#define I2C_MST_CTRL    0x24
#define USER_CTRL       0x6A
#define SMPLRT_DIV      0x19
#define CONFIG          0x1A
#define FIFO_COUNTH     0x72
#define FIFO_R_W        0x74
#define XA_OFFSET_H     0x06
#define YA_OFFSET_H     0x08
#define ZA_OFFSET_H     0x0A
#define INT_PIN_CFG     0x37
#define MOT_THR         0x1F
#define MOT_DUR         0x20
#define MOT_DETECT_CTRL 0x69

sbit LD1 at ODR12_GPIOE_ODR_bit;
sbit LD2 at ODR15_GPIOE_ODR_bit;

// Accelerometer scale bits for AFS
enum Ascale {
  AFS_2G = 0,
  AFS_4G,
  AFS_8G,
  AFS_16G
};

// Gyroscope scale bits for GFS
enum Gscale {
  GFS_250DPS = 0,
  GFS_500DPS,
  GFS_1000DPS,
  GFS_2000DPS
};

// Preset values for AFS and GFS
int Gscale = GFS_250DPS;
int Ascale = AFS_2G;

// Calculated accelerometer and gyroscope biases
float bax, bay, baz, bgx, bgy, bgz;

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

void calculateAccelAndGyroBiases() {
    unsigned char data_[12];
    uint16_t ii, packet_count, fifo_count;
    int32_t gyro_bias[3] = {0, 0, 0}, accel_bias[3] = {0, 0, 0};
    uint16_t  accelsensitivity = 16384;
    uint16_t  gyrosensitivity  = 131;   // = 131 LSB/degrees/sec
    int32_t accel_bias_reg[3] = {0, 0, 0}; // A place to hold the factory accelerometer trim biases
    uint32_t mask = 1uL; // Define mask for temperature compensation bit 0 of lower byte of accelerometer bias registers
    uint8_t mask_bit[3] = {0, 0, 0}; // Define array to hold mask bit for each accelerometer bias axis


    writeByte(PWR_MGMT_1, 0x80);   // Reset MPU6050
    Delay_ms(100);
    
    writeByte(PWR_MGMT_1, 0x01);   // Set clock source to gyro x-axis
    writeByte(PWR_MGMT_2, 0x00);   // Set low power sleep mode wake up frequency to 1.25Hz
    Delay_ms(200);
    
    // Set up device for bias calculation
    writeByte(INT_ENABLE, 0x00);   // Disable all interrupts
    writeByte(FIFO_EN, 0x00);      // Disable FIFO
    writeByte(PWR_MGMT_1, 0x00);   // Turn on internal clock source
    writeByte(I2C_MST_CTRL, 0x00); // Disable I2C master
    writeByte(USER_CTRL, 0x00);    // Disable FIFO and I2C master modes
    writeByte(USER_CTRL, 0x0C);    // Reset FIFO and DMP
    Delay_ms(15);
    
    // Set up accel and gyro for bias calculation
    writeByte(CONFIG, 0x01);       // Set low-pass filter to 188 Hz
    writeByte(SMPLRT_DIV, 0x00);   // Set sample rate to 1 kHz
    writeByte(GYRO_CONFIG, 0x00);  // Set gyro full-scale to 250 degrees per second, maximum sensitivity
    writeByte(ACCEL_CONFIG, 0x00); // Set accelerometer full-scale to 2 g, maximum sensitivity

     // Configure FIFO to capture accelerometer and gyro data for bias calculation
    writeByte(USER_CTRL, 0x40);    // Enable FIFO
    writeByte(FIFO_EN, 0x78);      // Enable gyro and accelerometer sensors for FIFO  (max size 1024 bytes in MPU-6050)
    Delay_ms(80);                  // Capture 80 samples
    
    // At end of sample accumulation, turn off FIFO sensor read
    writeByte(FIFO_EN, 0x00);             // Disable gyro and accelerometer sensors for FIFO
    readBytes(FIFO_COUNTH, 2, &data_[0]); // read FIFO sample count
    fifo_count = ((uint16_t)data_[0] << 8) | data_[1];
    packet_count = fifo_count/12;          // How many sets of full gyro and accelerometer data for averaging

    for (ii = 0; ii < packet_count; ii++) {
      int16_t accel_temp[3] = {0, 0, 0}, gyro_temp[3] = {0, 0, 0};
      
      readBytes(FIFO_R_W, 12, &data_[0]); // read data for averaging
      
      accel_temp[0] = (int16_t) (((int16_t)data_[0] << 8) | data_[1]  ) ;  // Form signed 16-bit integer for each sample in FIFO
      accel_temp[1] = (int16_t) (((int16_t)data_[2] << 8) | data_[3]  ) ;
      accel_temp[2] = (int16_t) (((int16_t)data_[4] << 8) | data_[5]  ) ;
      gyro_temp[0]  = (int16_t) (((int16_t)data_[6] << 8) | data_[7]  ) ;
      gyro_temp[1]  = (int16_t) (((int16_t)data_[8] << 8) | data_[9]  ) ;
      gyro_temp[2]  = (int16_t) (((int16_t)data_[10] << 8) | data_[11]) ;

      accel_bias[0] += (int32_t) accel_temp[0]; // Sum individual signed 16-bit biases to get accumulated signed 32-bit biases
      accel_bias[1] += (int32_t) accel_temp[1];
      accel_bias[2] += (int32_t) accel_temp[2];
      gyro_bias[0]  += (int32_t) gyro_temp[0];
      gyro_bias[1]  += (int32_t) gyro_temp[1];
      gyro_bias[2]  += (int32_t) gyro_temp[2];
    }
    
    accel_bias[0] /= (int32_t) packet_count; // Normalize sums to get average count biases
    accel_bias[1] /= (int32_t) packet_count;
    accel_bias[2] /= (int32_t) packet_count;
    gyro_bias[0]  /= (int32_t) packet_count;
    gyro_bias[1]  /= (int32_t) packet_count;
    gyro_bias[2]  /= (int32_t) packet_count;
    
    if(accel_bias[2] > 0L) {accel_bias[2] -= (int32_t) accelsensitivity;}  // Remove gravity from the z-axis accelerometer bias calculation
    else {accel_bias[2] += (int32_t) accelsensitivity;}

    // Construct the gyro biases for push to the hardware gyro bias registers, which are reset to zero upon device startup
    data_[0] = (-gyro_bias[0]/4  >> 8) & 0xFF; // Divide by 4 to get 32.9 LSB per deg/s to conform to expected bias input format
    data_[1] = (-gyro_bias[0]/4)       & 0xFF; // Biases are additive, so change sign on calculated average gyro biases
    data_[2] = (-gyro_bias[1]/4  >> 8) & 0xFF;
    data_[3] = (-gyro_bias[1]/4)       & 0xFF;
    data_[4] = (-gyro_bias[2]/4  >> 8) & 0xFF;
    data_[5] = (-gyro_bias[2]/4)       & 0xFF;

    bgx = (float) gyro_bias[0]/(float) gyrosensitivity; // construct gyro bias in deg/s for later manual subtraction
    bgy = (float) gyro_bias[1]/(float) gyrosensitivity;
    bgz = (float) gyro_bias[2]/(float) gyrosensitivity;
    
    // Construct the accelerometer biases for push to the hardware accelerometer bias registers. These registers contain
    // factory trim values which must be added to the calculated accelerometer biases; on boot up these registers will hold
    // non-zero values. In addition, bit 0 of the lower byte must be preserved since it is used for temperature
    // compensation calculations. Accelerometer bias registers expect bias input as 2048 LSB per g, so that
    // the accelerometer biases calculated above must be divided by 8.


    readBytes(XA_OFFSET_H, 2, &data_[0]); // Read factory accelerometer trim values
    accel_bias_reg[0] = (int16_t) ((int16_t)data_[0] << 8) | data_[1];
    readBytes(YA_OFFSET_H, 2, &data_[0]);
    accel_bias_reg[1] = (int16_t) ((int16_t)data_[0] << 8) | data_[1];
    readBytes(ZA_OFFSET_H, 2, &data_[0]);
    accel_bias_reg[2] = (int16_t) ((int16_t)data_[0] << 8) | data_[1];

    for(ii = 0; ii < 3; ii++) {
      if(accel_bias_reg[ii] & mask) mask_bit[ii] = 0x01; // If temperature compensation bit is set, record that fact in mask_bit
    }

  // Construct total accelerometer bias, including calculated average accelerometer bias from above
    accel_bias_reg[0] -= (accel_bias[0]/8); // Subtract calculated averaged accelerometer bias scaled to 2048 LSB/g (16 g full scale)
    accel_bias_reg[1] -= (accel_bias[1]/8);
    accel_bias_reg[2] -= (accel_bias[2]/8);

    data_[0] = (accel_bias_reg[0] >> 8) & 0xFF;
    data_[1] = (accel_bias_reg[0])      & 0xFF;
    data_[1] = data_[1] | mask_bit[0]; // preserve temperature compensation bit when writing back to accelerometer bias registers
    data_[2] = (accel_bias_reg[1] >> 8) & 0xFF;
    data_[3] = (accel_bias_reg[1])      & 0xFF;
    data_[3] = data_[3] | mask_bit[1]; // preserve temperature compensation bit when writing back to accelerometer bias registers
    data_[4] = (accel_bias_reg[2] >> 8) & 0xFF;
    data_[5] = (accel_bias_reg[2])      & 0xFF;
    data_[5] = data_[5] | mask_bit[2]; // preserve temperature compensation bit when writing back to accelerometer bias registers


// Output scaled accelerometer biases for manual subtraction in the main program
    bax = (float)accel_bias[0]/(float)accelsensitivity;
    bay = (float)accel_bias[1]/(float)accelsensitivity;
    baz = (float)accel_bias[2]/(float)accelsensitivity;
}

void initMPU6050() {
    uint8_t c;
    writeByte(PWR_MGMT_1, 0x09);              // also disable temperature sensor
    writeByte(CONFIG, 0x06);
    writeByte(SMPLRT_DIV, 0x04);
    c =  readByte(GYRO_CONFIG);
    writeByte(GYRO_CONFIG, c & ~0xE0);        // Clear self-test bits [7:5]
    writeByte(GYRO_CONFIG, c & ~0x18);        // Clear AFS bits [4:3]
    writeByte(GYRO_CONFIG, c | Gscale << 3);  // Set full scale range for the gyro

    c =  readByte(ACCEL_CONFIG);
    writeByte(ACCEL_CONFIG, c & ~0xE0);       // Clear self-test bits [7:5]
    writeByte(ACCEL_CONFIG, c & ~0x18);       // Clear AFS bits [4:3]
    writeByte(ACCEL_CONFIG, c | Ascale << 3); // Set full scale range for the accelerometer

    writeByte(INT_PIN_CFG, 0xA0);
    writeByte(MOT_THR, 0x14);
    writeByte(MOT_DUR, 0x28);
    writeByte(MOT_DETECT_CTRL, 0x15);
    writeByte(INT_ENABLE, 0x40);
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
     
     calculateAccelAndGyroBiases();
     
     initMPU6050();
     
     

     LD1 = 1;
     LD2 = 1;
     while(1);
}