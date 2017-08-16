_init_uart4:
;mips_projekat.c,5 :: 		void init_uart4() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;mips_projekat.c,6 :: 		UART4_Init_Advanced(9600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, & _GPIO_MODULE_UART4_PA01);
MOVW	R0, #lo_addr(__GPIO_MODULE_UART4_PA01+0)
MOVT	R0, #hi_addr(__GPIO_MODULE_UART4_PA01+0)
PUSH	(R0)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
MOVW	R0, #9600
BL	_UART4_Init_Advanced+0
ADD	SP, SP, #4
;mips_projekat.c,7 :: 		Delay_ms(200);
MOVW	R7, #4606
MOVT	R7, #122
NOP
NOP
L_init_uart40:
SUBS	R7, R7, #1
BNE	L_init_uart40
NOP
NOP
NOP
;mips_projekat.c,8 :: 		}
L_end_init_uart4:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _init_uart4
_init_i2c2:
;mips_projekat.c,11 :: 		void init_i2c2() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;mips_projekat.c,12 :: 		I2C2_Init_Advanced(100000, &_GPIO_MODULE_I2C2_PB10_11);
MOVW	R1, #lo_addr(__GPIO_MODULE_I2C2_PB10_11+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_I2C2_PB10_11+0)
MOVW	R0, #34464
MOVT	R0, #1
BL	_I2C2_Init_Advanced+0
;mips_projekat.c,13 :: 		}
L_end_init_i2c2:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _init_i2c2
_main:
;mips_projekat.c,15 :: 		void main() {
SUB	SP, SP, #4
;mips_projekat.c,17 :: 		GPIO_Digital_Output(&GPIOE_BASE, _GPIO_PINMASK_12 | _GPIO_PINMASK_15);
MOVW	R1, #36864
MOVW	R0, #lo_addr(GPIOE_BASE+0)
MOVT	R0, #hi_addr(GPIOE_BASE+0)
BL	_GPIO_Digital_Output+0
;mips_projekat.c,18 :: 		LD1 = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(ODR12_GPIOE_ODR_bit+0)
MOVT	R0, #hi_addr(ODR12_GPIOE_ODR_bit+0)
STR	R1, [R0, #0]
;mips_projekat.c,19 :: 		LD2 = 0;
MOVW	R0, #lo_addr(ODR15_GPIOE_ODR_bit+0)
MOVT	R0, #hi_addr(ODR15_GPIOE_ODR_bit+0)
STR	R0, [SP, #0]
STR	R1, [R0, #0]
;mips_projekat.c,21 :: 		init_uart4();
BL	_init_uart4+0
;mips_projekat.c,22 :: 		init_i2c2();
BL	_init_i2c2+0
;mips_projekat.c,25 :: 		LD1 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(ODR12_GPIOE_ODR_bit+0)
MOVT	R0, #hi_addr(ODR12_GPIOE_ODR_bit+0)
STR	R1, [R0, #0]
;mips_projekat.c,26 :: 		LD2 = 1;
LDR	R0, [SP, #0]
STR	R1, [R0, #0]
;mips_projekat.c,27 :: 		while(1);
L_main2:
IT	AL
BAL	L_main2
;mips_projekat.c,28 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
