#line 1 "C:/Users/lazar/Desktop/mips_projekat/mips_projekat.c"
sbit LD1 at ODR12_GPIOE_ODR_bit;
sbit LD2 at ODR15_GPIOE_ODR_bit;

void main() {

 GPIO_Digital_Output(&GPIOE_BASE, _GPIO_PINMASK_12 | _GPIO_PINMASK_15);
 LD1 = 1;
 LD2 = 1;

 while(1);
}
