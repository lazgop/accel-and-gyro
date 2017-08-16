
#define MPU6050_ADDRESS 0x68

sbit LD1 at ODR12_GPIOE_ODR_bit;
sbit LD2 at ODR15_GPIOE_ODR_bit;

// Initializes UART on PA0 and PA1 pins
void init_uart4() {
     UART4_Init_Advanced(9600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, & _GPIO_MODULE_UART4_PA01);
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


// Requests ID from mpu6050 0x68 reg and returns 1 on success, otherwise 0
int checkMPU6050() {

    return 1;
}

void main() {
     // Leds for testing
     GPIO_Digital_Output(&GPIOE_BASE, _GPIO_PINMASK_12 | _GPIO_PINMASK_15);
     LD1 = 0;
     LD2 = 0;
     
     init_uart4();
     init_i2c2();
     
     
     
     
     LD1 = 1;
     LD2 = 1;
     while(1);
}