sbit LD1 at ODR12_GPIOE_ODR_bit;
sbit LD2 at ODR15_GPIOE_ODR_bit;

void main() {
     // Leds for testing
     GPIO_Digital_Output(&GPIOE_BASE, _GPIO_PINMASK_12 | _GPIO_PINMASK_15);
     LD1 = 0;
     LD2 = 0;
     
     
     
     while(1);
}