#line 1 "C:/Users/lazar/Desktop/mips_projekat/clicker_2_STM32.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for arm/include/stdint.h"





typedef signed char int8_t;
typedef signed int int16_t;
typedef signed long int int32_t;
typedef signed long long int64_t;


typedef unsigned char uint8_t;
typedef unsigned int uint16_t;
typedef unsigned long int uint32_t;
typedef unsigned long long uint64_t;


typedef signed char int_least8_t;
typedef signed int int_least16_t;
typedef signed long int int_least32_t;
typedef signed long long int_least64_t;


typedef unsigned char uint_least8_t;
typedef unsigned int uint_least16_t;
typedef unsigned long int uint_least32_t;
typedef unsigned long long uint_least64_t;



typedef signed long int int_fast8_t;
typedef signed long int int_fast16_t;
typedef signed long int int_fast32_t;
typedef signed long long int_fast64_t;


typedef unsigned long int uint_fast8_t;
typedef unsigned long int uint_fast16_t;
typedef unsigned long int uint_fast32_t;
typedef unsigned long long uint_fast64_t;


typedef signed long int intptr_t;
typedef unsigned long int uintptr_t;


typedef signed long long intmax_t;
typedef unsigned long long uintmax_t;
#line 26 "C:/Users/lazar/Desktop/mips_projekat/clicker_2_STM32.c"
sbit LD1 at ODR12_GPIOE_ODR_bit;
sbit LD2 at ODR15_GPIOE_ODR_bit;


float bax, bay, baz, bgx, bgy, bgz;


void init_uart4() {
 UART4_Init_Advanced(9600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_UART4_PA01);
 Delay_ms(200);
}


void init_i2c2() {
 I2C2_Init_Advanced(100000, &_GPIO_MODULE_I2C2_PB10_11);
}

unsigned char readByte(unsigned char registerAddress) {
 unsigned char read_data[1];
 read_data[0] = registerAddress;

 I2C2_Start();
 I2C2_Write( 0x68 , read_data, 1, END_MODE_RESTART);
 I2C2_Read( 0x68 , read_data, 1, END_MODE_STOP);

 return read_data[0];
}

void readBytes(unsigned char registerAddress, int count, unsigned char *buffer) {
 buffer[0] = registerAddress;

 I2C2_Start();
 I2C2_Write( 0x68 , buffer, 1, END_MODE_RESTART);
 I2C2_Read( 0x68 , buffer, count, END_MODE_STOP);
}

void writeByte(unsigned char registerAddress, unsigned char byte){
 unsigned char write_data[2];
 write_data[0] = registerAddress;
 write_data[1] = byte;

 I2C2_Start();
 I2C2_Write( 0x68 , write_data, 2, END_MODE_STOP);
}



int checkMPU6050() {
 if (readByte( 0x75 ) != 'h') {
 UART4_Write_Text("Failed to read 'WHO AM I' from MPU6050\r\n");
 return 1;
 }

 UART4_Write_Text("Read 'WHO AM I' from MPU6050\r\n");
 return 0;
}


int selfTestMPU6050() {
 unsigned char rdx, rdy, rdz, rda;
 unsigned char stax, stay, staz, stgx, stgy, stgz;
 float ftax, ftay, ftaz, ftgx, ftgy, ftgz;
 float dpax, dpay, dpaz, dpgx, dpgy, dpgz;


 writeByte( 0x1C , 0xF0);
 writeByte( 0x1B , 0xE0);
 Delay_ms(250);


 rdx = readByte( 0x0D );
 rdy = readByte( 0x0E );
 rdz = readByte( 0x0F );
 rda = readByte( 0x10 );


 stax = ((rdx >> 3) & 0x1C) | ((rda >> 4) & 0x03);
 stay = ((rdy >> 3) & 0x1C) | ((rda >> 2) & 0x03);
 staz = ((rdz >> 3) & 0x1C) | ((rda >> 0) & 0x03);


 stgx = rdx & 0x1F;
 stgy = rdy & 0x1F;
 stgz = rdy & 0x1F;


 ftax = (4096.0*0.34)*(pow((0.92/0.34), (((float)stax - 1.0)/30.0)));
 ftay = (4096.0*0.34)*(pow((0.92/0.34), (((float)stay - 1.0)/30.0)));
 ftaz = (4096.0*0.34)*(pow((0.92/0.34), (((float)staz - 1.0)/30.0)));


 ftgx = ( 25.0*131.0)*(pow(1.046, ((float)stgx - 1.0)));
 ftgy = (-25.0*131.0)*(pow(1.046, ((float)stgy - 1.0)));
 ftgz = ( 25.0*131.0)*(pow(1.046, ((float)stgz - 1.0)));


 dpax = 100.0 + 100.0*((float)stax - ftax)/ftax;
 dpay = 100.0 + 100.0*((float)stay - ftay)/ftay;
 dpaz = 100.0 + 100.0*((float)staz - ftaz)/ftaz;
 dpgx = 100.0 + 100.0*((float)stgx - ftgx)/ftgx;
 dpgy = 100.0 + 100.0*((float)stgy - ftgy)/ftgy;
 dpgz = 100.0 + 100.0*((float)stgz - ftgz)/ftgz;


 if (dpax > 1f | dpay > 1f | dpaz > 1f | dpgx > 1f | dpgy > 1f | dpgz > 1f) {
 return 1;
 }

 return 0;
}

void calculateAccelAndGyroBiases() {
 unsigned char data_[12];
 uint16_t ii, packet_count, fifo_count;
 int32_t gyro_bias[3] = {0, 0, 0}, accel_bias[3] = {0, 0, 0};
 uint16_t accelsensitivity = 16384;
 uint16_t gyrosensitivity = 131;
 int32_t accel_bias_reg[3] = {0, 0, 0};
 uint32_t mask = 1uL;
 uint8_t mask_bit[3] = {0, 0, 0};


 writeByte( 0x6B , 0x80);
 Delay_ms(100);

 writeByte( 0x6B , 0x01);
 writeByte( 0x6C , 0x00);
 Delay_ms(200);


 writeByte( 0x38 , 0x00);
 writeByte( 0x23 , 0x00);
 writeByte( 0x6B , 0x00);
 writeByte( 0x24 , 0x00);
 writeByte( 0x6A , 0x00);
 writeByte( 0x6A , 0x0C);
 Delay_ms(15);


 writeByte( 0x1A , 0x01);
 writeByte( 0x19 , 0x00);
 writeByte( 0x1B , 0x00);
 writeByte( 0x1C , 0x00);


 writeByte( 0x6A , 0x40);
 writeByte( 0x23 , 0x78);
 Delay_ms(80);


 writeByte( 0x23 , 0x00);
 readBytes( 0x72 , 2, &data_[0]);
 fifo_count = ((uint16_t)data_[0] << 8) | data_[1];
 packet_count = fifo_count/12;

 for (ii = 0; ii < packet_count; ii++) {
 int16_t accel_temp[3] = {0, 0, 0}, gyro_temp[3] = {0, 0, 0};

 readBytes( 0x74 , 12, &data_[0]);

 accel_temp[0] = (int16_t) (((int16_t)data_[0] << 8) | data_[1] ) ;
 accel_temp[1] = (int16_t) (((int16_t)data_[2] << 8) | data_[3] ) ;
 accel_temp[2] = (int16_t) (((int16_t)data_[4] << 8) | data_[5] ) ;
 gyro_temp[0] = (int16_t) (((int16_t)data_[6] << 8) | data_[7] ) ;
 gyro_temp[1] = (int16_t) (((int16_t)data_[8] << 8) | data_[9] ) ;
 gyro_temp[2] = (int16_t) (((int16_t)data_[10] << 8) | data_[11]) ;

 accel_bias[0] += (int32_t) accel_temp[0];
 accel_bias[1] += (int32_t) accel_temp[1];
 accel_bias[2] += (int32_t) accel_temp[2];
 gyro_bias[0] += (int32_t) gyro_temp[0];
 gyro_bias[1] += (int32_t) gyro_temp[1];
 gyro_bias[2] += (int32_t) gyro_temp[2];
 }

 accel_bias[0] /= (int32_t) packet_count;
 accel_bias[1] /= (int32_t) packet_count;
 accel_bias[2] /= (int32_t) packet_count;
 gyro_bias[0] /= (int32_t) packet_count;
 gyro_bias[1] /= (int32_t) packet_count;
 gyro_bias[2] /= (int32_t) packet_count;

 if(accel_bias[2] > 0L) {accel_bias[2] -= (int32_t) accelsensitivity;}
 else {accel_bias[2] += (int32_t) accelsensitivity;}


 data_[0] = (-gyro_bias[0]/4 >> 8) & 0xFF;
 data_[1] = (-gyro_bias[0]/4) & 0xFF;
 data_[2] = (-gyro_bias[1]/4 >> 8) & 0xFF;
 data_[3] = (-gyro_bias[1]/4) & 0xFF;
 data_[4] = (-gyro_bias[2]/4 >> 8) & 0xFF;
 data_[5] = (-gyro_bias[2]/4) & 0xFF;

 bgx = (float) gyro_bias[0]/(float) gyrosensitivity;
 bgy = (float) gyro_bias[1]/(float) gyrosensitivity;
 bgz = (float) gyro_bias[2]/(float) gyrosensitivity;








 readBytes( 0x06 , 2, &data_[0]);
 accel_bias_reg[0] = (int16_t) ((int16_t)data_[0] << 8) | data_[1];
 readBytes( 0x08 , 2, &data_[0]);
 accel_bias_reg[1] = (int16_t) ((int16_t)data_[0] << 8) | data_[1];
 readBytes( 0x0A , 2, &data_[0]);
 accel_bias_reg[2] = (int16_t) ((int16_t)data_[0] << 8) | data_[1];

 for(ii = 0; ii < 3; ii++) {
 if(accel_bias_reg[ii] & mask) mask_bit[ii] = 0x01;
 }


 accel_bias_reg[0] -= (accel_bias[0]/8);
 accel_bias_reg[1] -= (accel_bias[1]/8);
 accel_bias_reg[2] -= (accel_bias[2]/8);

 data_[0] = (accel_bias_reg[0] >> 8) & 0xFF;
 data_[1] = (accel_bias_reg[0]) & 0xFF;
 data_[1] = data_[1] | mask_bit[0];
 data_[2] = (accel_bias_reg[1] >> 8) & 0xFF;
 data_[3] = (accel_bias_reg[1]) & 0xFF;
 data_[3] = data_[3] | mask_bit[1];
 data_[4] = (accel_bias_reg[2] >> 8) & 0xFF;
 data_[5] = (accel_bias_reg[2]) & 0xFF;
 data_[5] = data_[5] | mask_bit[2];



 bax = (float)accel_bias[0]/(float)accelsensitivity;
 bay = (float)accel_bias[1]/(float)accelsensitivity;
 baz = (float)accel_bias[2]/(float)accelsensitivity;
}

void main() {

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

 LD1 = 1;
 LD2 = 1;
 while(1);
}