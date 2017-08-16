_init_uart4:
;clicker_2_STM32.c,15 :: 		void init_uart4() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;clicker_2_STM32.c,16 :: 		UART4_Init_Advanced(9600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_UART4_PA01);
MOVW	R0, #lo_addr(__GPIO_MODULE_UART4_PA01+0)
MOVT	R0, #hi_addr(__GPIO_MODULE_UART4_PA01+0)
PUSH	(R0)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
MOVW	R0, #9600
BL	_UART4_Init_Advanced+0
ADD	SP, SP, #4
;clicker_2_STM32.c,17 :: 		Delay_ms(200);
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
;clicker_2_STM32.c,18 :: 		}
L_end_init_uart4:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _init_uart4
_init_i2c2:
;clicker_2_STM32.c,21 :: 		void init_i2c2() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;clicker_2_STM32.c,22 :: 		I2C2_Init_Advanced(100000, &_GPIO_MODULE_I2C2_PB10_11);
MOVW	R1, #lo_addr(__GPIO_MODULE_I2C2_PB10_11+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_I2C2_PB10_11+0)
MOVW	R0, #34464
MOVT	R0, #1
BL	_I2C2_Init_Advanced+0
;clicker_2_STM32.c,23 :: 		}
L_end_init_i2c2:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _init_i2c2
_readByte:
;clicker_2_STM32.c,25 :: 		unsigned char readByte(unsigned char registerAddress) {
; registerAddress start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; registerAddress end address is: 0 (R0)
; registerAddress start address is: 0 (R0)
;clicker_2_STM32.c,27 :: 		read_data[0] = registerAddress;
ADD	R1, SP, #4
STRB	R0, [R1, #0]
; registerAddress end address is: 0 (R0)
;clicker_2_STM32.c,29 :: 		I2C2_Start();
BL	_I2C2_Start+0
;clicker_2_STM32.c,30 :: 		I2C2_Write(MPU6050_ADDRESS, read_data, 1, END_MODE_RESTART);
ADD	R1, SP, #4
MOVW	R3, #0
MOVS	R2, #1
MOVS	R0, #104
BL	_I2C2_Write+0
;clicker_2_STM32.c,31 :: 		I2C2_Read(MPU6050_ADDRESS, read_data, 1, END_MODE_STOP);
ADD	R1, SP, #4
MOVW	R3, #1
MOVS	R2, #1
MOVS	R0, #104
BL	_I2C2_Read+0
;clicker_2_STM32.c,33 :: 		return read_data[0];
ADD	R1, SP, #4
LDRB	R1, [R1, #0]
UXTB	R0, R1
;clicker_2_STM32.c,34 :: 		}
L_end_readByte:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _readByte
_readBytes:
;clicker_2_STM32.c,36 :: 		void readBytes(unsigned char registerAddress, int count, unsigned char *buffer) {
; buffer start address is: 8 (R2)
; count start address is: 4 (R1)
; registerAddress start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
SXTH	R10, R1
MOV	R11, R2
; buffer end address is: 8 (R2)
; count end address is: 4 (R1)
; registerAddress end address is: 0 (R0)
; registerAddress start address is: 0 (R0)
; count start address is: 40 (R10)
; buffer start address is: 44 (R11)
;clicker_2_STM32.c,37 :: 		buffer[0] = registerAddress;
STRB	R0, [R11, #0]
; registerAddress end address is: 0 (R0)
;clicker_2_STM32.c,39 :: 		I2C2_Start();
BL	_I2C2_Start+0
;clicker_2_STM32.c,40 :: 		I2C2_Write(MPU6050_ADDRESS, buffer, 1, END_MODE_RESTART);
MOVW	R3, #0
MOVS	R2, #1
MOV	R1, R11
MOVS	R0, #104
BL	_I2C2_Write+0
;clicker_2_STM32.c,41 :: 		I2C2_Read(MPU6050_ADDRESS, buffer, count, END_MODE_STOP);
MOVW	R3, #1
SXTH	R2, R10
; count end address is: 40 (R10)
MOV	R1, R11
; buffer end address is: 44 (R11)
MOVS	R0, #104
BL	_I2C2_Read+0
;clicker_2_STM32.c,42 :: 		}
L_end_readBytes:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _readBytes
_writeByte:
;clicker_2_STM32.c,44 :: 		void writeByte(unsigned char registerAddress, unsigned char byte){
; byte start address is: 4 (R1)
; registerAddress start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; byte end address is: 4 (R1)
; registerAddress end address is: 0 (R0)
; registerAddress start address is: 0 (R0)
; byte start address is: 4 (R1)
;clicker_2_STM32.c,46 :: 		write_data[0] = registerAddress;
ADD	R2, SP, #4
STRB	R0, [R2, #0]
; registerAddress end address is: 0 (R0)
;clicker_2_STM32.c,47 :: 		write_data[1] = byte;
ADDS	R2, R2, #1
STRB	R1, [R2, #0]
; byte end address is: 4 (R1)
;clicker_2_STM32.c,49 :: 		I2C2_Start();
BL	_I2C2_Start+0
;clicker_2_STM32.c,50 :: 		I2C2_Write(MPU6050_ADDRESS, write_data, 2, END_MODE_STOP);
ADD	R2, SP, #4
MOVW	R3, #1
MOV	R1, R2
MOVS	R2, #2
MOVS	R0, #104
BL	_I2C2_Write+0
;clicker_2_STM32.c,51 :: 		}
L_end_writeByte:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _writeByte
_checkMPU6050:
;clicker_2_STM32.c,55 :: 		int checkMPU6050() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;clicker_2_STM32.c,56 :: 		if (readByte(WHO_AM_I) !=  'h') { // Ascii for 'h' is 0x68
MOVS	R0, #117
BL	_readByte+0
CMP	R0, #104
IT	EQ
BEQ	L_checkMPU60502
;clicker_2_STM32.c,57 :: 		UART4_Write_Text("Failed to read 'WHO AM I' from MPU6050\r\n");
MOVW	R0, #lo_addr(?lstr1_clicker_2_STM32+0)
MOVT	R0, #hi_addr(?lstr1_clicker_2_STM32+0)
BL	_UART4_Write_Text+0
;clicker_2_STM32.c,58 :: 		return 1;
MOVS	R0, #1
SXTH	R0, R0
IT	AL
BAL	L_end_checkMPU6050
;clicker_2_STM32.c,59 :: 		}
L_checkMPU60502:
;clicker_2_STM32.c,61 :: 		UART4_Write_Text("Read 'WHO AM I' from MPU6050\r\n");
MOVW	R0, #lo_addr(?lstr2_clicker_2_STM32+0)
MOVT	R0, #hi_addr(?lstr2_clicker_2_STM32+0)
BL	_UART4_Write_Text+0
;clicker_2_STM32.c,62 :: 		return 0;
MOVS	R0, #0
SXTH	R0, R0
;clicker_2_STM32.c,63 :: 		}
L_end_checkMPU6050:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _checkMPU6050
_selfTestMPU6050:
;clicker_2_STM32.c,66 :: 		int selfTestMPU6050() {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;clicker_2_STM32.c,73 :: 		writeByte(ACCEL_CONFIG, 0xF0);
MOVS	R1, #240
MOVS	R0, #28
BL	_writeByte+0
;clicker_2_STM32.c,74 :: 		writeByte(GYRO_CONFIG, 0xE0);
MOVS	R1, #224
MOVS	R0, #27
BL	_writeByte+0
;clicker_2_STM32.c,75 :: 		Delay_ms(250);
MOVW	R7, #38526
MOVT	R7, #152
NOP
NOP
L_selfTestMPU60503:
SUBS	R7, R7, #1
BNE	L_selfTestMPU60503
NOP
NOP
NOP
;clicker_2_STM32.c,78 :: 		rdx = readByte(SELF_TEST_X);
MOVS	R0, #13
BL	_readByte+0
; rdx start address is: 48 (R12)
UXTB	R12, R0
;clicker_2_STM32.c,79 :: 		rdy = readByte(SELF_TEST_Y);
MOVS	R0, #14
BL	_readByte+0
; rdy start address is: 44 (R11)
UXTB	R11, R0
;clicker_2_STM32.c,80 :: 		rdz = readByte(SELF_TEST_Z);
MOVS	R0, #15
BL	_readByte+0
; rdz start address is: 16 (R4)
UXTB	R4, R0
;clicker_2_STM32.c,81 :: 		rda = readByte(SELF_TEST_A);
STRB	R4, [SP, #4]
MOVS	R0, #16
BL	_readByte+0
LDRB	R4, [SP, #4]
;clicker_2_STM32.c,84 :: 		stax = ((rdx >> 3) & 0x1C) | ((rda >> 4) & 0x03);
LSR	R1, R12, #3
UXTB	R1, R1
AND	R2, R1, #28
UXTB	R2, R2
LSRS	R1, R0, #4
UXTB	R1, R1
AND	R1, R1, #3
UXTB	R1, R1
ORR	R3, R2, R1, LSL #0
UXTB	R3, R3
; stax start address is: 24 (R6)
UXTB	R6, R3
;clicker_2_STM32.c,85 :: 		stay = ((rdy >> 3) & 0x1C) | ((rda >> 2) & 0x03);
LSR	R1, R11, #3
UXTB	R1, R1
AND	R2, R1, #28
UXTB	R2, R2
LSRS	R1, R0, #2
UXTB	R1, R1
AND	R1, R1, #3
UXTB	R1, R1
ORR	R1, R2, R1, LSL #0
; stay start address is: 28 (R7)
UXTB	R7, R1
;clicker_2_STM32.c,86 :: 		staz = ((rdz >> 3) & 0x1C) | ((rda >> 0) & 0x03);
LSRS	R1, R4, #3
UXTB	R1, R1
; rdz end address is: 16 (R4)
AND	R1, R1, #28
UXTB	R1, R1
AND	R0, R0, #3
UXTB	R0, R0
ORR	R0, R1, R0, LSL #0
; staz start address is: 32 (R8)
UXTB	R8, R0
;clicker_2_STM32.c,89 :: 		stgx = rdx & 0x1F;
AND	R0, R12, #31
; rdx end address is: 48 (R12)
; stgx start address is: 36 (R9)
UXTB	R9, R0
;clicker_2_STM32.c,90 :: 		stgy = rdy & 0x1F;
AND	R0, R11, #31
; rdy end address is: 44 (R11)
; stgy start address is: 40 (R10)
UXTB	R10, R0
;clicker_2_STM32.c,91 :: 		stgz = rdy & 0x1F;
; stgz start address is: 44 (R11)
UXTB	R11, R0
;clicker_2_STM32.c,94 :: 		ftax = (4096.0*0.34)*(pow((0.92/0.34), (((float)stax - 1.0)/30.0)));
VMOV	S1, R3
VCVT.F32	#0, S1, S1
VMOV.F32	S0, #1
VSUB.F32	S1, S1, S0
VMOV.F32	S0, #30
VDIV.F32	S0, S1, S0
MOVW	R0, #11565
MOVT	R0, #16429
VMOV.F32	S1, S0
VMOV	S0, R0
BL	_pow+0
MOVW	R0, #5243
MOVT	R0, #17582
VMOV	S1, R0
VMUL.F32	S0, S1, S0
; ftax start address is: 28 (R7)
VMOV.F32	S7, S0
;clicker_2_STM32.c,95 :: 		ftay = (4096.0*0.34)*(pow((0.92/0.34), (((float)stay - 1.0)/30.0)));
VMOV	S1, R7
VCVT.F32	#0, S1, S1
VMOV.F32	S0, #1
VSUB.F32	S1, S1, S0
VMOV.F32	S0, #30
VDIV.F32	S0, S1, S0
MOVW	R0, #11565
MOVT	R0, #16429
VMOV.F32	S1, S0
VMOV	S0, R0
BL	_pow+0
MOVW	R0, #5243
MOVT	R0, #17582
VMOV	S1, R0
VMUL.F32	S0, S1, S0
; ftay start address is: 24 (R6)
VMOV.F32	S6, S0
;clicker_2_STM32.c,96 :: 		ftaz = (4096.0*0.34)*(pow((0.92/0.34), (((float)staz - 1.0)/30.0)));
VMOV	S1, R8
VCVT.F32	#0, S1, S1
VMOV.F32	S0, #1
VSUB.F32	S1, S1, S0
VMOV.F32	S0, #30
VDIV.F32	S0, S1, S0
MOVW	R0, #11565
MOVT	R0, #16429
VMOV.F32	S1, S0
VMOV	S0, R0
BL	_pow+0
MOVW	R0, #5243
MOVT	R0, #17582
VMOV	S1, R0
VMUL.F32	S0, S1, S0
; ftaz start address is: 40 (R10)
VMOV.F32	S10, S0
;clicker_2_STM32.c,99 :: 		ftgx =  ( 25.0*131.0)*(pow(1.046, ((float)stgx - 1.0)));
VMOV	S1, R9
VCVT.F32	#0, S1, S1
VMOV.F32	S0, #1
VSUB.F32	S0, S1, S0
MOVW	R0, #58196
MOVT	R0, #16261
VMOV.F32	S1, S0
VMOV	S0, R0
BL	_pow+0
MOVW	R0, #45056
MOVT	R0, #17740
VMOV	S1, R0
VMUL.F32	S0, S1, S0
; ftgx start address is: 36 (R9)
VMOV.F32	S9, S0
;clicker_2_STM32.c,100 :: 		ftgy =  (-25.0*131.0)*(pow(1.046, ((float)stgy - 1.0)));
VMOV	S1, R10
VCVT.F32	#0, S1, S1
VMOV.F32	S0, #1
VSUB.F32	S0, S1, S0
MOVW	R0, #58196
MOVT	R0, #16261
VMOV.F32	S1, S0
VMOV	S0, R0
BL	_pow+0
MOVW	R0, #45056
MOVT	R0, #50508
VMOV	S1, R0
VMUL.F32	S0, S1, S0
; ftgy start address is: 32 (R8)
VMOV.F32	S8, S0
;clicker_2_STM32.c,101 :: 		ftgz =  ( 25.0*131.0)*(pow(1.046, ((float)stgz - 1.0)));
VMOV	S1, R11
VCVT.F32	#0, S1, S1
VMOV.F32	S0, #1
VSUB.F32	S0, S1, S0
MOVW	R0, #58196
MOVT	R0, #16261
VMOV.F32	S1, S0
VMOV	S0, R0
BL	_pow+0
MOVW	R0, #45056
MOVT	R0, #17740
VMOV	S1, R0
VMUL.F32	S2, S1, S0
;clicker_2_STM32.c,104 :: 		dpax = 100.0 + 100.0*((float)stax - ftax)/ftax;
VMOV	S0, R6
VCVT.F32	#0, S0, S0
; stax end address is: 24 (R6)
VSUB.F32	S1, S0, S7
MOVW	R0, #0
MOVT	R0, #17096
VMOV	S0, R0
VMUL.F32	S0, S0, S1
VDIV.F32	S1, S0, S7
; ftax end address is: 28 (R7)
MOVW	R0, #0
MOVT	R0, #17096
VMOV	S0, R0
VADD.F32	S7, S0, S1
;clicker_2_STM32.c,105 :: 		dpay = 100.0 + 100.0*((float)stay - ftay)/ftay;
VMOV	S0, R7
VCVT.F32	#0, S0, S0
; stay end address is: 28 (R7)
VSUB.F32	S1, S0, S6
MOVW	R0, #0
MOVT	R0, #17096
VMOV	S0, R0
VMUL.F32	S0, S0, S1
VDIV.F32	S1, S0, S6
; ftay end address is: 24 (R6)
MOVW	R0, #0
MOVT	R0, #17096
VMOV	S0, R0
VADD.F32	S6, S0, S1
;clicker_2_STM32.c,106 :: 		dpaz = 100.0 + 100.0*((float)staz - ftaz)/ftaz;
VMOV	S0, R8
VCVT.F32	#0, S0, S0
; staz end address is: 32 (R8)
VSUB.F32	S1, S0, S10
MOVW	R0, #0
MOVT	R0, #17096
VMOV	S0, R0
VMUL.F32	S0, S0, S1
VDIV.F32	S1, S0, S10
; ftaz end address is: 40 (R10)
MOVW	R0, #0
MOVT	R0, #17096
VMOV	S0, R0
VADD.F32	S5, S0, S1
;clicker_2_STM32.c,107 :: 		dpgx = 100.0 + 100.0*((float)stgx - ftgx)/ftgx;
VMOV	S0, R9
VCVT.F32	#0, S0, S0
; stgx end address is: 36 (R9)
VSUB.F32	S1, S0, S9
MOVW	R0, #0
MOVT	R0, #17096
VMOV	S0, R0
VMUL.F32	S0, S0, S1
VDIV.F32	S1, S0, S9
; ftgx end address is: 36 (R9)
MOVW	R0, #0
MOVT	R0, #17096
VMOV	S0, R0
VADD.F32	S4, S0, S1
;clicker_2_STM32.c,108 :: 		dpgy = 100.0 + 100.0*((float)stgy - ftgy)/ftgy;
VMOV	S0, R10
VCVT.F32	#0, S0, S0
; stgy end address is: 40 (R10)
VSUB.F32	S1, S0, S8
MOVW	R0, #0
MOVT	R0, #17096
VMOV	S0, R0
VMUL.F32	S0, S0, S1
VDIV.F32	S1, S0, S8
; ftgy end address is: 32 (R8)
MOVW	R0, #0
MOVT	R0, #17096
VMOV	S0, R0
VADD.F32	S3, S0, S1
;clicker_2_STM32.c,109 :: 		dpgz = 100.0 + 100.0*((float)stgz - ftgz)/ftgz;
VMOV	S0, R11
VCVT.F32	#0, S0, S0
; stgz end address is: 44 (R11)
VSUB.F32	S1, S0, S2
MOVW	R0, #0
MOVT	R0, #17096
VMOV	S0, R0
VMUL.F32	S0, S0, S1
VDIV.F32	S1, S0, S2
MOVW	R0, #0
MOVT	R0, #17096
VMOV	S0, R0
VADD.F32	S1, S0, S1
;clicker_2_STM32.c,112 :: 		if (dpax > 1f | dpay > 1f | dpaz > 1f | dpgx > 1f | dpgy > 1f | dpgz > 1f) {
VMOV.F32	S0, #1
VCMPE.F32	S7, S0
VMRS	#60, FPSCR
MOVW	R1, #0
BLE	L__selfTestMPU605017
MOVS	R1, #1
L__selfTestMPU605017:
VMOV.F32	S0, #1
VCMPE.F32	S6, S0
VMRS	#60, FPSCR
MOVW	R0, #0
BLE	L__selfTestMPU605018
MOVS	R0, #1
L__selfTestMPU605018:
ORRS	R1, R0
VMOV.F32	S0, #1
VCMPE.F32	S5, S0
VMRS	#60, FPSCR
MOVW	R0, #0
BLE	L__selfTestMPU605019
MOVS	R0, #1
L__selfTestMPU605019:
ORRS	R1, R0
VMOV.F32	S0, #1
VCMPE.F32	S4, S0
VMRS	#60, FPSCR
MOVW	R0, #0
BLE	L__selfTestMPU605020
MOVS	R0, #1
L__selfTestMPU605020:
ORRS	R1, R0
VMOV.F32	S0, #1
VCMPE.F32	S3, S0
VMRS	#60, FPSCR
MOVW	R0, #0
BLE	L__selfTestMPU605021
MOVS	R0, #1
L__selfTestMPU605021:
ORRS	R1, R0
VMOV.F32	S0, #1
VCMPE.F32	S1, S0
VMRS	#60, FPSCR
MOVW	R0, #0
BLE	L__selfTestMPU605022
MOVS	R0, #1
L__selfTestMPU605022:
ORR	R0, R1, R0, LSL #0
CMP	R0, #0
IT	EQ
BEQ	L_selfTestMPU60505
;clicker_2_STM32.c,113 :: 		return 1;
MOVS	R0, #1
SXTH	R0, R0
IT	AL
BAL	L_end_selfTestMPU6050
;clicker_2_STM32.c,114 :: 		}
L_selfTestMPU60505:
;clicker_2_STM32.c,116 :: 		return 0;
MOVS	R0, #0
SXTH	R0, R0
;clicker_2_STM32.c,117 :: 		}
L_end_selfTestMPU6050:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _selfTestMPU6050
_main:
;clicker_2_STM32.c,120 :: 		void main() {
;clicker_2_STM32.c,122 :: 		GPIO_Digital_Output(&GPIOE_BASE, _GPIO_PINMASK_12 | _GPIO_PINMASK_15);
MOVW	R1, #36864
MOVW	R0, #lo_addr(GPIOE_BASE+0)
MOVT	R0, #hi_addr(GPIOE_BASE+0)
BL	_GPIO_Digital_Output+0
;clicker_2_STM32.c,123 :: 		LD1 = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(ODR12_GPIOE_ODR_bit+0)
MOVT	R0, #hi_addr(ODR12_GPIOE_ODR_bit+0)
STR	R1, [R0, #0]
;clicker_2_STM32.c,124 :: 		LD2 = 0;
MOVW	R0, #lo_addr(ODR15_GPIOE_ODR_bit+0)
MOVT	R0, #hi_addr(ODR15_GPIOE_ODR_bit+0)
STR	R1, [R0, #0]
;clicker_2_STM32.c,126 :: 		init_uart4();
BL	_init_uart4+0
;clicker_2_STM32.c,127 :: 		init_i2c2();
BL	_init_i2c2+0
;clicker_2_STM32.c,129 :: 		if (checkMPU6050() == 1) {
BL	_checkMPU6050+0
CMP	R0, #1
IT	NE
BNE	L_main6
;clicker_2_STM32.c,130 :: 		return;
IT	AL
BAL	L_end_main
;clicker_2_STM32.c,131 :: 		}
L_main6:
;clicker_2_STM32.c,133 :: 		if (selfTestMPU6050() == 1) {
BL	_selfTestMPU6050+0
CMP	R0, #1
IT	NE
BNE	L_main7
;clicker_2_STM32.c,134 :: 		return;
IT	AL
BAL	L_end_main
;clicker_2_STM32.c,135 :: 		}
L_main7:
;clicker_2_STM32.c,137 :: 		LD1 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(ODR12_GPIOE_ODR_bit+0)
MOVT	R0, #hi_addr(ODR12_GPIOE_ODR_bit+0)
STR	R1, [R0, #0]
;clicker_2_STM32.c,138 :: 		LD2 = 1;
MOVW	R0, #lo_addr(ODR15_GPIOE_ODR_bit+0)
MOVT	R0, #hi_addr(ODR15_GPIOE_ODR_bit+0)
STR	R1, [R0, #0]
;clicker_2_STM32.c,139 :: 		while(1);
L_main8:
IT	AL
BAL	L_main8
;clicker_2_STM32.c,140 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
