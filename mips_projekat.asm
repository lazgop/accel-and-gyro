_main:
;mips_projekat.c,4 :: 		void main() {
;mips_projekat.c,6 :: 		GPIO_Digital_Output(&GPIOE_BASE, _GPIO_PINMASK_12 | _GPIO_PINMASK_15);
MOVW	R1, #36864
MOVW	R0, #lo_addr(GPIOE_BASE+0)
MOVT	R0, #hi_addr(GPIOE_BASE+0)
BL	_GPIO_Digital_Output+0
;mips_projekat.c,7 :: 		LD1 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(ODR12_GPIOE_ODR_bit+0)
MOVT	R0, #hi_addr(ODR12_GPIOE_ODR_bit+0)
STR	R1, [R0, #0]
;mips_projekat.c,8 :: 		LD2 = 1;
MOVW	R0, #lo_addr(ODR15_GPIOE_ODR_bit+0)
MOVT	R0, #hi_addr(ODR15_GPIOE_ODR_bit+0)
STR	R1, [R0, #0]
;mips_projekat.c,10 :: 		while(1);
L_main0:
IT	AL
BAL	L_main0
;mips_projekat.c,11 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
