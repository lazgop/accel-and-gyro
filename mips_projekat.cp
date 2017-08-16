#line 1 "C:/Users/lazar/Desktop/mips_projekat/mips_projekat.c"
sbit LD1 at ODR12_GPIOE_ODR_bit;
sbit LD2 at ODR15_GPIOE_ODR_bit;


void init_uart4() {
 UART4_Init_Advanced(9600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, & _GPIO_MODULE_UART4_PA01);
 Delay_ms(200);
}


void init_i2c2() {
 I2C2_Init_Advanced(100000, &_GPIO_MODULE_I2C2_PB10_11);
}

void main() {

 GPIO_Digital_Output(&GPIOE_BASE, _GPIO_PINMASK_12 | _GPIO_PINMASK_15);
 LD1 = 0;
 LD2 = 0;

 init_uart4();
 init_i2c2();


 LD1 = 1;
 LD2 = 1;
 while(1);
}
