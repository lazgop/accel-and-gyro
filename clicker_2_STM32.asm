_init_uart4:
;clicker_2_STM32.c,33 :: 		void init_uart4() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;clicker_2_STM32.c,34 :: 		UART4_Init_Advanced(9600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_UART4_PA01);
MOVW	R0, #lo_addr(__GPIO_MODULE_UART4_PA01+0)
MOVT	R0, #hi_addr(__GPIO_MODULE_UART4_PA01+0)
PUSH	(R0)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
MOVW	R0, #9600
BL	_UART4_Init_Advanced+0
ADD	SP, SP, #4
;clicker_2_STM32.c,35 :: 		Delay_ms(200);
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
;clicker_2_STM32.c,36 :: 		}
L_end_init_uart4:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _init_uart4
_init_i2c2:
;clicker_2_STM32.c,39 :: 		void init_i2c2() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;clicker_2_STM32.c,40 :: 		I2C2_Init_Advanced(100000, &_GPIO_MODULE_I2C2_PB10_11);
MOVW	R1, #lo_addr(__GPIO_MODULE_I2C2_PB10_11+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_I2C2_PB10_11+0)
MOVW	R0, #34464
MOVT	R0, #1
BL	_I2C2_Init_Advanced+0
;clicker_2_STM32.c,41 :: 		}
L_end_init_i2c2:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _init_i2c2
_readByte:
;clicker_2_STM32.c,43 :: 		unsigned char readByte(unsigned char registerAddress) {
; registerAddress start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; registerAddress end address is: 0 (R0)
; registerAddress start address is: 0 (R0)
;clicker_2_STM32.c,45 :: 		read_data[0] = registerAddress;
ADD	R1, SP, #4
STRB	R0, [R1, #0]
; registerAddress end address is: 0 (R0)
;clicker_2_STM32.c,47 :: 		I2C2_Start();
BL	_I2C2_Start+0
;clicker_2_STM32.c,48 :: 		I2C2_Write(MPU6050_ADDRESS, read_data, 1, END_MODE_RESTART);
ADD	R1, SP, #4
MOVW	R3, #0
MOVS	R2, #1
MOVS	R0, #104
BL	_I2C2_Write+0
;clicker_2_STM32.c,49 :: 		I2C2_Read(MPU6050_ADDRESS, read_data, 1, END_MODE_STOP);
ADD	R1, SP, #4
MOVW	R3, #1
MOVS	R2, #1
MOVS	R0, #104
BL	_I2C2_Read+0
;clicker_2_STM32.c,51 :: 		return read_data[0];
ADD	R1, SP, #4
LDRB	R1, [R1, #0]
UXTB	R0, R1
;clicker_2_STM32.c,52 :: 		}
L_end_readByte:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _readByte
_readBytes:
;clicker_2_STM32.c,54 :: 		void readBytes(unsigned char registerAddress, int count, unsigned char *buffer) {
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
;clicker_2_STM32.c,55 :: 		buffer[0] = registerAddress;
STRB	R0, [R11, #0]
; registerAddress end address is: 0 (R0)
;clicker_2_STM32.c,57 :: 		I2C2_Start();
BL	_I2C2_Start+0
;clicker_2_STM32.c,58 :: 		I2C2_Write(MPU6050_ADDRESS, buffer, 1, END_MODE_RESTART);
MOVW	R3, #0
MOVS	R2, #1
MOV	R1, R11
MOVS	R0, #104
BL	_I2C2_Write+0
;clicker_2_STM32.c,59 :: 		I2C2_Read(MPU6050_ADDRESS, buffer, count, END_MODE_STOP);
MOVW	R3, #1
SXTH	R2, R10
; count end address is: 40 (R10)
MOV	R1, R11
; buffer end address is: 44 (R11)
MOVS	R0, #104
BL	_I2C2_Read+0
;clicker_2_STM32.c,60 :: 		}
L_end_readBytes:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _readBytes
_writeByte:
;clicker_2_STM32.c,62 :: 		void writeByte(unsigned char registerAddress, unsigned char byte){
; byte start address is: 4 (R1)
; registerAddress start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; byte end address is: 4 (R1)
; registerAddress end address is: 0 (R0)
; registerAddress start address is: 0 (R0)
; byte start address is: 4 (R1)
;clicker_2_STM32.c,64 :: 		write_data[0] = registerAddress;
ADD	R2, SP, #4
STRB	R0, [R2, #0]
; registerAddress end address is: 0 (R0)
;clicker_2_STM32.c,65 :: 		write_data[1] = byte;
ADDS	R2, R2, #1
STRB	R1, [R2, #0]
; byte end address is: 4 (R1)
;clicker_2_STM32.c,67 :: 		I2C2_Start();
BL	_I2C2_Start+0
;clicker_2_STM32.c,68 :: 		I2C2_Write(MPU6050_ADDRESS, write_data, 2, END_MODE_STOP);
ADD	R2, SP, #4
MOVW	R3, #1
MOV	R1, R2
MOVS	R2, #2
MOVS	R0, #104
BL	_I2C2_Write+0
;clicker_2_STM32.c,69 :: 		}
L_end_writeByte:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _writeByte
_checkMPU6050:
;clicker_2_STM32.c,73 :: 		int checkMPU6050() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;clicker_2_STM32.c,74 :: 		if (readByte(WHO_AM_I) !=  'h') { // Ascii for 'h' is 0x68
MOVS	R0, #117
BL	_readByte+0
CMP	R0, #104
IT	EQ
BEQ	L_checkMPU60502
;clicker_2_STM32.c,75 :: 		UART4_Write_Text("Failed to read 'WHO AM I' from MPU6050\r\n");
MOVW	R0, #lo_addr(?lstr1_clicker_2_STM32+0)
MOVT	R0, #hi_addr(?lstr1_clicker_2_STM32+0)
BL	_UART4_Write_Text+0
;clicker_2_STM32.c,76 :: 		return 1;
MOVS	R0, #1
SXTH	R0, R0
IT	AL
BAL	L_end_checkMPU6050
;clicker_2_STM32.c,77 :: 		}
L_checkMPU60502:
;clicker_2_STM32.c,79 :: 		UART4_Write_Text("Read 'WHO AM I' from MPU6050\r\n");
MOVW	R0, #lo_addr(?lstr2_clicker_2_STM32+0)
MOVT	R0, #hi_addr(?lstr2_clicker_2_STM32+0)
BL	_UART4_Write_Text+0
;clicker_2_STM32.c,80 :: 		return 0;
MOVS	R0, #0
SXTH	R0, R0
;clicker_2_STM32.c,81 :: 		}
L_end_checkMPU6050:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _checkMPU6050
_selfTestMPU6050:
;clicker_2_STM32.c,84 :: 		int selfTestMPU6050() {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;clicker_2_STM32.c,91 :: 		writeByte(ACCEL_CONFIG, 0xF0);
MOVS	R1, #240
MOVS	R0, #28
BL	_writeByte+0
;clicker_2_STM32.c,92 :: 		writeByte(GYRO_CONFIG, 0xE0);
MOVS	R1, #224
MOVS	R0, #27
BL	_writeByte+0
;clicker_2_STM32.c,93 :: 		Delay_ms(250);
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
;clicker_2_STM32.c,96 :: 		rdx = readByte(SELF_TEST_X);
MOVS	R0, #13
BL	_readByte+0
; rdx start address is: 48 (R12)
UXTB	R12, R0
;clicker_2_STM32.c,97 :: 		rdy = readByte(SELF_TEST_Y);
MOVS	R0, #14
BL	_readByte+0
; rdy start address is: 44 (R11)
UXTB	R11, R0
;clicker_2_STM32.c,98 :: 		rdz = readByte(SELF_TEST_Z);
MOVS	R0, #15
BL	_readByte+0
; rdz start address is: 16 (R4)
UXTB	R4, R0
;clicker_2_STM32.c,99 :: 		rda = readByte(SELF_TEST_A);
STRB	R4, [SP, #4]
MOVS	R0, #16
BL	_readByte+0
LDRB	R4, [SP, #4]
;clicker_2_STM32.c,102 :: 		stax = ((rdx >> 3) & 0x1C) | ((rda >> 4) & 0x03);
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
;clicker_2_STM32.c,103 :: 		stay = ((rdy >> 3) & 0x1C) | ((rda >> 2) & 0x03);
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
;clicker_2_STM32.c,104 :: 		staz = ((rdz >> 3) & 0x1C) | ((rda >> 0) & 0x03);
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
;clicker_2_STM32.c,107 :: 		stgx = rdx & 0x1F;
AND	R0, R12, #31
; rdx end address is: 48 (R12)
; stgx start address is: 36 (R9)
UXTB	R9, R0
;clicker_2_STM32.c,108 :: 		stgy = rdy & 0x1F;
AND	R0, R11, #31
; rdy end address is: 44 (R11)
; stgy start address is: 40 (R10)
UXTB	R10, R0
;clicker_2_STM32.c,109 :: 		stgz = rdy & 0x1F;
; stgz start address is: 44 (R11)
UXTB	R11, R0
;clicker_2_STM32.c,112 :: 		ftax = (4096.0*0.34)*(pow((0.92/0.34), (((float)stax - 1.0)/30.0)));
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
;clicker_2_STM32.c,113 :: 		ftay = (4096.0*0.34)*(pow((0.92/0.34), (((float)stay - 1.0)/30.0)));
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
;clicker_2_STM32.c,114 :: 		ftaz = (4096.0*0.34)*(pow((0.92/0.34), (((float)staz - 1.0)/30.0)));
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
;clicker_2_STM32.c,117 :: 		ftgx =  ( 25.0*131.0)*(pow(1.046, ((float)stgx - 1.0)));
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
;clicker_2_STM32.c,118 :: 		ftgy =  (-25.0*131.0)*(pow(1.046, ((float)stgy - 1.0)));
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
;clicker_2_STM32.c,119 :: 		ftgz =  ( 25.0*131.0)*(pow(1.046, ((float)stgz - 1.0)));
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
;clicker_2_STM32.c,122 :: 		dpax = 100.0 + 100.0*((float)stax - ftax)/ftax;
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
;clicker_2_STM32.c,123 :: 		dpay = 100.0 + 100.0*((float)stay - ftay)/ftay;
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
;clicker_2_STM32.c,124 :: 		dpaz = 100.0 + 100.0*((float)staz - ftaz)/ftaz;
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
;clicker_2_STM32.c,125 :: 		dpgx = 100.0 + 100.0*((float)stgx - ftgx)/ftgx;
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
;clicker_2_STM32.c,126 :: 		dpgy = 100.0 + 100.0*((float)stgy - ftgy)/ftgy;
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
;clicker_2_STM32.c,127 :: 		dpgz = 100.0 + 100.0*((float)stgz - ftgz)/ftgz;
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
;clicker_2_STM32.c,130 :: 		if (dpax > 1f | dpay > 1f | dpaz > 1f | dpgx > 1f | dpgy > 1f | dpgz > 1f) {
VMOV.F32	S0, #1
VCMPE.F32	S7, S0
VMRS	#60, FPSCR
MOVW	R1, #0
BLE	L__selfTestMPU605034
MOVS	R1, #1
L__selfTestMPU605034:
VMOV.F32	S0, #1
VCMPE.F32	S6, S0
VMRS	#60, FPSCR
MOVW	R0, #0
BLE	L__selfTestMPU605035
MOVS	R0, #1
L__selfTestMPU605035:
ORRS	R1, R0
VMOV.F32	S0, #1
VCMPE.F32	S5, S0
VMRS	#60, FPSCR
MOVW	R0, #0
BLE	L__selfTestMPU605036
MOVS	R0, #1
L__selfTestMPU605036:
ORRS	R1, R0
VMOV.F32	S0, #1
VCMPE.F32	S4, S0
VMRS	#60, FPSCR
MOVW	R0, #0
BLE	L__selfTestMPU605037
MOVS	R0, #1
L__selfTestMPU605037:
ORRS	R1, R0
VMOV.F32	S0, #1
VCMPE.F32	S3, S0
VMRS	#60, FPSCR
MOVW	R0, #0
BLE	L__selfTestMPU605038
MOVS	R0, #1
L__selfTestMPU605038:
ORRS	R1, R0
VMOV.F32	S0, #1
VCMPE.F32	S1, S0
VMRS	#60, FPSCR
MOVW	R0, #0
BLE	L__selfTestMPU605039
MOVS	R0, #1
L__selfTestMPU605039:
ORR	R0, R1, R0, LSL #0
CMP	R0, #0
IT	EQ
BEQ	L_selfTestMPU60505
;clicker_2_STM32.c,131 :: 		return 1;
MOVS	R0, #1
SXTH	R0, R0
IT	AL
BAL	L_end_selfTestMPU6050
;clicker_2_STM32.c,132 :: 		}
L_selfTestMPU60505:
;clicker_2_STM32.c,134 :: 		return 0;
MOVS	R0, #0
SXTH	R0, R0
;clicker_2_STM32.c,135 :: 		}
L_end_selfTestMPU6050:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _selfTestMPU6050
_calculateAccelAndGyroBiases:
;clicker_2_STM32.c,137 :: 		void calculateAccelAndGyroBiases() {
SUB	SP, SP, #88
STR	LR, [SP, #0]
;clicker_2_STM32.c,140 :: 		int32_t gyro_bias[3] = {0, 0, 0}, accel_bias[3] = {0, 0, 0};
ADD	R11, SP, #32
ADD	R10, R11, #47
MOVW	R12, #lo_addr(?ICScalculateAccelAndGyroBiases_gyro_bias_L0+0)
MOVT	R12, #hi_addr(?ICScalculateAccelAndGyroBiases_gyro_bias_L0+0)
BL	___CC2DW+0
;clicker_2_STM32.c,141 :: 		uint16_t  accelsensitivity = 16384;
;clicker_2_STM32.c,142 :: 		uint16_t  gyrosensitivity  = 131;   // = 131 LSB/degrees/sec
;clicker_2_STM32.c,143 :: 		int32_t accel_bias_reg[3] = {0, 0, 0}; // A place to hold the factory accelerometer trim biases
;clicker_2_STM32.c,144 :: 		uint32_t mask = 1uL; // Define mask for temperature compensation bit 0 of lower byte of accelerometer bias registers
;clicker_2_STM32.c,145 :: 		uint8_t mask_bit[3] = {0, 0, 0}; // Define array to hold mask bit for each accelerometer bias axis
;clicker_2_STM32.c,148 :: 		writeByte(PWR_MGMT_1, 0x80);   // Reset MPU6050
MOVS	R1, #128
MOVS	R0, #107
BL	_writeByte+0
;clicker_2_STM32.c,149 :: 		Delay_ms(100);
MOVW	R7, #2302
MOVT	R7, #61
NOP
NOP
L_calculateAccelAndGyroBiases6:
SUBS	R7, R7, #1
BNE	L_calculateAccelAndGyroBiases6
NOP
NOP
NOP
;clicker_2_STM32.c,151 :: 		writeByte(PWR_MGMT_1, 0x01);   // Set clock source to gyro x-axis
MOVS	R1, #1
MOVS	R0, #107
BL	_writeByte+0
;clicker_2_STM32.c,152 :: 		writeByte(PWR_MGMT_2, 0x00);   // Set low power sleep mode wake up frequency to 1.25Hz
MOVS	R1, #0
MOVS	R0, #108
BL	_writeByte+0
;clicker_2_STM32.c,153 :: 		Delay_ms(200);
MOVW	R7, #4606
MOVT	R7, #122
NOP
NOP
L_calculateAccelAndGyroBiases8:
SUBS	R7, R7, #1
BNE	L_calculateAccelAndGyroBiases8
NOP
NOP
NOP
;clicker_2_STM32.c,156 :: 		writeByte(INT_ENABLE, 0x00);   // Disable all interrupts
MOVS	R1, #0
MOVS	R0, #56
BL	_writeByte+0
;clicker_2_STM32.c,157 :: 		writeByte(FIFO_EN, 0x00);      // Disable FIFO
MOVS	R1, #0
MOVS	R0, #35
BL	_writeByte+0
;clicker_2_STM32.c,158 :: 		writeByte(PWR_MGMT_1, 0x00);   // Turn on internal clock source
MOVS	R1, #0
MOVS	R0, #107
BL	_writeByte+0
;clicker_2_STM32.c,159 :: 		writeByte(I2C_MST_CTRL, 0x00); // Disable I2C master
MOVS	R1, #0
MOVS	R0, #36
BL	_writeByte+0
;clicker_2_STM32.c,160 :: 		writeByte(USER_CTRL, 0x00);    // Disable FIFO and I2C master modes
MOVS	R1, #0
MOVS	R0, #106
BL	_writeByte+0
;clicker_2_STM32.c,161 :: 		writeByte(USER_CTRL, 0x0C);    // Reset FIFO and DMP
MOVS	R1, #12
MOVS	R0, #106
BL	_writeByte+0
;clicker_2_STM32.c,162 :: 		Delay_ms(15);
MOVW	R7, #10174
MOVT	R7, #9
NOP
NOP
L_calculateAccelAndGyroBiases10:
SUBS	R7, R7, #1
BNE	L_calculateAccelAndGyroBiases10
NOP
NOP
NOP
;clicker_2_STM32.c,165 :: 		writeByte(CONFIG, 0x01);       // Set low-pass filter to 188 Hz
MOVS	R1, #1
MOVS	R0, #26
BL	_writeByte+0
;clicker_2_STM32.c,166 :: 		writeByte(SMPLRT_DIV, 0x00);   // Set sample rate to 1 kHz
MOVS	R1, #0
MOVS	R0, #25
BL	_writeByte+0
;clicker_2_STM32.c,167 :: 		writeByte(GYRO_CONFIG, 0x00);  // Set gyro full-scale to 250 degrees per second, maximum sensitivity
MOVS	R1, #0
MOVS	R0, #27
BL	_writeByte+0
;clicker_2_STM32.c,168 :: 		writeByte(ACCEL_CONFIG, 0x00); // Set accelerometer full-scale to 2 g, maximum sensitivity
MOVS	R1, #0
MOVS	R0, #28
BL	_writeByte+0
;clicker_2_STM32.c,171 :: 		writeByte(USER_CTRL, 0x40);    // Enable FIFO
MOVS	R1, #64
MOVS	R0, #106
BL	_writeByte+0
;clicker_2_STM32.c,172 :: 		writeByte(FIFO_EN, 0x78);      // Enable gyro and accelerometer sensors for FIFO  (max size 1024 bytes in MPU-6050)
MOVS	R1, #120
MOVS	R0, #35
BL	_writeByte+0
;clicker_2_STM32.c,173 :: 		Delay_ms(80);                  // Capture 80 samples
MOVW	R7, #54270
MOVT	R7, #48
NOP
NOP
L_calculateAccelAndGyroBiases12:
SUBS	R7, R7, #1
BNE	L_calculateAccelAndGyroBiases12
NOP
NOP
NOP
;clicker_2_STM32.c,176 :: 		writeByte(FIFO_EN, 0x00);             // Disable gyro and accelerometer sensors for FIFO
MOVS	R1, #0
MOVS	R0, #35
BL	_writeByte+0
;clicker_2_STM32.c,177 :: 		readBytes(FIFO_COUNTH, 2, &data_[0]); // read FIFO sample count
ADD	R0, SP, #8
MOV	R2, R0
MOVS	R1, #2
SXTH	R1, R1
MOVS	R0, #114
BL	_readBytes+0
;clicker_2_STM32.c,178 :: 		fifo_count = ((uint16_t)data_[0] << 8) | data_[1];
ADD	R2, SP, #8
LDRB	R0, [R2, #0]
LSLS	R1, R0, #8
UXTH	R1, R1
ADDS	R0, R2, #1
LDRB	R0, [R0, #0]
ORRS	R1, R0
UXTH	R1, R1
;clicker_2_STM32.c,179 :: 		packet_count = fifo_count/12;          // How many sets of full gyro and accelerometer data for averaging
MOVS	R0, #12
UDIV	R0, R1, R0
; packet_count start address is: 32 (R8)
UXTH	R8, R0
;clicker_2_STM32.c,181 :: 		for (ii = 0; ii < packet_count; ii++) {
; ii start address is: 40 (R10)
MOVW	R10, #0
; packet_count end address is: 32 (R8)
; ii end address is: 40 (R10)
UXTH	R7, R8
UXTH	R6, R10
L_calculateAccelAndGyroBiases14:
; ii start address is: 24 (R6)
; packet_count start address is: 28 (R7)
CMP	R6, R7
IT	CS
BCS	L_calculateAccelAndGyroBiases15
;clicker_2_STM32.c,182 :: 		int16_t accel_temp[3] = {0, 0, 0}, gyro_temp[3] = {0, 0, 0};
ADD	R11, SP, #20
ADD	R10, R11, #12
MOVW	R12, #lo_addr(?ICScalculateAccelAndGyroBiases_accel_temp_L1+0)
MOVT	R12, #hi_addr(?ICScalculateAccelAndGyroBiases_accel_temp_L1+0)
BL	___CC2DW+0
;clicker_2_STM32.c,184 :: 		readBytes(FIFO_R_W, 12, &data_[0]); // read data for averaging
ADD	R0, SP, #8
STR	R0, [SP, #84]
STRH	R7, [SP, #4]
STRH	R6, [SP, #6]
MOV	R2, R0
MOVS	R1, #12
SXTH	R1, R1
MOVS	R0, #116
BL	_readBytes+0
LDRH	R6, [SP, #6]
LDRH	R7, [SP, #4]
;clicker_2_STM32.c,186 :: 		accel_temp[0] = (int16_t) (((int16_t)data_[0] << 8) | data_[1]  ) ;  // Form signed 16-bit integer for each sample in FIFO
ADD	R5, SP, #20
ADD	R2, SP, #8
LDRB	R0, [R2, #0]
LSLS	R1, R0, #8
SXTH	R1, R1
ADDS	R0, R2, #1
LDRB	R0, [R0, #0]
ORR	R0, R1, R0, LSL #0
STRH	R0, [R5, #0]
;clicker_2_STM32.c,187 :: 		accel_temp[1] = (int16_t) (((int16_t)data_[2] << 8) | data_[3]  ) ;
ADDS	R2, R5, #2
LDR	R3, [SP, #84]
ADDS	R0, R3, #2
LDRB	R0, [R0, #0]
LSLS	R1, R0, #8
SXTH	R1, R1
ADDS	R0, R3, #3
LDRB	R0, [R0, #0]
ORR	R0, R1, R0, LSL #0
STRH	R0, [R2, #0]
;clicker_2_STM32.c,188 :: 		accel_temp[2] = (int16_t) (((int16_t)data_[4] << 8) | data_[5]  ) ;
ADDS	R2, R5, #4
ADDS	R0, R3, #4
LDRB	R0, [R0, #0]
LSLS	R1, R0, #8
SXTH	R1, R1
ADDS	R0, R3, #5
LDRB	R0, [R0, #0]
ORR	R0, R1, R0, LSL #0
STRH	R0, [R2, #0]
;clicker_2_STM32.c,189 :: 		gyro_temp[0]  = (int16_t) (((int16_t)data_[6] << 8) | data_[7]  ) ;
ADD	R4, SP, #26
ADDS	R0, R3, #6
LDRB	R0, [R0, #0]
LSLS	R1, R0, #8
SXTH	R1, R1
ADDS	R0, R3, #7
LDRB	R0, [R0, #0]
ORR	R0, R1, R0, LSL #0
STRH	R0, [R4, #0]
;clicker_2_STM32.c,190 :: 		gyro_temp[1]  = (int16_t) (((int16_t)data_[8] << 8) | data_[9]  ) ;
ADDS	R2, R4, #2
ADDW	R0, R3, #8
LDRB	R0, [R0, #0]
LSLS	R1, R0, #8
SXTH	R1, R1
ADDW	R0, R3, #9
LDRB	R0, [R0, #0]
ORR	R0, R1, R0, LSL #0
STRH	R0, [R2, #0]
;clicker_2_STM32.c,191 :: 		gyro_temp[2]  = (int16_t) (((int16_t)data_[10] << 8) | data_[11]) ;
ADDS	R2, R4, #4
ADDW	R0, R3, #10
LDRB	R0, [R0, #0]
LSLS	R1, R0, #8
SXTH	R1, R1
ADDW	R0, R3, #11
LDRB	R0, [R0, #0]
ORR	R0, R1, R0, LSL #0
STRH	R0, [R2, #0]
;clicker_2_STM32.c,193 :: 		accel_bias[0] += (int32_t) accel_temp[0]; // Sum individual signed 16-bit biases to get accumulated signed 32-bit biases
ADD	R3, SP, #44
LDRSH	R0, [R5, #0]
SXTH	R1, R0
LDR	R0, [R3, #0]
ADDS	R0, R0, R1
STR	R0, [R3, #0]
;clicker_2_STM32.c,194 :: 		accel_bias[1] += (int32_t) accel_temp[1];
ADDS	R2, R3, #4
ADDS	R0, R5, #2
LDRSH	R0, [R0, #0]
SXTH	R1, R0
LDR	R0, [R2, #0]
ADDS	R0, R0, R1
STR	R0, [R2, #0]
;clicker_2_STM32.c,195 :: 		accel_bias[2] += (int32_t) accel_temp[2];
ADDW	R2, R3, #8
ADDS	R0, R5, #4
LDRSH	R0, [R0, #0]
SXTH	R1, R0
LDR	R0, [R2, #0]
ADDS	R0, R0, R1
STR	R0, [R2, #0]
;clicker_2_STM32.c,196 :: 		gyro_bias[0]  += (int32_t) gyro_temp[0];
ADD	R3, SP, #32
LDRSH	R0, [R4, #0]
SXTH	R1, R0
LDR	R0, [R3, #0]
ADDS	R0, R0, R1
STR	R0, [R3, #0]
;clicker_2_STM32.c,197 :: 		gyro_bias[1]  += (int32_t) gyro_temp[1];
ADDS	R2, R3, #4
ADDS	R0, R4, #2
LDRSH	R0, [R0, #0]
SXTH	R1, R0
LDR	R0, [R2, #0]
ADDS	R0, R0, R1
STR	R0, [R2, #0]
;clicker_2_STM32.c,198 :: 		gyro_bias[2]  += (int32_t) gyro_temp[2];
ADDW	R2, R3, #8
ADDS	R0, R4, #4
LDRSH	R0, [R0, #0]
SXTH	R1, R0
LDR	R0, [R2, #0]
ADDS	R0, R0, R1
STR	R0, [R2, #0]
;clicker_2_STM32.c,181 :: 		for (ii = 0; ii < packet_count; ii++) {
ADDS	R0, R6, #1
; ii end address is: 24 (R6)
; ii start address is: 40 (R10)
UXTH	R10, R0
;clicker_2_STM32.c,199 :: 		}
; ii end address is: 40 (R10)
UXTH	R6, R10
IT	AL
BAL	L_calculateAccelAndGyroBiases14
L_calculateAccelAndGyroBiases15:
;clicker_2_STM32.c,201 :: 		accel_bias[0] /= (int32_t) packet_count; // Normalize sums to get average count biases
ADD	R4, SP, #44
UXTH	R1, R7
LDR	R0, [R4, #0]
SDIV	R0, R0, R1
STR	R0, [R4, #0]
;clicker_2_STM32.c,202 :: 		accel_bias[1] /= (int32_t) packet_count;
ADDS	R2, R4, #4
UXTH	R1, R7
LDR	R0, [R2, #0]
SDIV	R0, R0, R1
STR	R0, [R2, #0]
;clicker_2_STM32.c,203 :: 		accel_bias[2] /= (int32_t) packet_count;
ADDW	R2, R4, #8
UXTH	R1, R7
LDR	R0, [R2, #0]
SDIV	R0, R0, R1
STR	R0, [R2, #0]
;clicker_2_STM32.c,204 :: 		gyro_bias[0]  /= (int32_t) packet_count;
ADD	R3, SP, #32
UXTH	R1, R7
LDR	R0, [R3, #0]
SDIV	R0, R0, R1
STR	R0, [R3, #0]
;clicker_2_STM32.c,205 :: 		gyro_bias[1]  /= (int32_t) packet_count;
ADDS	R2, R3, #4
UXTH	R1, R7
LDR	R0, [R2, #0]
SDIV	R0, R0, R1
STR	R0, [R2, #0]
;clicker_2_STM32.c,206 :: 		gyro_bias[2]  /= (int32_t) packet_count;
ADDW	R2, R3, #8
UXTH	R1, R7
; packet_count end address is: 28 (R7)
LDR	R0, [R2, #0]
SDIV	R0, R0, R1
STR	R0, [R2, #0]
;clicker_2_STM32.c,208 :: 		if(accel_bias[2] > 0L) {accel_bias[2] -= (int32_t) accelsensitivity;}  // Remove gravity from the z-axis accelerometer bias calculation
ADDW	R0, R4, #8
LDR	R0, [R0, #0]
CMP	R0, #0
IT	LE
BLE	L_calculateAccelAndGyroBiases17
ADD	R0, SP, #44
ADDW	R2, R0, #8
LDRH	R1, [SP, #56]
LDR	R0, [R2, #0]
SUB	R0, R0, R1
STR	R0, [R2, #0]
IT	AL
BAL	L_calculateAccelAndGyroBiases18
L_calculateAccelAndGyroBiases17:
;clicker_2_STM32.c,209 :: 		else {accel_bias[2] += (int32_t) accelsensitivity;}
ADD	R0, SP, #44
ADDW	R2, R0, #8
LDRH	R1, [SP, #56]
LDR	R0, [R2, #0]
ADDS	R0, R0, R1
STR	R0, [R2, #0]
L_calculateAccelAndGyroBiases18:
;clicker_2_STM32.c,212 :: 		data_[0] = (-gyro_bias[0]/4  >> 8) & 0xFF; // Divide by 4 to get 32.9 LSB per deg/s to conform to expected bias input format
ADD	R3, SP, #8
STR	R3, [SP, #84]
ADD	R2, SP, #32
LDR	R0, [R2, #0]
RSBS	R0, R0, #0
ASRS	R0, R0, #2
ASRS	R0, R0, #8
AND	R0, R0, #255
STRB	R0, [R3, #0]
;clicker_2_STM32.c,213 :: 		data_[1] = (-gyro_bias[0]/4)       & 0xFF; // Biases are additive, so change sign on calculated average gyro biases
ADDS	R1, R3, #1
LDR	R0, [R2, #0]
RSBS	R0, R0, #0
ASRS	R0, R0, #2
AND	R0, R0, #255
STRB	R0, [R1, #0]
;clicker_2_STM32.c,214 :: 		data_[2] = (-gyro_bias[1]/4  >> 8) & 0xFF;
ADDS	R1, R3, #2
ADDS	R0, R2, #4
LDR	R0, [R0, #0]
RSBS	R0, R0, #0
ASRS	R0, R0, #2
ASRS	R0, R0, #8
AND	R0, R0, #255
STRB	R0, [R1, #0]
;clicker_2_STM32.c,215 :: 		data_[3] = (-gyro_bias[1]/4)       & 0xFF;
ADDS	R1, R3, #3
ADDS	R0, R2, #4
LDR	R0, [R0, #0]
RSBS	R0, R0, #0
ASRS	R0, R0, #2
AND	R0, R0, #255
STRB	R0, [R1, #0]
;clicker_2_STM32.c,216 :: 		data_[4] = (-gyro_bias[2]/4  >> 8) & 0xFF;
ADDS	R1, R3, #4
ADDW	R0, R2, #8
LDR	R0, [R0, #0]
RSBS	R0, R0, #0
ASRS	R0, R0, #2
ASRS	R0, R0, #8
AND	R0, R0, #255
STRB	R0, [R1, #0]
;clicker_2_STM32.c,217 :: 		data_[5] = (-gyro_bias[2]/4)       & 0xFF;
ADDS	R1, R3, #5
ADDW	R0, R2, #8
LDR	R0, [R0, #0]
RSBS	R0, R0, #0
ASRS	R0, R0, #2
AND	R0, R0, #255
STRB	R0, [R1, #0]
;clicker_2_STM32.c,219 :: 		bgx = (float) gyro_bias[0]/(float) gyrosensitivity; // construct gyro bias in deg/s for later manual subtraction
LDR	R0, [R2, #0]
VMOV	S0, R0
VCVT.F32	#1, S0, S0
LDRH	R0, [SP, #58]
VMOV	S1, R0
VCVT.F32	#0, S1, S1
VDIV.F32	S0, S0, S1
MOVW	R0, #lo_addr(_bgx+0)
MOVT	R0, #hi_addr(_bgx+0)
VSTR	#1, S0, [R0, #0]
;clicker_2_STM32.c,220 :: 		bgy = (float) gyro_bias[1]/(float) gyrosensitivity;
ADDS	R0, R2, #4
LDR	R0, [R0, #0]
VMOV	S0, R0
VCVT.F32	#1, S0, S0
VDIV.F32	S0, S0, S1
MOVW	R0, #lo_addr(_bgy+0)
MOVT	R0, #hi_addr(_bgy+0)
VSTR	#1, S0, [R0, #0]
;clicker_2_STM32.c,221 :: 		bgz = (float) gyro_bias[2]/(float) gyrosensitivity;
ADDW	R0, R2, #8
LDR	R0, [R0, #0]
VMOV	S0, R0
VCVT.F32	#1, S0, S0
VDIV.F32	S0, S0, S1
MOVW	R0, #lo_addr(_bgz+0)
MOVT	R0, #hi_addr(_bgz+0)
VSTR	#1, S0, [R0, #0]
;clicker_2_STM32.c,230 :: 		readBytes(XA_OFFSET_H, 2, &data_[0]); // Read factory accelerometer trim values
MOV	R2, R3
MOVS	R1, #2
SXTH	R1, R1
MOVS	R0, #6
BL	_readBytes+0
;clicker_2_STM32.c,231 :: 		accel_bias_reg[0] = (int16_t) ((int16_t)data_[0] << 8) | data_[1];
ADD	R3, SP, #60
ADD	R2, SP, #8
LDRB	R0, [R2, #0]
LSLS	R1, R0, #8
SXTH	R1, R1
ADDS	R0, R2, #1
LDRB	R0, [R0, #0]
ORR	R0, R1, R0, LSL #0
SXTH	R0, R0
STR	R0, [R3, #0]
;clicker_2_STM32.c,232 :: 		readBytes(YA_OFFSET_H, 2, &data_[0]);
LDR	R0, [SP, #84]
MOV	R2, R0
MOVS	R1, #2
SXTH	R1, R1
MOVS	R0, #8
BL	_readBytes+0
;clicker_2_STM32.c,233 :: 		accel_bias_reg[1] = (int16_t) ((int16_t)data_[0] << 8) | data_[1];
ADD	R0, SP, #60
ADDS	R3, R0, #4
ADD	R2, SP, #8
LDRB	R0, [R2, #0]
LSLS	R1, R0, #8
SXTH	R1, R1
ADDS	R0, R2, #1
LDRB	R0, [R0, #0]
ORR	R0, R1, R0, LSL #0
SXTH	R0, R0
STR	R0, [R3, #0]
;clicker_2_STM32.c,234 :: 		readBytes(ZA_OFFSET_H, 2, &data_[0]);
LDR	R0, [SP, #84]
MOV	R2, R0
MOVS	R1, #2
SXTH	R1, R1
MOVS	R0, #10
BL	_readBytes+0
;clicker_2_STM32.c,235 :: 		accel_bias_reg[2] = (int16_t) ((int16_t)data_[0] << 8) | data_[1];
ADD	R0, SP, #60
ADDW	R3, R0, #8
ADD	R2, SP, #8
LDRB	R0, [R2, #0]
LSLS	R1, R0, #8
SXTH	R1, R1
ADDS	R0, R2, #1
LDRB	R0, [R0, #0]
ORR	R0, R1, R0, LSL #0
SXTH	R0, R0
STR	R0, [R3, #0]
;clicker_2_STM32.c,237 :: 		for(ii = 0; ii < 3; ii++) {
; ii start address is: 12 (R3)
MOVS	R3, #0
; ii end address is: 12 (R3)
UXTH	R2, R3
L_calculateAccelAndGyroBiases19:
; ii start address is: 8 (R2)
CMP	R2, #3
IT	CS
BCS	L_calculateAccelAndGyroBiases20
;clicker_2_STM32.c,238 :: 		if(accel_bias_reg[ii] & mask) mask_bit[ii] = 0x01; // If temperature compensation bit is set, record that fact in mask_bit
ADD	R1, SP, #60
LSLS	R0, R2, #2
ADDS	R0, R1, R0
LDR	R1, [R0, #0]
LDR	R0, [SP, #72]
AND	R0, R1, R0, LSL #0
CMP	R0, #0
IT	EQ
BEQ	L_calculateAccelAndGyroBiases22
ADD	R0, SP, #76
ADDS	R1, R0, R2
MOVS	R0, #1
STRB	R0, [R1, #0]
L_calculateAccelAndGyroBiases22:
;clicker_2_STM32.c,237 :: 		for(ii = 0; ii < 3; ii++) {
ADDS	R0, R2, #1
; ii end address is: 8 (R2)
; ii start address is: 12 (R3)
UXTH	R3, R0
;clicker_2_STM32.c,239 :: 		}
UXTH	R2, R3
; ii end address is: 12 (R3)
IT	AL
BAL	L_calculateAccelAndGyroBiases19
L_calculateAccelAndGyroBiases20:
;clicker_2_STM32.c,242 :: 		accel_bias_reg[0] -= (accel_bias[0]/8); // Subtract calculated averaged accelerometer bias scaled to 2048 LSB/g (16 g full scale)
ADD	R6, SP, #60
ADD	R5, SP, #44
LDR	R0, [R5, #0]
ASRS	R1, R0, #3
LDR	R0, [R6, #0]
SUB	R0, R0, R1
STR	R0, [R6, #0]
;clicker_2_STM32.c,243 :: 		accel_bias_reg[1] -= (accel_bias[1]/8);
ADDS	R2, R6, #4
ADDS	R0, R5, #4
LDR	R0, [R0, #0]
ASRS	R1, R0, #3
LDR	R0, [R2, #0]
SUB	R0, R0, R1
STR	R0, [R2, #0]
;clicker_2_STM32.c,244 :: 		accel_bias_reg[2] -= (accel_bias[2]/8);
ADDW	R2, R6, #8
ADDW	R0, R5, #8
LDR	R0, [R0, #0]
ASRS	R1, R0, #3
LDR	R0, [R2, #0]
SUB	R0, R0, R1
STR	R0, [R2, #0]
;clicker_2_STM32.c,246 :: 		data_[0] = (accel_bias_reg[0] >> 8) & 0xFF;
ADD	R4, SP, #8
LDR	R0, [R6, #0]
ASRS	R0, R0, #8
AND	R0, R0, #255
STRB	R0, [R4, #0]
;clicker_2_STM32.c,247 :: 		data_[1] = (accel_bias_reg[0])      & 0xFF;
ADDS	R1, R4, #1
LDR	R0, [R6, #0]
AND	R0, R0, #255
STRB	R0, [R1, #0]
;clicker_2_STM32.c,248 :: 		data_[1] = data_[1] | mask_bit[0]; // preserve temperature compensation bit when writing back to accelerometer bias registers
ADDS	R2, R4, #1
LDRB	R1, [R2, #0]
ADD	R3, SP, #76
LDRB	R0, [R3, #0]
ORR	R0, R1, R0, LSL #0
STRB	R0, [R2, #0]
;clicker_2_STM32.c,249 :: 		data_[2] = (accel_bias_reg[1] >> 8) & 0xFF;
ADDS	R1, R4, #2
ADDS	R0, R6, #4
LDR	R0, [R0, #0]
ASRS	R0, R0, #8
AND	R0, R0, #255
STRB	R0, [R1, #0]
;clicker_2_STM32.c,250 :: 		data_[3] = (accel_bias_reg[1])      & 0xFF;
ADDS	R1, R4, #3
ADDS	R0, R6, #4
LDR	R0, [R0, #0]
AND	R0, R0, #255
STRB	R0, [R1, #0]
;clicker_2_STM32.c,251 :: 		data_[3] = data_[3] | mask_bit[1]; // preserve temperature compensation bit when writing back to accelerometer bias registers
ADDS	R2, R4, #3
LDRB	R1, [R2, #0]
ADDS	R0, R3, #1
LDRB	R0, [R0, #0]
ORR	R0, R1, R0, LSL #0
STRB	R0, [R2, #0]
;clicker_2_STM32.c,252 :: 		data_[4] = (accel_bias_reg[2] >> 8) & 0xFF;
ADDS	R1, R4, #4
ADDW	R0, R6, #8
LDR	R0, [R0, #0]
ASRS	R0, R0, #8
AND	R0, R0, #255
STRB	R0, [R1, #0]
;clicker_2_STM32.c,253 :: 		data_[5] = (accel_bias_reg[2])      & 0xFF;
ADDS	R1, R4, #5
ADDW	R0, R6, #8
LDR	R0, [R0, #0]
AND	R0, R0, #255
STRB	R0, [R1, #0]
;clicker_2_STM32.c,254 :: 		data_[5] = data_[5] | mask_bit[2]; // preserve temperature compensation bit when writing back to accelerometer bias registers
ADDS	R2, R4, #5
LDRB	R1, [R2, #0]
ADDS	R0, R3, #2
LDRB	R0, [R0, #0]
ORR	R0, R1, R0, LSL #0
STRB	R0, [R2, #0]
;clicker_2_STM32.c,258 :: 		bax = (float)accel_bias[0]/(float)accelsensitivity;
LDR	R0, [R5, #0]
VMOV	S0, R0
VCVT.F32	#1, S0, S0
LDRH	R0, [SP, #56]
VMOV	S1, R0
VCVT.F32	#0, S1, S1
VDIV.F32	S0, S0, S1
MOVW	R0, #lo_addr(_bax+0)
MOVT	R0, #hi_addr(_bax+0)
VSTR	#1, S0, [R0, #0]
;clicker_2_STM32.c,259 :: 		bay = (float)accel_bias[1]/(float)accelsensitivity;
ADDS	R0, R5, #4
LDR	R0, [R0, #0]
VMOV	S0, R0
VCVT.F32	#1, S0, S0
VDIV.F32	S0, S0, S1
MOVW	R0, #lo_addr(_bay+0)
MOVT	R0, #hi_addr(_bay+0)
VSTR	#1, S0, [R0, #0]
;clicker_2_STM32.c,260 :: 		baz = (float)accel_bias[2]/(float)accelsensitivity;
ADDW	R0, R5, #8
LDR	R0, [R0, #0]
VMOV	S0, R0
VCVT.F32	#1, S0, S0
VDIV.F32	S0, S0, S1
MOVW	R0, #lo_addr(_baz+0)
MOVT	R0, #hi_addr(_baz+0)
VSTR	#1, S0, [R0, #0]
;clicker_2_STM32.c,261 :: 		}
L_end_calculateAccelAndGyroBiases:
LDR	LR, [SP, #0]
ADD	SP, SP, #88
BX	LR
; end of _calculateAccelAndGyroBiases
_main:
;clicker_2_STM32.c,263 :: 		void main() {
;clicker_2_STM32.c,265 :: 		GPIO_Digital_Output(&GPIOE_BASE, _GPIO_PINMASK_12 | _GPIO_PINMASK_15);
MOVW	R1, #36864
MOVW	R0, #lo_addr(GPIOE_BASE+0)
MOVT	R0, #hi_addr(GPIOE_BASE+0)
BL	_GPIO_Digital_Output+0
;clicker_2_STM32.c,266 :: 		LD1 = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(ODR12_GPIOE_ODR_bit+0)
MOVT	R0, #hi_addr(ODR12_GPIOE_ODR_bit+0)
STR	R1, [R0, #0]
;clicker_2_STM32.c,267 :: 		LD2 = 0;
MOVW	R0, #lo_addr(ODR15_GPIOE_ODR_bit+0)
MOVT	R0, #hi_addr(ODR15_GPIOE_ODR_bit+0)
STR	R1, [R0, #0]
;clicker_2_STM32.c,269 :: 		init_uart4();
BL	_init_uart4+0
;clicker_2_STM32.c,270 :: 		init_i2c2();
BL	_init_i2c2+0
;clicker_2_STM32.c,272 :: 		if (checkMPU6050() == 1) {
BL	_checkMPU6050+0
CMP	R0, #1
IT	NE
BNE	L_main23
;clicker_2_STM32.c,273 :: 		return;
IT	AL
BAL	L_end_main
;clicker_2_STM32.c,274 :: 		}
L_main23:
;clicker_2_STM32.c,276 :: 		if (selfTestMPU6050() == 1) {
BL	_selfTestMPU6050+0
CMP	R0, #1
IT	NE
BNE	L_main24
;clicker_2_STM32.c,277 :: 		return;
IT	AL
BAL	L_end_main
;clicker_2_STM32.c,278 :: 		}
L_main24:
;clicker_2_STM32.c,280 :: 		calculateAccelAndGyroBiases();
BL	_calculateAccelAndGyroBiases+0
;clicker_2_STM32.c,282 :: 		LD1 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(ODR12_GPIOE_ODR_bit+0)
MOVT	R0, #hi_addr(ODR12_GPIOE_ODR_bit+0)
STR	R1, [R0, #0]
;clicker_2_STM32.c,283 :: 		LD2 = 1;
MOVW	R0, #lo_addr(ODR15_GPIOE_ODR_bit+0)
MOVT	R0, #hi_addr(ODR15_GPIOE_ODR_bit+0)
STR	R1, [R0, #0]
;clicker_2_STM32.c,284 :: 		while(1);
L_main25:
IT	AL
BAL	L_main25
;clicker_2_STM32.c,285 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
