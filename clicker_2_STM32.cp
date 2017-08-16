#line 1 "C:/Users/lazar/Desktop/mips_projekat/clicker_2_STM32.c"










sbit LD1 at ODR12_GPIOE_ODR_bit;
sbit LD2 at ODR15_GPIOE_ODR_bit;


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

 LD1 = 1;
 LD2 = 1;
 while(1);
}
