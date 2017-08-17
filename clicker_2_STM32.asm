_init_uart4:
;clicker_2_STM32.c,61 :: 		void init_uart4() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;clicker_2_STM32.c,62 :: 		UART4_Init_Advanced(9600, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_UART4_PA01);
MOVW	R0, #lo_addr(__GPIO_MODULE_UART4_PA01+0)
MOVT	R0, #hi_addr(__GPIO_MODULE_UART4_PA01+0)
PUSH	(R0)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
MOVW	R0, #9600
BL	_UART4_Init_Advanced+0
ADD	SP, SP, #4
;clicker_2_STM32.c,63 :: 		Delay_ms(200);
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
;clicker_2_STM32.c,64 :: 		}
L_end_init_uart4:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _init_uart4
_init_i2c2:
;clicker_2_STM32.c,67 :: 		void init_i2c2() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;clicker_2_STM32.c,68 :: 		I2C2_Init_Advanced(100000, &_GPIO_MODULE_I2C2_PB10_11);
MOVW	R1, #lo_addr(__GPIO_MODULE_I2C2_PB10_11+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_I2C2_PB10_11+0)
MOVW	R0, #34464
MOVT	R0, #1
BL	_I2C2_Init_Advanced+0
;clicker_2_STM32.c,69 :: 		}
L_end_init_i2c2:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _init_i2c2
_readByte:
;clicker_2_STM32.c,71 :: 		unsigned char readByte(unsigned char registerAddress) {
; registerAddress start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; registerAddress end address is: 0 (R0)
; registerAddress start address is: 0 (R0)
;clicker_2_STM32.c,73 :: 		read_data[0] = registerAddress;
ADD	R1, SP, #4
STRB	R0, [R1, #0]
; registerAddress end address is: 0 (R0)
;clicker_2_STM32.c,75 :: 		I2C2_Start();
BL	_I2C2_Start+0
;clicker_2_STM32.c,76 :: 		I2C2_Write(MPU6050_ADDRESS, read_data, 1, END_MODE_RESTART);
ADD	R1, SP, #4
MOVW	R3, #0
MOVS	R2, #1
MOVS	R0, #104
BL	_I2C2_Write+0
;clicker_2_STM32.c,77 :: 		I2C2_Read(MPU6050_ADDRESS, read_data, 1, END_MODE_STOP);
ADD	R1, SP, #4
MOVW	R3, #1
MOVS	R2, #1
MOVS	R0, #104
BL	_I2C2_Read+0
;clicker_2_STM32.c,79 :: 		return read_data[0];
ADD	R1, SP, #4
LDRB	R1, [R1, #0]
UXTB	R0, R1
;clicker_2_STM32.c,80 :: 		}
L_end_readByte:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _readByte
_readBytes:
;clicker_2_STM32.c,82 :: 		void readBytes(unsigned char registerAddress, int count, unsigned char *buffer) {
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
;clicker_2_STM32.c,83 :: 		buffer[0] = registerAddress;
STRB	R0, [R11, #0]
; registerAddress end address is: 0 (R0)
;clicker_2_STM32.c,85 :: 		I2C2_Start();
BL	_I2C2_Start+0
;clicker_2_STM32.c,86 :: 		I2C2_Write(MPU6050_ADDRESS, buffer, 1, END_MODE_RESTART);
MOVW	R3, #0
MOVS	R2, #1
MOV	R1, R11
MOVS	R0, #104
BL	_I2C2_Write+0
;clicker_2_STM32.c,87 :: 		I2C2_Read(MPU6050_ADDRESS, buffer, count, END_MODE_STOP);
MOVW	R3, #1
SXTH	R2, R10
; count end address is: 40 (R10)
MOV	R1, R11
; buffer end address is: 44 (R11)
MOVS	R0, #104
BL	_I2C2_Read+0
;clicker_2_STM32.c,88 :: 		}
L_end_readBytes:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _readBytes
_writeByte:
;clicker_2_STM32.c,90 :: 		void writeByte(unsigned char registerAddress, unsigned char byte){
; byte start address is: 4 (R1)
; registerAddress start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; byte end address is: 4 (R1)
; registerAddress end address is: 0 (R0)
; registerAddress start address is: 0 (R0)
; byte start address is: 4 (R1)
;clicker_2_STM32.c,92 :: 		write_data[0] = registerAddress;
ADD	R2, SP, #4
STRB	R0, [R2, #0]
; registerAddress end address is: 0 (R0)
;clicker_2_STM32.c,93 :: 		write_data[1] = byte;
ADDS	R2, R2, #1
STRB	R1, [R2, #0]
; byte end address is: 4 (R1)
;clicker_2_STM32.c,95 :: 		I2C2_Start();
BL	_I2C2_Start+0
;clicker_2_STM32.c,96 :: 		I2C2_Write(MPU6050_ADDRESS, write_data, 2, END_MODE_STOP);
ADD	R2, SP, #4
MOVW	R3, #1
MOV	R1, R2
MOVS	R2, #2
MOVS	R0, #104
BL	_I2C2_Write+0
;clicker_2_STM32.c,97 :: 		}
L_end_writeByte:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _writeByte
_getGres:
;clicker_2_STM32.c,100 :: 		float getGres() {
;clicker_2_STM32.c,101 :: 		switch (Gscale) {
IT	AL
BAL	L_getGres2
;clicker_2_STM32.c,102 :: 		case GFS_250DPS: return 250.0/32768.0;
L_getGres4:
MOVW	R0, #0
MOVT	R0, #15354
VMOV	S0, R0
IT	AL
BAL	L_end_getGres
;clicker_2_STM32.c,103 :: 		case GFS_500DPS: return 500.0/32768.0;
L_getGres5:
MOVW	R0, #0
MOVT	R0, #15482
VMOV	S0, R0
IT	AL
BAL	L_end_getGres
;clicker_2_STM32.c,104 :: 		case GFS_1000DPS: return 1000.0/32768.0;
L_getGres6:
MOVW	R0, #0
MOVT	R0, #15610
VMOV	S0, R0
IT	AL
BAL	L_end_getGres
;clicker_2_STM32.c,105 :: 		case GFS_2000DPS: return 2000.0/32768.0;
L_getGres7:
MOVW	R0, #0
MOVT	R0, #15738
VMOV	S0, R0
IT	AL
BAL	L_end_getGres
;clicker_2_STM32.c,106 :: 		}
L_getGres2:
MOVW	R0, #lo_addr(_Gscale+0)
MOVT	R0, #hi_addr(_Gscale+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_getGres4
MOVW	R0, #lo_addr(_Gscale+0)
MOVT	R0, #hi_addr(_Gscale+0)
LDRSH	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_getGres5
MOVW	R0, #lo_addr(_Gscale+0)
MOVT	R0, #hi_addr(_Gscale+0)
LDRSH	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_getGres6
MOVW	R0, #lo_addr(_Gscale+0)
MOVT	R0, #hi_addr(_Gscale+0)
LDRSH	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L_getGres7
;clicker_2_STM32.c,107 :: 		}
L_end_getGres:
BX	LR
; end of _getGres
_getAres:
;clicker_2_STM32.c,110 :: 		float getAres() {
;clicker_2_STM32.c,111 :: 		switch (Ascale){
IT	AL
BAL	L_getAres8
;clicker_2_STM32.c,112 :: 		case AFS_2G: return 2.0/32768.0;
L_getAres10:
MOV	R0, #947912704
VMOV	S0, R0
IT	AL
BAL	L_end_getAres
;clicker_2_STM32.c,113 :: 		case AFS_4G: return 4.0/32768.0;
L_getAres11:
MOV	R0, #956301312
VMOV	S0, R0
IT	AL
BAL	L_end_getAres
;clicker_2_STM32.c,114 :: 		case AFS_8G: return 8.0/32768.0;
L_getAres12:
MOV	R0, #964689920
VMOV	S0, R0
IT	AL
BAL	L_end_getAres
;clicker_2_STM32.c,115 :: 		case AFS_16G: return 16.0/32768.0;
L_getAres13:
MOV	R0, #973078528
VMOV	S0, R0
IT	AL
BAL	L_end_getAres
;clicker_2_STM32.c,116 :: 		}
L_getAres8:
MOVW	R0, #lo_addr(_Ascale+0)
MOVT	R0, #hi_addr(_Ascale+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_getAres10
MOVW	R0, #lo_addr(_Ascale+0)
MOVT	R0, #hi_addr(_Ascale+0)
LDRSH	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_getAres11
MOVW	R0, #lo_addr(_Ascale+0)
MOVT	R0, #hi_addr(_Ascale+0)
LDRSH	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_getAres12
MOVW	R0, #lo_addr(_Ascale+0)
MOVT	R0, #hi_addr(_Ascale+0)
LDRSH	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L_getAres13
;clicker_2_STM32.c,117 :: 		}
L_end_getAres:
BX	LR
; end of _getAres
_readAccelData:
;clicker_2_STM32.c,120 :: 		void readAccelData(float * destination){
; destination start address is: 0 (R0)
SUB	SP, SP, #28
STR	LR, [SP, #0]
MOV	R12, R0
; destination end address is: 0 (R0)
; destination start address is: 48 (R12)
;clicker_2_STM32.c,124 :: 		readBytes(ACCEL_XOUT_H, 6, &rawData[0]);                   // Read the six raw data registers into data array
ADD	R1, SP, #4
STR	R1, [SP, #16]
MOV	R2, R1
MOVS	R1, #6
SXTH	R1, R1
MOVS	R0, #59
BL	_readBytes+0
;clicker_2_STM32.c,126 :: 		temp[0] = (int16_t)((rawData[0] << 8) | rawData[1]) ;      // Turn the MSB and LSB into a signed 16-bit value
ADD	R5, SP, #10
STR	R5, [SP, #24]
ADD	R3, SP, #4
LDRB	R1, [R3, #0]
LSLS	R2, R1, #8
UXTH	R2, R2
ADDS	R1, R3, #1
LDRB	R1, [R1, #0]
ORR	R1, R2, R1, LSL #0
SXTH	R1, R1
STRH	R1, [R5, #0]
;clicker_2_STM32.c,127 :: 		temp[1] = (int16_t)((rawData[2] << 8) | rawData[3]) ;
ADDS	R3, R5, #2
LDR	R4, [SP, #16]
ADDS	R1, R4, #2
LDRB	R1, [R1, #0]
LSLS	R2, R1, #8
UXTH	R2, R2
ADDS	R1, R4, #3
LDRB	R1, [R1, #0]
ORR	R1, R2, R1, LSL #0
SXTH	R1, R1
STRH	R1, [R3, #0]
;clicker_2_STM32.c,128 :: 		temp[2] = (int16_t)((rawData[4] << 8) | rawData[5]) ;
ADDS	R3, R5, #4
ADDS	R1, R4, #4
LDRB	R1, [R1, #0]
LSLS	R2, R1, #8
UXTH	R2, R2
ADDS	R1, R4, #5
LDRB	R1, [R1, #0]
ORR	R1, R2, R1, LSL #0
SXTH	R1, R1
STRH	R1, [R3, #0]
;clicker_2_STM32.c,130 :: 		destination[0] = ((float)temp[0]*getAres() - bax) * 9.81;  // Get accel value in m/s2, this depends on scale being set
MOV	R1, R12
STR	R1, [SP, #20]
LDRSH	R1, [R5, #0]
VMOV	S0, R1
VCVT.F32	#1, S0, S0
VSTR	#1, S0, [SP, #16]
BL	_getAres+0
VLDR	#1, S1, [SP, #16]
VMUL.F32	S1, S1, S0
MOVW	R1, #lo_addr(_bax+0)
MOVT	R1, #hi_addr(_bax+0)
VLDR	#1, S0, [R1, #0]
VSUB.F32	S1, S1, S0
MOVW	R1, #62915
MOVT	R1, #16668
VMOV	S0, R1
VMUL.F32	S0, S1, S0
LDR	R1, [SP, #20]
VSTR	#1, S0, [R1, #0]
;clicker_2_STM32.c,131 :: 		destination[1] = ((float)temp[1]*getAres() - bay) * 9.81;
ADD	R2, R12, #4
LDR	R1, [SP, #24]
STR	R2, [SP, #20]
ADDS	R1, R1, #2
LDRSH	R1, [R1, #0]
VMOV	S0, R1
VCVT.F32	#1, S0, S0
VSTR	#1, S0, [SP, #16]
BL	_getAres+0
VLDR	#1, S1, [SP, #16]
VMUL.F32	S1, S1, S0
MOVW	R1, #lo_addr(_bay+0)
MOVT	R1, #hi_addr(_bay+0)
VLDR	#1, S0, [R1, #0]
VSUB.F32	S1, S1, S0
MOVW	R1, #62915
MOVT	R1, #16668
VMOV	S0, R1
VMUL.F32	S0, S1, S0
LDR	R1, [SP, #20]
VSTR	#1, S0, [R1, #0]
;clicker_2_STM32.c,132 :: 		destination[2] = ((float)temp[2]*getAres() - baz) * 9.81;
ADD	R2, R12, #8
; destination end address is: 48 (R12)
LDR	R1, [SP, #24]
STR	R2, [SP, #20]
ADDS	R1, R1, #4
LDRSH	R1, [R1, #0]
VMOV	S0, R1
VCVT.F32	#1, S0, S0
VSTR	#1, S0, [SP, #16]
BL	_getAres+0
VLDR	#1, S1, [SP, #16]
VMUL.F32	S1, S1, S0
MOVW	R1, #lo_addr(_baz+0)
MOVT	R1, #hi_addr(_baz+0)
VLDR	#1, S0, [R1, #0]
VSUB.F32	S1, S1, S0
MOVW	R1, #62915
MOVT	R1, #16668
VMOV	S0, R1
VMUL.F32	S0, S1, S0
LDR	R1, [SP, #20]
VSTR	#1, S0, [R1, #0]
;clicker_2_STM32.c,133 :: 		}
L_end_readAccelData:
LDR	LR, [SP, #0]
ADD	SP, SP, #28
BX	LR
; end of _readAccelData
_readGyroData:
;clicker_2_STM32.c,136 :: 		void readGyroData(float * destination){
; destination start address is: 0 (R0)
SUB	SP, SP, #28
STR	LR, [SP, #0]
MOV	R12, R0
; destination end address is: 0 (R0)
; destination start address is: 48 (R12)
;clicker_2_STM32.c,140 :: 		readBytes(GYRO_XOUT_H, 6, &rawData[0]);                    // Read the six raw data registers sequentially into data array
ADD	R1, SP, #4
STR	R1, [SP, #16]
MOV	R2, R1
MOVS	R1, #6
SXTH	R1, R1
MOVS	R0, #67
BL	_readBytes+0
;clicker_2_STM32.c,142 :: 		temp[0] = (int16_t)((rawData[0] << 8) | rawData[1]) ;      // Turn the MSB and LSB into a signed 16-bit value
ADD	R5, SP, #10
STR	R5, [SP, #24]
ADD	R3, SP, #4
LDRB	R1, [R3, #0]
LSLS	R2, R1, #8
UXTH	R2, R2
ADDS	R1, R3, #1
LDRB	R1, [R1, #0]
ORR	R1, R2, R1, LSL #0
SXTH	R1, R1
STRH	R1, [R5, #0]
;clicker_2_STM32.c,143 :: 		temp[1] = (int16_t)((rawData[2] << 8) | rawData[3]) ;
ADDS	R3, R5, #2
LDR	R4, [SP, #16]
ADDS	R1, R4, #2
LDRB	R1, [R1, #0]
LSLS	R2, R1, #8
UXTH	R2, R2
ADDS	R1, R4, #3
LDRB	R1, [R1, #0]
ORR	R1, R2, R1, LSL #0
SXTH	R1, R1
STRH	R1, [R3, #0]
;clicker_2_STM32.c,144 :: 		temp[2] = (int16_t)((rawData[4] << 8) | rawData[5]) ;
ADDS	R3, R5, #4
ADDS	R1, R4, #4
LDRB	R1, [R1, #0]
LSLS	R2, R1, #8
UXTH	R2, R2
ADDS	R1, R4, #5
LDRB	R1, [R1, #0]
ORR	R1, R2, R1, LSL #0
SXTH	R1, R1
STRH	R1, [R3, #0]
;clicker_2_STM32.c,146 :: 		destination[0] = (float)temp[0]*getGres() - bgx;           // Get gyro value in degrees per second, this depends on scale being set
MOV	R1, R12
STR	R1, [SP, #20]
LDRSH	R1, [R5, #0]
VMOV	S0, R1
VCVT.F32	#1, S0, S0
VSTR	#1, S0, [SP, #16]
BL	_getGres+0
VLDR	#1, S1, [SP, #16]
VMUL.F32	S1, S1, S0
MOVW	R1, #lo_addr(_bgx+0)
MOVT	R1, #hi_addr(_bgx+0)
VLDR	#1, S0, [R1, #0]
VSUB.F32	S0, S1, S0
LDR	R1, [SP, #20]
VSTR	#1, S0, [R1, #0]
;clicker_2_STM32.c,147 :: 		destination[1] = (float)temp[1]*getGres() - bgy;
ADD	R2, R12, #4
LDR	R1, [SP, #24]
STR	R2, [SP, #20]
ADDS	R1, R1, #2
LDRSH	R1, [R1, #0]
VMOV	S0, R1
VCVT.F32	#1, S0, S0
VSTR	#1, S0, [SP, #16]
BL	_getGres+0
VLDR	#1, S1, [SP, #16]
VMUL.F32	S1, S1, S0
MOVW	R1, #lo_addr(_bgy+0)
MOVT	R1, #hi_addr(_bgy+0)
VLDR	#1, S0, [R1, #0]
VSUB.F32	S0, S1, S0
LDR	R1, [SP, #20]
VSTR	#1, S0, [R1, #0]
;clicker_2_STM32.c,148 :: 		destination[2] = (float)temp[2]*getGres() - bgz;
ADD	R2, R12, #8
; destination end address is: 48 (R12)
LDR	R1, [SP, #24]
STR	R2, [SP, #20]
ADDS	R1, R1, #4
LDRSH	R1, [R1, #0]
VMOV	S0, R1
VCVT.F32	#1, S0, S0
VSTR	#1, S0, [SP, #16]
BL	_getGres+0
VLDR	#1, S1, [SP, #16]
VMUL.F32	S1, S1, S0
MOVW	R1, #lo_addr(_bgz+0)
MOVT	R1, #hi_addr(_bgz+0)
VLDR	#1, S0, [R1, #0]
VSUB.F32	S0, S1, S0
LDR	R1, [SP, #20]
VSTR	#1, S0, [R1, #0]
;clicker_2_STM32.c,149 :: 		}
L_end_readGyroData:
LDR	LR, [SP, #0]
ADD	SP, SP, #28
BX	LR
; end of _readGyroData
_checkMPU6050:
;clicker_2_STM32.c,156 :: 		int checkMPU6050() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;clicker_2_STM32.c,157 :: 		if (readByte(WHO_AM_I) !=  'h') { // Ascii for 'h' is 0x68
MOVS	R0, #117
BL	_readByte+0
CMP	R0, #104
IT	EQ
BEQ	L_checkMPU605014
;clicker_2_STM32.c,158 :: 		UART4_Write_Text("Failed to read 'WHO AM I' from MPU6050\r\n");
MOVW	R0, #lo_addr(?lstr1_clicker_2_STM32+0)
MOVT	R0, #hi_addr(?lstr1_clicker_2_STM32+0)
BL	_UART4_Write_Text+0
;clicker_2_STM32.c,159 :: 		return 1;
MOVS	R0, #1
SXTH	R0, R0
IT	AL
BAL	L_end_checkMPU6050
;clicker_2_STM32.c,160 :: 		}
L_checkMPU605014:
;clicker_2_STM32.c,162 :: 		UART4_Write_Text("Read 'WHO AM I' from MPU6050\r\n");
MOVW	R0, #lo_addr(?lstr2_clicker_2_STM32+0)
MOVT	R0, #hi_addr(?lstr2_clicker_2_STM32+0)
BL	_UART4_Write_Text+0
;clicker_2_STM32.c,163 :: 		return 0;
MOVS	R0, #0
SXTH	R0, R0
;clicker_2_STM32.c,164 :: 		}
L_end_checkMPU6050:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _checkMPU6050
_selfTestMPU6050:
;clicker_2_STM32.c,167 :: 		int selfTestMPU6050() {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;clicker_2_STM32.c,174 :: 		writeByte(ACCEL_CONFIG, 0xF0);
MOVS	R1, #240
MOVS	R0, #28
BL	_writeByte+0
;clicker_2_STM32.c,175 :: 		writeByte(GYRO_CONFIG, 0xE0);
MOVS	R1, #224
MOVS	R0, #27
BL	_writeByte+0
;clicker_2_STM32.c,176 :: 		Delay_ms(250);
MOVW	R7, #38526
MOVT	R7, #152
NOP
NOP
L_selfTestMPU605015:
SUBS	R7, R7, #1
BNE	L_selfTestMPU605015
NOP
NOP
NOP
;clicker_2_STM32.c,179 :: 		rdx = readByte(SELF_TEST_X);
MOVS	R0, #13
BL	_readByte+0
; rdx start address is: 48 (R12)
UXTB	R12, R0
;clicker_2_STM32.c,180 :: 		rdy = readByte(SELF_TEST_Y);
MOVS	R0, #14
BL	_readByte+0
; rdy start address is: 44 (R11)
UXTB	R11, R0
;clicker_2_STM32.c,181 :: 		rdz = readByte(SELF_TEST_Z);
MOVS	R0, #15
BL	_readByte+0
; rdz start address is: 16 (R4)
UXTB	R4, R0
;clicker_2_STM32.c,182 :: 		rda = readByte(SELF_TEST_A);
STRB	R4, [SP, #4]
MOVS	R0, #16
BL	_readByte+0
LDRB	R4, [SP, #4]
;clicker_2_STM32.c,185 :: 		stax = ((rdx >> 3) & 0x1C) | ((rda >> 4) & 0x03);
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
;clicker_2_STM32.c,186 :: 		stay = ((rdy >> 3) & 0x1C) | ((rda >> 2) & 0x03);
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
;clicker_2_STM32.c,187 :: 		staz = ((rdz >> 3) & 0x1C) | ((rda >> 0) & 0x03);
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
;clicker_2_STM32.c,190 :: 		stgx = rdx & 0x1F;
AND	R0, R12, #31
; rdx end address is: 48 (R12)
; stgx start address is: 36 (R9)
UXTB	R9, R0
;clicker_2_STM32.c,191 :: 		stgy = rdy & 0x1F;
AND	R0, R11, #31
; rdy end address is: 44 (R11)
; stgy start address is: 40 (R10)
UXTB	R10, R0
;clicker_2_STM32.c,192 :: 		stgz = rdy & 0x1F;
; stgz start address is: 44 (R11)
UXTB	R11, R0
;clicker_2_STM32.c,195 :: 		ftax = (4096.0*0.34)*(pow((0.92/0.34), (((float)stax - 1.0)/30.0)));
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
;clicker_2_STM32.c,196 :: 		ftay = (4096.0*0.34)*(pow((0.92/0.34), (((float)stay - 1.0)/30.0)));
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
;clicker_2_STM32.c,197 :: 		ftaz = (4096.0*0.34)*(pow((0.92/0.34), (((float)staz - 1.0)/30.0)));
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
;clicker_2_STM32.c,200 :: 		ftgx =  ( 25.0*131.0)*(pow(1.046, ((float)stgx - 1.0)));
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
;clicker_2_STM32.c,201 :: 		ftgy =  (-25.0*131.0)*(pow(1.046, ((float)stgy - 1.0)));
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
;clicker_2_STM32.c,202 :: 		ftgz =  ( 25.0*131.0)*(pow(1.046, ((float)stgz - 1.0)));
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
;clicker_2_STM32.c,205 :: 		dpax = 100.0 + 100.0*((float)stax - ftax)/ftax;
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
;clicker_2_STM32.c,206 :: 		dpay = 100.0 + 100.0*((float)stay - ftay)/ftay;
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
;clicker_2_STM32.c,207 :: 		dpaz = 100.0 + 100.0*((float)staz - ftaz)/ftaz;
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
;clicker_2_STM32.c,208 :: 		dpgx = 100.0 + 100.0*((float)stgx - ftgx)/ftgx;
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
;clicker_2_STM32.c,209 :: 		dpgy = 100.0 + 100.0*((float)stgy - ftgy)/ftgy;
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
;clicker_2_STM32.c,210 :: 		dpgz = 100.0 + 100.0*((float)stgz - ftgz)/ftgz;
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
;clicker_2_STM32.c,213 :: 		if (dpax > 1f | dpay > 1f | dpaz > 1f | dpgx > 1f | dpgy > 1f | dpgz > 1f) {
VMOV.F32	S0, #1
VCMPE.F32	S7, S0
VMRS	#60, FPSCR
MOVW	R1, #0
BLE	L__selfTestMPU605050
MOVS	R1, #1
L__selfTestMPU605050:
VMOV.F32	S0, #1
VCMPE.F32	S6, S0
VMRS	#60, FPSCR
MOVW	R0, #0
BLE	L__selfTestMPU605051
MOVS	R0, #1
L__selfTestMPU605051:
ORRS	R1, R0
VMOV.F32	S0, #1
VCMPE.F32	S5, S0
VMRS	#60, FPSCR
MOVW	R0, #0
BLE	L__selfTestMPU605052
MOVS	R0, #1
L__selfTestMPU605052:
ORRS	R1, R0
VMOV.F32	S0, #1
VCMPE.F32	S4, S0
VMRS	#60, FPSCR
MOVW	R0, #0
BLE	L__selfTestMPU605053
MOVS	R0, #1
L__selfTestMPU605053:
ORRS	R1, R0
VMOV.F32	S0, #1
VCMPE.F32	S3, S0
VMRS	#60, FPSCR
MOVW	R0, #0
BLE	L__selfTestMPU605054
MOVS	R0, #1
L__selfTestMPU605054:
ORRS	R1, R0
VMOV.F32	S0, #1
VCMPE.F32	S1, S0
VMRS	#60, FPSCR
MOVW	R0, #0
BLE	L__selfTestMPU605055
MOVS	R0, #1
L__selfTestMPU605055:
ORR	R0, R1, R0, LSL #0
CMP	R0, #0
IT	EQ
BEQ	L_selfTestMPU605017
;clicker_2_STM32.c,214 :: 		return 1;
MOVS	R0, #1
SXTH	R0, R0
IT	AL
BAL	L_end_selfTestMPU6050
;clicker_2_STM32.c,215 :: 		}
L_selfTestMPU605017:
;clicker_2_STM32.c,217 :: 		return 0;
MOVS	R0, #0
SXTH	R0, R0
;clicker_2_STM32.c,218 :: 		}
L_end_selfTestMPU6050:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _selfTestMPU6050
_calculateAccelAndGyroBiases:
;clicker_2_STM32.c,220 :: 		void calculateAccelAndGyroBiases() {
SUB	SP, SP, #88
STR	LR, [SP, #0]
;clicker_2_STM32.c,223 :: 		int32_t gyro_bias[3] = {0, 0, 0}, accel_bias[3] = {0, 0, 0};
ADD	R11, SP, #32
ADD	R10, R11, #47
MOVW	R12, #lo_addr(?ICScalculateAccelAndGyroBiases_gyro_bias_L0+0)
MOVT	R12, #hi_addr(?ICScalculateAccelAndGyroBiases_gyro_bias_L0+0)
BL	___CC2DW+0
;clicker_2_STM32.c,224 :: 		uint16_t  accelsensitivity = 16384;
;clicker_2_STM32.c,225 :: 		uint16_t  gyrosensitivity  = 131;   // = 131 LSB/degrees/sec
;clicker_2_STM32.c,226 :: 		int32_t accel_bias_reg[3] = {0, 0, 0}; // A place to hold the factory accelerometer trim biases
;clicker_2_STM32.c,227 :: 		uint32_t mask = 1uL; // Define mask for temperature compensation bit 0 of lower byte of accelerometer bias registers
;clicker_2_STM32.c,228 :: 		uint8_t mask_bit[3] = {0, 0, 0}; // Define array to hold mask bit for each accelerometer bias axis
;clicker_2_STM32.c,231 :: 		writeByte(PWR_MGMT_1, 0x80);   // Reset MPU6050
MOVS	R1, #128
MOVS	R0, #107
BL	_writeByte+0
;clicker_2_STM32.c,232 :: 		Delay_ms(100);
MOVW	R7, #2302
MOVT	R7, #61
NOP
NOP
L_calculateAccelAndGyroBiases18:
SUBS	R7, R7, #1
BNE	L_calculateAccelAndGyroBiases18
NOP
NOP
NOP
;clicker_2_STM32.c,234 :: 		writeByte(PWR_MGMT_1, 0x01);   // Set clock source to gyro x-axis
MOVS	R1, #1
MOVS	R0, #107
BL	_writeByte+0
;clicker_2_STM32.c,235 :: 		writeByte(PWR_MGMT_2, 0x00);   // Set low power sleep mode wake up frequency to 1.25Hz
MOVS	R1, #0
MOVS	R0, #108
BL	_writeByte+0
;clicker_2_STM32.c,236 :: 		Delay_ms(200);
MOVW	R7, #4606
MOVT	R7, #122
NOP
NOP
L_calculateAccelAndGyroBiases20:
SUBS	R7, R7, #1
BNE	L_calculateAccelAndGyroBiases20
NOP
NOP
NOP
;clicker_2_STM32.c,239 :: 		writeByte(INT_ENABLE, 0x00);   // Disable all interrupts
MOVS	R1, #0
MOVS	R0, #56
BL	_writeByte+0
;clicker_2_STM32.c,240 :: 		writeByte(FIFO_EN, 0x00);      // Disable FIFO
MOVS	R1, #0
MOVS	R0, #35
BL	_writeByte+0
;clicker_2_STM32.c,241 :: 		writeByte(PWR_MGMT_1, 0x00);   // Turn on internal clock source
MOVS	R1, #0
MOVS	R0, #107
BL	_writeByte+0
;clicker_2_STM32.c,242 :: 		writeByte(I2C_MST_CTRL, 0x00); // Disable I2C master
MOVS	R1, #0
MOVS	R0, #36
BL	_writeByte+0
;clicker_2_STM32.c,243 :: 		writeByte(USER_CTRL, 0x00);    // Disable FIFO and I2C master modes
MOVS	R1, #0
MOVS	R0, #106
BL	_writeByte+0
;clicker_2_STM32.c,244 :: 		writeByte(USER_CTRL, 0x0C);    // Reset FIFO and DMP
MOVS	R1, #12
MOVS	R0, #106
BL	_writeByte+0
;clicker_2_STM32.c,245 :: 		Delay_ms(15);
MOVW	R7, #10174
MOVT	R7, #9
NOP
NOP
L_calculateAccelAndGyroBiases22:
SUBS	R7, R7, #1
BNE	L_calculateAccelAndGyroBiases22
NOP
NOP
NOP
;clicker_2_STM32.c,248 :: 		writeByte(CONFIG, 0x01);       // Set low-pass filter to 188 Hz
MOVS	R1, #1
MOVS	R0, #26
BL	_writeByte+0
;clicker_2_STM32.c,249 :: 		writeByte(SMPLRT_DIV, 0x00);   // Set sample rate to 1 kHz
MOVS	R1, #0
MOVS	R0, #25
BL	_writeByte+0
;clicker_2_STM32.c,250 :: 		writeByte(GYRO_CONFIG, 0x00);  // Set gyro full-scale to 250 degrees per second, maximum sensitivity
MOVS	R1, #0
MOVS	R0, #27
BL	_writeByte+0
;clicker_2_STM32.c,251 :: 		writeByte(ACCEL_CONFIG, 0x00); // Set accelerometer full-scale to 2 g, maximum sensitivity
MOVS	R1, #0
MOVS	R0, #28
BL	_writeByte+0
;clicker_2_STM32.c,254 :: 		writeByte(USER_CTRL, 0x40);    // Enable FIFO
MOVS	R1, #64
MOVS	R0, #106
BL	_writeByte+0
;clicker_2_STM32.c,255 :: 		writeByte(FIFO_EN, 0x78);      // Enable gyro and accelerometer sensors for FIFO  (max size 1024 bytes in MPU-6050)
MOVS	R1, #120
MOVS	R0, #35
BL	_writeByte+0
;clicker_2_STM32.c,256 :: 		Delay_ms(80);                  // Capture 80 samples
MOVW	R7, #54270
MOVT	R7, #48
NOP
NOP
L_calculateAccelAndGyroBiases24:
SUBS	R7, R7, #1
BNE	L_calculateAccelAndGyroBiases24
NOP
NOP
NOP
;clicker_2_STM32.c,259 :: 		writeByte(FIFO_EN, 0x00);             // Disable gyro and accelerometer sensors for FIFO
MOVS	R1, #0
MOVS	R0, #35
BL	_writeByte+0
;clicker_2_STM32.c,260 :: 		readBytes(FIFO_COUNTH, 2, &data_[0]); // read FIFO sample count
ADD	R0, SP, #8
MOV	R2, R0
MOVS	R1, #2
SXTH	R1, R1
MOVS	R0, #114
BL	_readBytes+0
;clicker_2_STM32.c,261 :: 		fifo_count = ((uint16_t)data_[0] << 8) | data_[1];
ADD	R2, SP, #8
LDRB	R0, [R2, #0]
LSLS	R1, R0, #8
UXTH	R1, R1
ADDS	R0, R2, #1
LDRB	R0, [R0, #0]
ORRS	R1, R0
UXTH	R1, R1
;clicker_2_STM32.c,262 :: 		packet_count = fifo_count/12;          // How many sets of full gyro and accelerometer data for averaging
MOVS	R0, #12
UDIV	R0, R1, R0
; packet_count start address is: 32 (R8)
UXTH	R8, R0
;clicker_2_STM32.c,264 :: 		for (ii = 0; ii < packet_count; ii++) {
; ii start address is: 40 (R10)
MOVW	R10, #0
; packet_count end address is: 32 (R8)
; ii end address is: 40 (R10)
UXTH	R7, R8
UXTH	R6, R10
L_calculateAccelAndGyroBiases26:
; ii start address is: 24 (R6)
; packet_count start address is: 28 (R7)
CMP	R6, R7
IT	CS
BCS	L_calculateAccelAndGyroBiases27
;clicker_2_STM32.c,265 :: 		int16_t accel_temp[3] = {0, 0, 0}, gyro_temp[3] = {0, 0, 0};
ADD	R11, SP, #20
ADD	R10, R11, #12
MOVW	R12, #lo_addr(?ICScalculateAccelAndGyroBiases_accel_temp_L1+0)
MOVT	R12, #hi_addr(?ICScalculateAccelAndGyroBiases_accel_temp_L1+0)
BL	___CC2DW+0
;clicker_2_STM32.c,267 :: 		readBytes(FIFO_R_W, 12, &data_[0]); // read data for averaging
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
;clicker_2_STM32.c,269 :: 		accel_temp[0] = (int16_t) (((int16_t)data_[0] << 8) | data_[1]  ) ;  // Form signed 16-bit integer for each sample in FIFO
ADD	R5, SP, #20
ADD	R2, SP, #8
LDRB	R0, [R2, #0]
LSLS	R1, R0, #8
SXTH	R1, R1
ADDS	R0, R2, #1
LDRB	R0, [R0, #0]
ORR	R0, R1, R0, LSL #0
STRH	R0, [R5, #0]
;clicker_2_STM32.c,270 :: 		accel_temp[1] = (int16_t) (((int16_t)data_[2] << 8) | data_[3]  ) ;
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
;clicker_2_STM32.c,271 :: 		accel_temp[2] = (int16_t) (((int16_t)data_[4] << 8) | data_[5]  ) ;
ADDS	R2, R5, #4
ADDS	R0, R3, #4
LDRB	R0, [R0, #0]
LSLS	R1, R0, #8
SXTH	R1, R1
ADDS	R0, R3, #5
LDRB	R0, [R0, #0]
ORR	R0, R1, R0, LSL #0
STRH	R0, [R2, #0]
;clicker_2_STM32.c,272 :: 		gyro_temp[0]  = (int16_t) (((int16_t)data_[6] << 8) | data_[7]  ) ;
ADD	R4, SP, #26
ADDS	R0, R3, #6
LDRB	R0, [R0, #0]
LSLS	R1, R0, #8
SXTH	R1, R1
ADDS	R0, R3, #7
LDRB	R0, [R0, #0]
ORR	R0, R1, R0, LSL #0
STRH	R0, [R4, #0]
;clicker_2_STM32.c,273 :: 		gyro_temp[1]  = (int16_t) (((int16_t)data_[8] << 8) | data_[9]  ) ;
ADDS	R2, R4, #2
ADDW	R0, R3, #8
LDRB	R0, [R0, #0]
LSLS	R1, R0, #8
SXTH	R1, R1
ADDW	R0, R3, #9
LDRB	R0, [R0, #0]
ORR	R0, R1, R0, LSL #0
STRH	R0, [R2, #0]
;clicker_2_STM32.c,274 :: 		gyro_temp[2]  = (int16_t) (((int16_t)data_[10] << 8) | data_[11]) ;
ADDS	R2, R4, #4
ADDW	R0, R3, #10
LDRB	R0, [R0, #0]
LSLS	R1, R0, #8
SXTH	R1, R1
ADDW	R0, R3, #11
LDRB	R0, [R0, #0]
ORR	R0, R1, R0, LSL #0
STRH	R0, [R2, #0]
;clicker_2_STM32.c,276 :: 		accel_bias[0] += (int32_t) accel_temp[0]; // Sum individual signed 16-bit biases to get accumulated signed 32-bit biases
ADD	R3, SP, #44
LDRSH	R0, [R5, #0]
SXTH	R1, R0
LDR	R0, [R3, #0]
ADDS	R0, R0, R1
STR	R0, [R3, #0]
;clicker_2_STM32.c,277 :: 		accel_bias[1] += (int32_t) accel_temp[1];
ADDS	R2, R3, #4
ADDS	R0, R5, #2
LDRSH	R0, [R0, #0]
SXTH	R1, R0
LDR	R0, [R2, #0]
ADDS	R0, R0, R1
STR	R0, [R2, #0]
;clicker_2_STM32.c,278 :: 		accel_bias[2] += (int32_t) accel_temp[2];
ADDW	R2, R3, #8
ADDS	R0, R5, #4
LDRSH	R0, [R0, #0]
SXTH	R1, R0
LDR	R0, [R2, #0]
ADDS	R0, R0, R1
STR	R0, [R2, #0]
;clicker_2_STM32.c,279 :: 		gyro_bias[0]  += (int32_t) gyro_temp[0];
ADD	R3, SP, #32
LDRSH	R0, [R4, #0]
SXTH	R1, R0
LDR	R0, [R3, #0]
ADDS	R0, R0, R1
STR	R0, [R3, #0]
;clicker_2_STM32.c,280 :: 		gyro_bias[1]  += (int32_t) gyro_temp[1];
ADDS	R2, R3, #4
ADDS	R0, R4, #2
LDRSH	R0, [R0, #0]
SXTH	R1, R0
LDR	R0, [R2, #0]
ADDS	R0, R0, R1
STR	R0, [R2, #0]
;clicker_2_STM32.c,281 :: 		gyro_bias[2]  += (int32_t) gyro_temp[2];
ADDW	R2, R3, #8
ADDS	R0, R4, #4
LDRSH	R0, [R0, #0]
SXTH	R1, R0
LDR	R0, [R2, #0]
ADDS	R0, R0, R1
STR	R0, [R2, #0]
;clicker_2_STM32.c,264 :: 		for (ii = 0; ii < packet_count; ii++) {
ADDS	R0, R6, #1
; ii end address is: 24 (R6)
; ii start address is: 40 (R10)
UXTH	R10, R0
;clicker_2_STM32.c,282 :: 		}
; ii end address is: 40 (R10)
UXTH	R6, R10
IT	AL
BAL	L_calculateAccelAndGyroBiases26
L_calculateAccelAndGyroBiases27:
;clicker_2_STM32.c,284 :: 		accel_bias[0] /= (int32_t) packet_count; // Normalize sums to get average count biases
ADD	R4, SP, #44
UXTH	R1, R7
LDR	R0, [R4, #0]
SDIV	R0, R0, R1
STR	R0, [R4, #0]
;clicker_2_STM32.c,285 :: 		accel_bias[1] /= (int32_t) packet_count;
ADDS	R2, R4, #4
UXTH	R1, R7
LDR	R0, [R2, #0]
SDIV	R0, R0, R1
STR	R0, [R2, #0]
;clicker_2_STM32.c,286 :: 		accel_bias[2] /= (int32_t) packet_count;
ADDW	R2, R4, #8
UXTH	R1, R7
LDR	R0, [R2, #0]
SDIV	R0, R0, R1
STR	R0, [R2, #0]
;clicker_2_STM32.c,287 :: 		gyro_bias[0]  /= (int32_t) packet_count;
ADD	R3, SP, #32
UXTH	R1, R7
LDR	R0, [R3, #0]
SDIV	R0, R0, R1
STR	R0, [R3, #0]
;clicker_2_STM32.c,288 :: 		gyro_bias[1]  /= (int32_t) packet_count;
ADDS	R2, R3, #4
UXTH	R1, R7
LDR	R0, [R2, #0]
SDIV	R0, R0, R1
STR	R0, [R2, #0]
;clicker_2_STM32.c,289 :: 		gyro_bias[2]  /= (int32_t) packet_count;
ADDW	R2, R3, #8
UXTH	R1, R7
; packet_count end address is: 28 (R7)
LDR	R0, [R2, #0]
SDIV	R0, R0, R1
STR	R0, [R2, #0]
;clicker_2_STM32.c,291 :: 		if(accel_bias[2] > 0L) {accel_bias[2] -= (int32_t) accelsensitivity;}  // Remove gravity from the z-axis accelerometer bias calculation
ADDW	R0, R4, #8
LDR	R0, [R0, #0]
CMP	R0, #0
IT	LE
BLE	L_calculateAccelAndGyroBiases29
ADD	R0, SP, #44
ADDW	R2, R0, #8
LDRH	R1, [SP, #56]
LDR	R0, [R2, #0]
SUB	R0, R0, R1
STR	R0, [R2, #0]
IT	AL
BAL	L_calculateAccelAndGyroBiases30
L_calculateAccelAndGyroBiases29:
;clicker_2_STM32.c,292 :: 		else {accel_bias[2] += (int32_t) accelsensitivity;}
ADD	R0, SP, #44
ADDW	R2, R0, #8
LDRH	R1, [SP, #56]
LDR	R0, [R2, #0]
ADDS	R0, R0, R1
STR	R0, [R2, #0]
L_calculateAccelAndGyroBiases30:
;clicker_2_STM32.c,295 :: 		data_[0] = (-gyro_bias[0]/4  >> 8) & 0xFF; // Divide by 4 to get 32.9 LSB per deg/s to conform to expected bias input format
ADD	R3, SP, #8
STR	R3, [SP, #84]
ADD	R2, SP, #32
LDR	R0, [R2, #0]
RSBS	R0, R0, #0
ASRS	R0, R0, #2
ASRS	R0, R0, #8
AND	R0, R0, #255
STRB	R0, [R3, #0]
;clicker_2_STM32.c,296 :: 		data_[1] = (-gyro_bias[0]/4)       & 0xFF; // Biases are additive, so change sign on calculated average gyro biases
ADDS	R1, R3, #1
LDR	R0, [R2, #0]
RSBS	R0, R0, #0
ASRS	R0, R0, #2
AND	R0, R0, #255
STRB	R0, [R1, #0]
;clicker_2_STM32.c,297 :: 		data_[2] = (-gyro_bias[1]/4  >> 8) & 0xFF;
ADDS	R1, R3, #2
ADDS	R0, R2, #4
LDR	R0, [R0, #0]
RSBS	R0, R0, #0
ASRS	R0, R0, #2
ASRS	R0, R0, #8
AND	R0, R0, #255
STRB	R0, [R1, #0]
;clicker_2_STM32.c,298 :: 		data_[3] = (-gyro_bias[1]/4)       & 0xFF;
ADDS	R1, R3, #3
ADDS	R0, R2, #4
LDR	R0, [R0, #0]
RSBS	R0, R0, #0
ASRS	R0, R0, #2
AND	R0, R0, #255
STRB	R0, [R1, #0]
;clicker_2_STM32.c,299 :: 		data_[4] = (-gyro_bias[2]/4  >> 8) & 0xFF;
ADDS	R1, R3, #4
ADDW	R0, R2, #8
LDR	R0, [R0, #0]
RSBS	R0, R0, #0
ASRS	R0, R0, #2
ASRS	R0, R0, #8
AND	R0, R0, #255
STRB	R0, [R1, #0]
;clicker_2_STM32.c,300 :: 		data_[5] = (-gyro_bias[2]/4)       & 0xFF;
ADDS	R1, R3, #5
ADDW	R0, R2, #8
LDR	R0, [R0, #0]
RSBS	R0, R0, #0
ASRS	R0, R0, #2
AND	R0, R0, #255
STRB	R0, [R1, #0]
;clicker_2_STM32.c,302 :: 		bgx = (float) gyro_bias[0]/(float) gyrosensitivity; // construct gyro bias in deg/s for later manual subtraction
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
;clicker_2_STM32.c,303 :: 		bgy = (float) gyro_bias[1]/(float) gyrosensitivity;
ADDS	R0, R2, #4
LDR	R0, [R0, #0]
VMOV	S0, R0
VCVT.F32	#1, S0, S0
VDIV.F32	S0, S0, S1
MOVW	R0, #lo_addr(_bgy+0)
MOVT	R0, #hi_addr(_bgy+0)
VSTR	#1, S0, [R0, #0]
;clicker_2_STM32.c,304 :: 		bgz = (float) gyro_bias[2]/(float) gyrosensitivity;
ADDW	R0, R2, #8
LDR	R0, [R0, #0]
VMOV	S0, R0
VCVT.F32	#1, S0, S0
VDIV.F32	S0, S0, S1
MOVW	R0, #lo_addr(_bgz+0)
MOVT	R0, #hi_addr(_bgz+0)
VSTR	#1, S0, [R0, #0]
;clicker_2_STM32.c,312 :: 		readBytes(XA_OFFSET_H, 2, &data_[0]); // Read factory accelerometer trim values
MOV	R2, R3
MOVS	R1, #2
SXTH	R1, R1
MOVS	R0, #6
BL	_readBytes+0
;clicker_2_STM32.c,313 :: 		accel_bias_reg[0] = (int16_t) ((int16_t)data_[0] << 8) | data_[1];
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
;clicker_2_STM32.c,314 :: 		readBytes(YA_OFFSET_H, 2, &data_[0]);
LDR	R0, [SP, #84]
MOV	R2, R0
MOVS	R1, #2
SXTH	R1, R1
MOVS	R0, #8
BL	_readBytes+0
;clicker_2_STM32.c,315 :: 		accel_bias_reg[1] = (int16_t) ((int16_t)data_[0] << 8) | data_[1];
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
;clicker_2_STM32.c,316 :: 		readBytes(ZA_OFFSET_H, 2, &data_[0]);
LDR	R0, [SP, #84]
MOV	R2, R0
MOVS	R1, #2
SXTH	R1, R1
MOVS	R0, #10
BL	_readBytes+0
;clicker_2_STM32.c,317 :: 		accel_bias_reg[2] = (int16_t) ((int16_t)data_[0] << 8) | data_[1];
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
;clicker_2_STM32.c,319 :: 		for(ii = 0; ii < 3; ii++) {
; ii start address is: 12 (R3)
MOVS	R3, #0
; ii end address is: 12 (R3)
UXTH	R2, R3
L_calculateAccelAndGyroBiases31:
; ii start address is: 8 (R2)
CMP	R2, #3
IT	CS
BCS	L_calculateAccelAndGyroBiases32
;clicker_2_STM32.c,320 :: 		if(accel_bias_reg[ii] & mask) mask_bit[ii] = 0x01; // If temperature compensation bit is set, record that fact in mask_bit
ADD	R1, SP, #60
LSLS	R0, R2, #2
ADDS	R0, R1, R0
LDR	R1, [R0, #0]
LDR	R0, [SP, #72]
AND	R0, R1, R0, LSL #0
CMP	R0, #0
IT	EQ
BEQ	L_calculateAccelAndGyroBiases34
ADD	R0, SP, #76
ADDS	R1, R0, R2
MOVS	R0, #1
STRB	R0, [R1, #0]
L_calculateAccelAndGyroBiases34:
;clicker_2_STM32.c,319 :: 		for(ii = 0; ii < 3; ii++) {
ADDS	R0, R2, #1
; ii end address is: 8 (R2)
; ii start address is: 12 (R3)
UXTH	R3, R0
;clicker_2_STM32.c,321 :: 		}
UXTH	R2, R3
; ii end address is: 12 (R3)
IT	AL
BAL	L_calculateAccelAndGyroBiases31
L_calculateAccelAndGyroBiases32:
;clicker_2_STM32.c,324 :: 		accel_bias_reg[0] -= (accel_bias[0]/8); // Subtract calculated averaged accelerometer bias scaled to 2048 LSB/g (16 g full scale)
ADD	R6, SP, #60
ADD	R5, SP, #44
LDR	R0, [R5, #0]
ASRS	R1, R0, #3
LDR	R0, [R6, #0]
SUB	R0, R0, R1
STR	R0, [R6, #0]
;clicker_2_STM32.c,325 :: 		accel_bias_reg[1] -= (accel_bias[1]/8);
ADDS	R2, R6, #4
ADDS	R0, R5, #4
LDR	R0, [R0, #0]
ASRS	R1, R0, #3
LDR	R0, [R2, #0]
SUB	R0, R0, R1
STR	R0, [R2, #0]
;clicker_2_STM32.c,326 :: 		accel_bias_reg[2] -= (accel_bias[2]/8);
ADDW	R2, R6, #8
ADDW	R0, R5, #8
LDR	R0, [R0, #0]
ASRS	R1, R0, #3
LDR	R0, [R2, #0]
SUB	R0, R0, R1
STR	R0, [R2, #0]
;clicker_2_STM32.c,328 :: 		data_[0] = (accel_bias_reg[0] >> 8) & 0xFF;
ADD	R4, SP, #8
LDR	R0, [R6, #0]
ASRS	R0, R0, #8
AND	R0, R0, #255
STRB	R0, [R4, #0]
;clicker_2_STM32.c,329 :: 		data_[1] = (accel_bias_reg[0])      & 0xFF;
ADDS	R1, R4, #1
LDR	R0, [R6, #0]
AND	R0, R0, #255
STRB	R0, [R1, #0]
;clicker_2_STM32.c,330 :: 		data_[1] = data_[1] | mask_bit[0]; // preserve temperature compensation bit when writing back to accelerometer bias registers
ADDS	R2, R4, #1
LDRB	R1, [R2, #0]
ADD	R3, SP, #76
LDRB	R0, [R3, #0]
ORR	R0, R1, R0, LSL #0
STRB	R0, [R2, #0]
;clicker_2_STM32.c,331 :: 		data_[2] = (accel_bias_reg[1] >> 8) & 0xFF;
ADDS	R1, R4, #2
ADDS	R0, R6, #4
LDR	R0, [R0, #0]
ASRS	R0, R0, #8
AND	R0, R0, #255
STRB	R0, [R1, #0]
;clicker_2_STM32.c,332 :: 		data_[3] = (accel_bias_reg[1])      & 0xFF;
ADDS	R1, R4, #3
ADDS	R0, R6, #4
LDR	R0, [R0, #0]
AND	R0, R0, #255
STRB	R0, [R1, #0]
;clicker_2_STM32.c,333 :: 		data_[3] = data_[3] | mask_bit[1]; // preserve temperature compensation bit when writing back to accelerometer bias registers
ADDS	R2, R4, #3
LDRB	R1, [R2, #0]
ADDS	R0, R3, #1
LDRB	R0, [R0, #0]
ORR	R0, R1, R0, LSL #0
STRB	R0, [R2, #0]
;clicker_2_STM32.c,334 :: 		data_[4] = (accel_bias_reg[2] >> 8) & 0xFF;
ADDS	R1, R4, #4
ADDW	R0, R6, #8
LDR	R0, [R0, #0]
ASRS	R0, R0, #8
AND	R0, R0, #255
STRB	R0, [R1, #0]
;clicker_2_STM32.c,335 :: 		data_[5] = (accel_bias_reg[2])      & 0xFF;
ADDS	R1, R4, #5
ADDW	R0, R6, #8
LDR	R0, [R0, #0]
AND	R0, R0, #255
STRB	R0, [R1, #0]
;clicker_2_STM32.c,336 :: 		data_[5] = data_[5] | mask_bit[2]; // preserve temperature compensation bit when writing back to accelerometer bias registers
ADDS	R2, R4, #5
LDRB	R1, [R2, #0]
ADDS	R0, R3, #2
LDRB	R0, [R0, #0]
ORR	R0, R1, R0, LSL #0
STRB	R0, [R2, #0]
;clicker_2_STM32.c,340 :: 		bax = (float)accel_bias[0]/(float)accelsensitivity;
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
;clicker_2_STM32.c,341 :: 		bay = (float)accel_bias[1]/(float)accelsensitivity;
ADDS	R0, R5, #4
LDR	R0, [R0, #0]
VMOV	S0, R0
VCVT.F32	#1, S0, S0
VDIV.F32	S0, S0, S1
MOVW	R0, #lo_addr(_bay+0)
MOVT	R0, #hi_addr(_bay+0)
VSTR	#1, S0, [R0, #0]
;clicker_2_STM32.c,342 :: 		baz = (float)accel_bias[2]/(float)accelsensitivity;
ADDW	R0, R5, #8
LDR	R0, [R0, #0]
VMOV	S0, R0
VCVT.F32	#1, S0, S0
VDIV.F32	S0, S0, S1
MOVW	R0, #lo_addr(_baz+0)
MOVT	R0, #hi_addr(_baz+0)
VSTR	#1, S0, [R0, #0]
;clicker_2_STM32.c,343 :: 		}
L_end_calculateAccelAndGyroBiases:
LDR	LR, [SP, #0]
ADD	SP, SP, #88
BX	LR
; end of _calculateAccelAndGyroBiases
_initMPU6050:
;clicker_2_STM32.c,345 :: 		void initMPU6050() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;clicker_2_STM32.c,347 :: 		writeByte(PWR_MGMT_1, 0x09);              // Also disable temperature sensor
MOVS	R1, #9
MOVS	R0, #107
BL	_writeByte+0
;clicker_2_STM32.c,348 :: 		writeByte(CONFIG, 0x06);
MOVS	R1, #6
MOVS	R0, #26
BL	_writeByte+0
;clicker_2_STM32.c,349 :: 		writeByte(SMPLRT_DIV, 0x04);
MOVS	R1, #4
MOVS	R0, #25
BL	_writeByte+0
;clicker_2_STM32.c,350 :: 		c =  readByte(GYRO_CONFIG);
MOVS	R0, #27
BL	_readByte+0
; c start address is: 40 (R10)
UXTB	R10, R0
;clicker_2_STM32.c,351 :: 		writeByte(GYRO_CONFIG, c & ~0xE0);        // Clear self-test bits [7:5]
AND	R0, R0, #31
UXTB	R1, R0
MOVS	R0, #27
BL	_writeByte+0
;clicker_2_STM32.c,352 :: 		writeByte(GYRO_CONFIG, c & ~0x18);        // Clear AFS bits [4:3]
MOVW	R0, #65511
SXTH	R0, R0
AND	R0, R10, R0, LSL #0
UXTB	R1, R0
MOVS	R0, #27
BL	_writeByte+0
;clicker_2_STM32.c,353 :: 		writeByte(GYRO_CONFIG, c | Gscale << 3);  // Set full scale range for the gyro
MOVW	R0, #lo_addr(_Gscale+0)
MOVT	R0, #hi_addr(_Gscale+0)
LDRSH	R0, [R0, #0]
LSLS	R0, R0, #3
SXTH	R0, R0
ORR	R0, R10, R0, LSL #0
; c end address is: 40 (R10)
UXTB	R1, R0
MOVS	R0, #27
BL	_writeByte+0
;clicker_2_STM32.c,355 :: 		c =  readByte(ACCEL_CONFIG);
MOVS	R0, #28
BL	_readByte+0
; c start address is: 40 (R10)
UXTB	R10, R0
;clicker_2_STM32.c,356 :: 		writeByte(ACCEL_CONFIG, c & ~0xE0);       // Clear self-test bits [7:5]
AND	R0, R0, #31
UXTB	R1, R0
MOVS	R0, #28
BL	_writeByte+0
;clicker_2_STM32.c,357 :: 		writeByte(ACCEL_CONFIG, c & ~0x18);       // Clear AFS bits [4:3]
MOVW	R0, #65511
SXTH	R0, R0
AND	R0, R10, R0, LSL #0
UXTB	R1, R0
MOVS	R0, #28
BL	_writeByte+0
;clicker_2_STM32.c,358 :: 		writeByte(ACCEL_CONFIG, c | Ascale << 3); // Set full scale range for the accelerometer
MOVW	R0, #lo_addr(_Ascale+0)
MOVT	R0, #hi_addr(_Ascale+0)
LDRSH	R0, [R0, #0]
LSLS	R0, R0, #3
SXTH	R0, R0
ORR	R0, R10, R0, LSL #0
; c end address is: 40 (R10)
UXTB	R1, R0
MOVS	R0, #28
BL	_writeByte+0
;clicker_2_STM32.c,360 :: 		writeByte(INT_PIN_CFG, 0xA0);
MOVS	R1, #160
MOVS	R0, #55
BL	_writeByte+0
;clicker_2_STM32.c,361 :: 		writeByte(MOT_THR, 0x14);
MOVS	R1, #20
MOVS	R0, #31
BL	_writeByte+0
;clicker_2_STM32.c,362 :: 		writeByte(MOT_DUR, 0x28);
MOVS	R1, #40
MOVS	R0, #32
BL	_writeByte+0
;clicker_2_STM32.c,363 :: 		writeByte(MOT_DETECT_CTRL, 0x15);
MOVS	R1, #21
MOVS	R0, #105
BL	_writeByte+0
;clicker_2_STM32.c,364 :: 		writeByte(INT_ENABLE, 0x40);
MOVS	R1, #64
MOVS	R0, #56
BL	_writeByte+0
;clicker_2_STM32.c,365 :: 		}
L_end_initMPU6050:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _initMPU6050
_THE_FUNCTION:
;clicker_2_STM32.c,374 :: 		void THE_FUNCTION() {
SUB	SP, SP, #28
STR	LR, [SP, #0]
;clicker_2_STM32.c,378 :: 		readAccelData(accelData);
ADD	R0, SP, #4
BL	_readAccelData+0
;clicker_2_STM32.c,379 :: 		readGyroData(gyroData);
ADD	R0, SP, #16
BL	_readGyroData+0
;clicker_2_STM32.c,381 :: 		sprintf(buffer, "\r\n%f\r\n", accelData[0]);
ADD	R0, SP, #4
VLDR	#1, S0, [R0, #0]
MOVW	R1, #lo_addr(?lstr_3_clicker_2_STM32+0)
MOVT	R1, #hi_addr(?lstr_3_clicker_2_STM32+0)
MOVW	R0, #lo_addr(_buffer+0)
MOVT	R0, #hi_addr(_buffer+0)
VPUSH	#0, (S0)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;clicker_2_STM32.c,382 :: 		UART4_Write_Text(buffer);
MOVW	R0, #lo_addr(_buffer+0)
MOVT	R0, #hi_addr(_buffer+0)
BL	_UART4_Write_Text+0
;clicker_2_STM32.c,383 :: 		sprintf(buffer, "%f\r\n", accelData[1]);
ADD	R0, SP, #4
ADDS	R0, R0, #4
VLDR	#1, S0, [R0, #0]
MOVW	R1, #lo_addr(?lstr_4_clicker_2_STM32+0)
MOVT	R1, #hi_addr(?lstr_4_clicker_2_STM32+0)
MOVW	R0, #lo_addr(_buffer+0)
MOVT	R0, #hi_addr(_buffer+0)
VPUSH	#0, (S0)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;clicker_2_STM32.c,384 :: 		UART4_Write_Text(buffer);
MOVW	R0, #lo_addr(_buffer+0)
MOVT	R0, #hi_addr(_buffer+0)
BL	_UART4_Write_Text+0
;clicker_2_STM32.c,385 :: 		sprintf(buffer, "%f\r\n", accelData[2]);
ADD	R0, SP, #4
ADDS	R0, #8
VLDR	#1, S0, [R0, #0]
MOVW	R1, #lo_addr(?lstr_5_clicker_2_STM32+0)
MOVT	R1, #hi_addr(?lstr_5_clicker_2_STM32+0)
MOVW	R0, #lo_addr(_buffer+0)
MOVT	R0, #hi_addr(_buffer+0)
VPUSH	#0, (S0)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;clicker_2_STM32.c,386 :: 		UART4_Write_Text(buffer);
MOVW	R0, #lo_addr(_buffer+0)
MOVT	R0, #hi_addr(_buffer+0)
BL	_UART4_Write_Text+0
;clicker_2_STM32.c,388 :: 		sprintf(buffer, "%f\r\n", gyroData[0]);
ADD	R0, SP, #16
VLDR	#1, S0, [R0, #0]
MOVW	R1, #lo_addr(?lstr_6_clicker_2_STM32+0)
MOVT	R1, #hi_addr(?lstr_6_clicker_2_STM32+0)
MOVW	R0, #lo_addr(_buffer+0)
MOVT	R0, #hi_addr(_buffer+0)
VPUSH	#0, (S0)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;clicker_2_STM32.c,389 :: 		UART4_Write_Text(buffer);
MOVW	R0, #lo_addr(_buffer+0)
MOVT	R0, #hi_addr(_buffer+0)
BL	_UART4_Write_Text+0
;clicker_2_STM32.c,390 :: 		sprintf(buffer, "%f\r\n", gyroData[1]);
ADD	R0, SP, #16
ADDS	R0, R0, #4
VLDR	#1, S0, [R0, #0]
MOVW	R1, #lo_addr(?lstr_7_clicker_2_STM32+0)
MOVT	R1, #hi_addr(?lstr_7_clicker_2_STM32+0)
MOVW	R0, #lo_addr(_buffer+0)
MOVT	R0, #hi_addr(_buffer+0)
VPUSH	#0, (S0)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;clicker_2_STM32.c,391 :: 		UART4_Write_Text(buffer);
MOVW	R0, #lo_addr(_buffer+0)
MOVT	R0, #hi_addr(_buffer+0)
BL	_UART4_Write_Text+0
;clicker_2_STM32.c,392 :: 		sprintf(buffer, "%f\r\n", gyroData[2]);
ADD	R0, SP, #16
ADDS	R0, #8
VLDR	#1, S0, [R0, #0]
MOVW	R1, #lo_addr(?lstr_8_clicker_2_STM32+0)
MOVT	R1, #hi_addr(?lstr_8_clicker_2_STM32+0)
MOVW	R0, #lo_addr(_buffer+0)
MOVT	R0, #hi_addr(_buffer+0)
VPUSH	#0, (S0)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;clicker_2_STM32.c,393 :: 		UART4_Write_Text(buffer);
MOVW	R0, #lo_addr(_buffer+0)
MOVT	R0, #hi_addr(_buffer+0)
BL	_UART4_Write_Text+0
;clicker_2_STM32.c,394 :: 		}
L_end_THE_FUNCTION:
LDR	LR, [SP, #0]
ADD	SP, SP, #28
BX	LR
; end of _THE_FUNCTION
_main:
;clicker_2_STM32.c,396 :: 		void main() {
;clicker_2_STM32.c,398 :: 		GPIO_Digital_Output(&GPIOE_BASE, _GPIO_PINMASK_12 | _GPIO_PINMASK_15);
MOVW	R1, #36864
MOVW	R0, #lo_addr(GPIOE_BASE+0)
MOVT	R0, #hi_addr(GPIOE_BASE+0)
BL	_GPIO_Digital_Output+0
;clicker_2_STM32.c,399 :: 		LD1 = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(ODR12_GPIOE_ODR_bit+0)
MOVT	R0, #hi_addr(ODR12_GPIOE_ODR_bit+0)
STR	R1, [R0, #0]
;clicker_2_STM32.c,400 :: 		LD2 = 0;
MOVW	R0, #lo_addr(ODR15_GPIOE_ODR_bit+0)
MOVT	R0, #hi_addr(ODR15_GPIOE_ODR_bit+0)
STR	R1, [R0, #0]
;clicker_2_STM32.c,402 :: 		init_uart4();
BL	_init_uart4+0
;clicker_2_STM32.c,403 :: 		init_i2c2();
BL	_init_i2c2+0
;clicker_2_STM32.c,405 :: 		if (checkMPU6050() == 1) {
BL	_checkMPU6050+0
CMP	R0, #1
IT	NE
BNE	L_main35
;clicker_2_STM32.c,406 :: 		return;
IT	AL
BAL	L_end_main
;clicker_2_STM32.c,407 :: 		}
L_main35:
;clicker_2_STM32.c,409 :: 		if (selfTestMPU6050() == 1) {
BL	_selfTestMPU6050+0
CMP	R0, #1
IT	NE
BNE	L_main36
;clicker_2_STM32.c,410 :: 		return;
IT	AL
BAL	L_end_main
;clicker_2_STM32.c,411 :: 		}
L_main36:
;clicker_2_STM32.c,413 :: 		calculateAccelAndGyroBiases();
BL	_calculateAccelAndGyroBiases+0
;clicker_2_STM32.c,415 :: 		initMPU6050();
BL	_initMPU6050+0
;clicker_2_STM32.c,419 :: 		LD1 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(ODR12_GPIOE_ODR_bit+0)
MOVT	R0, #hi_addr(ODR12_GPIOE_ODR_bit+0)
STR	R1, [R0, #0]
;clicker_2_STM32.c,420 :: 		LD2 = 1;
MOVW	R0, #lo_addr(ODR15_GPIOE_ODR_bit+0)
MOVT	R0, #hi_addr(ODR15_GPIOE_ODR_bit+0)
STR	R1, [R0, #0]
;clicker_2_STM32.c,421 :: 		while(1);
L_main37:
IT	AL
BAL	L_main37
;clicker_2_STM32.c,422 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
