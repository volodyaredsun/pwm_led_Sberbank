
;CodeVisionAVR C Compiler V2.05.0 Professional
;(C) Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type                : ATmega48PA
;Program type             : Application
;Clock frequency          : 8,000000 MHz
;Memory model             : Small
;Optimize for             : Size
;(s)printf features       : int, width
;(s)scanf features        : int, width
;External RAM size        : 0
;Data Stack size          : 128 byte(s)
;Heap size                : 0 byte(s)
;Promote 'char' to 'int'  : Yes
;'char' is unsigned       : Yes
;8 bit enums              : Yes
;global 'const' stored in FLASH: No
;Enhanced core instructions    : On
;Smart register allocation     : On
;Automatic register allocation : On

	#pragma AVRPART ADMIN PART_NAME ATmega48PA
	#pragma AVRPART MEMORY PROG_FLASH 4096
	#pragma AVRPART MEMORY EEPROM 256
	#pragma AVRPART MEMORY INT_SRAM SIZE 767
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x100

	.LISTMAC
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU EECR=0x1F
	.EQU EEDR=0x20
	.EQU EEARL=0x21
	.EQU EEARH=0x22
	.EQU SPSR=0x2D
	.EQU SPDR=0x2E
	.EQU SMCR=0x33
	.EQU MCUSR=0x34
	.EQU MCUCR=0x35
	.EQU WDTCSR=0x60
	.EQU UCSR0A=0xC0
	.EQU UDR0=0xC6
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU GPIOR0=0x1E

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0100
	.EQU __SRAM_END=0x02FF
	.EQU __DSTACK_SIZE=0x0080
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	RCALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __GETD1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X+
	LD   R22,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	RCALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _c=R4
	.DEF _PressedKey=R3

;GPIOR0 INITIALIZATION VALUE
	.EQU __GPIOR0_INIT=0x00

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	RJMP __RESET
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	WDR
	IN   R26,MCUSR
	CBR  R26,8
	OUT  MCUSR,R26
	STS  WDTCSR,R31
	STS  WDTCSR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,LOW(__SRAM_START)
	LDI  R27,HIGH(__SRAM_START)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GPIOR0 INITIALIZATION
	LDI  R30,__GPIOR0_INIT
	OUT  GPIOR0,R30

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	RJMP _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x180

	.CSEG
;/*****************************************************
;This program was produced by the
;CodeWizardAVR V2.05.0 Professional
;Automatic Program Generator
;© Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project : PWM LED 4 CHANNELS
;Version : 1.00
;Date    : 08.09.2012
;Author  : Volodya_VA
;Company :
;Comments:
;
;
;Chip type               : ATmega48PA
;AVR Core Clock frequency: 8,000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 128
;*****************************************************/
;
;#include <mega48a.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_adc_noise_red=0x02
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.SET power_ctrl_reg=smcr
	#endif
;#include <pwm_led.h>
;#include <delay.h>
;// Declare your global variables here
;
;void main(void)
; 0000 001D {

	.CSEG
_main:
; 0000 001E     InitPort();
	RCALL _InitPort
; 0000 001F     InitMCU();
	RCALL _InitMCU
; 0000 0020     PORTC.2 = 1;    // активен 1 канал
	SBI  0x8,2
; 0000 0021     c = 0;
	CLR  R4
; 0000 0022     PWM1 = pwm1;
	LDI  R26,LOW(_pwm1)
	LDI  R27,HIGH(_pwm1)
	RCALL __EEPROMRDB
	OUT  0x27,R30
; 0000 0023     PWM2 = pwm2;
	LDI  R26,LOW(_pwm2)
	LDI  R27,HIGH(_pwm2)
	RCALL __EEPROMRDB
	OUT  0x28,R30
; 0000 0024     PWM3 = pwm3;
	LDI  R26,LOW(_pwm3)
	LDI  R27,HIGH(_pwm3)
	RCALL __EEPROMRDB
	STS  179,R30
; 0000 0025     PWM4 = pwm4;
	LDI  R26,LOW(_pwm4)
	LDI  R27,HIGH(_pwm4)
	RCALL __EEPROMRDB
	STS  180,R30
; 0000 0026     if(PWM1 < 255)
	IN   R30,0x27
	CPI  R30,LOW(0xFF)
	BRSH _0x5
; 0000 0027     {
; 0000 0028         if(PWM1 > 0)
	IN   R30,0x27
	CPI  R30,LOW(0x1)
	BRLO _0x6
; 0000 0029         {
; 0000 002A             max = 0;
	RCALL SUBOPT_0x0
; 0000 002B             min = 0;
; 0000 002C         }
; 0000 002D         else
	RJMP _0xB
_0x6:
; 0000 002E         {
; 0000 002F             max = 0;
	RCALL SUBOPT_0x1
; 0000 0030             min = 1;
; 0000 0031         };
_0xB:
; 0000 0032     }
; 0000 0033     else
	RJMP _0x10
_0x5:
; 0000 0034     {
; 0000 0035         max = 1;
	RCALL SUBOPT_0x2
; 0000 0036         min = 0;
; 0000 0037     };
_0x10:
; 0000 0038 while (1)
_0x15:
; 0000 0039       {
; 0000 003A           ReadKey();
	RCALL _ReadKey
; 0000 003B           SW();
	RCALL _SW
; 0000 003C           PressedKey = KEY_NONE;
	CLR  R3
; 0000 003D       };
	RJMP _0x15
; 0000 003E };
_0x18:
	RJMP _0x18
;
;void SW(void)
; 0000 0041 {
_SW:
; 0000 0042     unsigned char tmax, tmin;   // память max и min
; 0000 0043     switch (PressedKey)
	RCALL __SAVELOCR2
;	tmax -> R17
;	tmin -> R16
	MOV  R30,R3
	RCALL SUBOPT_0x3
; 0000 0044     {
; 0000 0045         case KEY_UP:
	RCALL SUBOPT_0x4
	BRNE _0x1C
; 0000 0046         {
; 0000 0047             switch (c)
	RCALL SUBOPT_0x5
; 0000 0048             {
; 0000 0049                 case 0:
	BRNE _0x20
; 0000 004A                 {
; 0000 004B                     if(PWM1 < 255)
	IN   R30,0x27
	CPI  R30,LOW(0xFF)
	BRSH _0x21
; 0000 004C                     {
; 0000 004D                         PWM1++;
	IN   R30,0x27
	SUBI R30,-LOW(1)
	OUT  0x27,R30
	SUBI R30,LOW(1)
; 0000 004E                         DDRD.5 = 1;
	SBI  0xA,5
; 0000 004F                         max = 0;
	CBI  0xB,1
; 0000 0050                         min = 0;
	RJMP _0x10F
; 0000 0051                     }
; 0000 0052                     else
_0x21:
; 0000 0053                     {
; 0000 0054                         max = 1;
	SBI  0xB,1
; 0000 0055                         min = 0;
_0x10F:
	CBI  0xB,2
; 0000 0056                     };
; 0000 0057                     break;
	RJMP _0x1F
; 0000 0058                 };
; 0000 0059                 case 1:
_0x20:
	RCALL SUBOPT_0x4
	BRNE _0x2D
; 0000 005A                 {
; 0000 005B                     if(PWM2 < 255)
	IN   R30,0x28
	CPI  R30,LOW(0xFF)
	BRSH _0x2E
; 0000 005C                     {
; 0000 005D                         PWM2++;
	IN   R30,0x28
	SUBI R30,-LOW(1)
	OUT  0x28,R30
	SUBI R30,LOW(1)
; 0000 005E                         DDRD.6 = 1;
	SBI  0xA,6
; 0000 005F                         max = 0;
	CBI  0xB,1
; 0000 0060                         min = 0;
	RJMP _0x110
; 0000 0061                     }
; 0000 0062                     else
_0x2E:
; 0000 0063                     {
; 0000 0064                         max = 1;
	SBI  0xB,1
; 0000 0065                         min = 0;
_0x110:
	CBI  0xB,2
; 0000 0066                     };
; 0000 0067                     break;
	RJMP _0x1F
; 0000 0068                 };
; 0000 0069                 case 2:
_0x2D:
	RCALL SUBOPT_0x6
	BRNE _0x3A
; 0000 006A                 {
; 0000 006B                     if(PWM3 < 255)
	RCALL SUBOPT_0x7
	CPI  R26,LOW(0xFF)
	BRSH _0x3B
; 0000 006C                     {
; 0000 006D                         PWM3++;
	LDI  R26,LOW(179)
	LDI  R27,HIGH(179)
	LD   R30,X
	SUBI R30,-LOW(1)
	ST   X,R30
; 0000 006E                         DDRB.3 = 1;
	SBI  0x4,3
; 0000 006F                         max = 0;
	CBI  0xB,1
; 0000 0070                         min = 0;
	RJMP _0x111
; 0000 0071                     }
; 0000 0072                     else
_0x3B:
; 0000 0073                     {
; 0000 0074                         max = 1;
	SBI  0xB,1
; 0000 0075                         min = 0;
_0x111:
	CBI  0xB,2
; 0000 0076                     };
; 0000 0077                     break;
	RJMP _0x1F
; 0000 0078                 };
; 0000 0079                 case 3:
_0x3A:
	RCALL SUBOPT_0x8
	BRNE _0x1F
; 0000 007A                 {
; 0000 007B                     if(PWM4 < 255)
	RCALL SUBOPT_0x9
	CPI  R26,LOW(0xFF)
	BRSH _0x48
; 0000 007C                     {
; 0000 007D                         PWM4++;
	LDI  R26,LOW(180)
	LDI  R27,HIGH(180)
	LD   R30,X
	SUBI R30,-LOW(1)
	ST   X,R30
; 0000 007E                         DDRD.3 = 1;
	SBI  0xA,3
; 0000 007F                         max = 0;
	CBI  0xB,1
; 0000 0080                         min = 0;
	RJMP _0x112
; 0000 0081                     }
; 0000 0082                     else
_0x48:
; 0000 0083                     {
; 0000 0084                         max = 1;
	SBI  0xB,1
; 0000 0085                         min = 0;
_0x112:
	CBI  0xB,2
; 0000 0086                     };
; 0000 0087                     break;
; 0000 0088                 };
; 0000 0089             };
_0x1F:
; 0000 008A             break;
	RJMP _0x1B
; 0000 008B         };
; 0000 008C         case KEY_DWN:
_0x1C:
	RCALL SUBOPT_0x6
	BRNE _0x54
; 0000 008D         {
; 0000 008E              switch (c)
	RCALL SUBOPT_0x5
; 0000 008F             {
; 0000 0090                 case 0:
	BRNE _0x58
; 0000 0091                 {
; 0000 0092                     if(PWM1 > 0)
	IN   R30,0x27
	CPI  R30,LOW(0x1)
	BRLO _0x59
; 0000 0093                     {
; 0000 0094                         PWM1--;
	IN   R30,0x27
	SUBI R30,LOW(1)
	OUT  0x27,R30
	SUBI R30,-LOW(1)
; 0000 0095                         max = 0;
	RCALL SUBOPT_0x0
; 0000 0096                         min = 0;
; 0000 0097                     }
; 0000 0098                     else
	RJMP _0x5E
_0x59:
; 0000 0099                     {
; 0000 009A                         DDRD.5 = 0;
	CBI  0xA,5
; 0000 009B                         min = 1;
	RCALL SUBOPT_0xA
; 0000 009C                         max = 0;
; 0000 009D                     };
_0x5E:
; 0000 009E                     break;
	RJMP _0x57
; 0000 009F                 };
; 0000 00A0                 case 1:
_0x58:
	RCALL SUBOPT_0x4
	BRNE _0x65
; 0000 00A1                 {
; 0000 00A2                     if(PWM2 > 0)
	IN   R30,0x28
	CPI  R30,LOW(0x1)
	BRLO _0x66
; 0000 00A3                     {
; 0000 00A4                         PWM2--;
	IN   R30,0x28
	SUBI R30,LOW(1)
	OUT  0x28,R30
	SUBI R30,-LOW(1)
; 0000 00A5                         max = 0;
	RCALL SUBOPT_0x0
; 0000 00A6                         min = 0;
; 0000 00A7                     }
; 0000 00A8                     else
	RJMP _0x6B
_0x66:
; 0000 00A9                     {
; 0000 00AA                         DDRD.6 = 0;
	CBI  0xA,6
; 0000 00AB                         min = 1;
	RCALL SUBOPT_0xA
; 0000 00AC                         max = 0;
; 0000 00AD                     };
_0x6B:
; 0000 00AE                     break;
	RJMP _0x57
; 0000 00AF                 };
; 0000 00B0                 case 2:
_0x65:
	RCALL SUBOPT_0x6
	BRNE _0x72
; 0000 00B1                 {
; 0000 00B2                     if(PWM3 > 0)
	RCALL SUBOPT_0x7
	CPI  R26,LOW(0x1)
	BRLO _0x73
; 0000 00B3                     {
; 0000 00B4                         PWM3--;
	LDI  R26,LOW(179)
	LDI  R27,HIGH(179)
	RCALL SUBOPT_0xB
; 0000 00B5                         max = 0;
; 0000 00B6                         min = 0;
; 0000 00B7                     }
; 0000 00B8                     else
	RJMP _0x78
_0x73:
; 0000 00B9                     {
; 0000 00BA                         DDRB.3 = 0;
	CBI  0x4,3
; 0000 00BB                         min = 1;
	RCALL SUBOPT_0xA
; 0000 00BC                         max = 0;
; 0000 00BD                     };
_0x78:
; 0000 00BE                     break;
	RJMP _0x57
; 0000 00BF                 };
; 0000 00C0                 case 3:
_0x72:
	RCALL SUBOPT_0x8
	BRNE _0x57
; 0000 00C1                 {
; 0000 00C2                     if(PWM4 > 0)
	RCALL SUBOPT_0x9
	CPI  R26,LOW(0x1)
	BRLO _0x80
; 0000 00C3                     {
; 0000 00C4                         PWM4--;
	LDI  R26,LOW(180)
	LDI  R27,HIGH(180)
	RCALL SUBOPT_0xB
; 0000 00C5                         max = 0;
; 0000 00C6                         min = 0;
; 0000 00C7                     }
; 0000 00C8                     else
	RJMP _0x85
_0x80:
; 0000 00C9                     {
; 0000 00CA                         DDRD.3 = 0;
	CBI  0xA,3
; 0000 00CB                         min = 1;
	RCALL SUBOPT_0xA
; 0000 00CC                         max = 0;
; 0000 00CD                     };
_0x85:
; 0000 00CE                     break;
; 0000 00CF                 };
; 0000 00D0             };
_0x57:
; 0000 00D1             break;
	RJMP _0x1B
; 0000 00D2         };
; 0000 00D3         case KEY_CHANNEL:
_0x54:
	RCALL SUBOPT_0x8
	BREQ PC+2
	RJMP _0x8C
; 0000 00D4         {
; 0000 00D5             if(c<3)
	LDI  R30,LOW(3)
	CP   R4,R30
	BRSH _0x8D
; 0000 00D6             {
; 0000 00D7                 c++;
	INC  R4
; 0000 00D8             }
; 0000 00D9             else
	RJMP _0x8E
_0x8D:
; 0000 00DA             {
; 0000 00DB                 c = 0;
	CLR  R4
; 0000 00DC             };
_0x8E:
; 0000 00DD             switch (c)
	RCALL SUBOPT_0x5
; 0000 00DE             {
; 0000 00DF                 case 0:
	BRNE _0x92
; 0000 00E0                 {
; 0000 00E1                     PORTC.2 = 1;
	SBI  0x8,2
; 0000 00E2                     PORTC.3 = 0;
	CBI  0x8,3
; 0000 00E3                     PORTC.4 = 0;
	CBI  0x8,4
; 0000 00E4                     PORTC.5 = 0;
	CBI  0x8,5
; 0000 00E5                     if(PWM1 < 255)
	IN   R30,0x27
	CPI  R30,LOW(0xFF)
	BRSH _0x9B
; 0000 00E6                     {
; 0000 00E7                         if(PWM1 > 0)
	IN   R30,0x27
	CPI  R30,LOW(0x1)
	BRLO _0x9C
; 0000 00E8                         {
; 0000 00E9                             max = 0;
	RCALL SUBOPT_0x0
; 0000 00EA                             min = 0;
; 0000 00EB                         }
; 0000 00EC                         else
	RJMP _0xA1
_0x9C:
; 0000 00ED                         {
; 0000 00EE                             max = 0;
	RCALL SUBOPT_0x1
; 0000 00EF                             min = 1;
; 0000 00F0                         };
_0xA1:
; 0000 00F1                     }
; 0000 00F2                     else
	RJMP _0xA6
_0x9B:
; 0000 00F3                     {
; 0000 00F4                         max = 1;
	RCALL SUBOPT_0x2
; 0000 00F5                         min = 0;
; 0000 00F6                     };
_0xA6:
; 0000 00F7                     break;
	RJMP _0x91
; 0000 00F8                 };
; 0000 00F9                 case 1:
_0x92:
	RCALL SUBOPT_0x4
	BRNE _0xAB
; 0000 00FA                 {
; 0000 00FB                     if(PWM2 < 255)
	IN   R30,0x28
	CPI  R30,LOW(0xFF)
	BRSH _0xAC
; 0000 00FC                     {
; 0000 00FD                         if(PWM2 > 0)
	IN   R30,0x28
	CPI  R30,LOW(0x1)
	BRLO _0xAD
; 0000 00FE                         {
; 0000 00FF                             max = 0;
	RCALL SUBOPT_0x0
; 0000 0100                             min = 0;
; 0000 0101                         }
; 0000 0102                         else
	RJMP _0xB2
_0xAD:
; 0000 0103                         {
; 0000 0104                             max = 0;
	RCALL SUBOPT_0x1
; 0000 0105                             min = 1;
; 0000 0106                         };
_0xB2:
; 0000 0107                     }
; 0000 0108                     else
	RJMP _0xB7
_0xAC:
; 0000 0109                     {
; 0000 010A                         max = 1;
	RCALL SUBOPT_0x2
; 0000 010B                         min = 0;
; 0000 010C                     };
_0xB7:
; 0000 010D                     PORTC.2 = 0;
	CBI  0x8,2
; 0000 010E                     PORTC.3 = 1;
	SBI  0x8,3
; 0000 010F                     PORTC.4 = 0;
	CBI  0x8,4
; 0000 0110                     PORTC.5 = 0;
	CBI  0x8,5
; 0000 0111                     break;
	RJMP _0x91
; 0000 0112                 };
; 0000 0113                 case 2:
_0xAB:
	RCALL SUBOPT_0x6
	BRNE _0xC4
; 0000 0114                 {
; 0000 0115                     if(PWM3 < 255)
	RCALL SUBOPT_0x7
	CPI  R26,LOW(0xFF)
	BRSH _0xC5
; 0000 0116                     {
; 0000 0117                         if(PWM3 > 0)
	RCALL SUBOPT_0x7
	CPI  R26,LOW(0x1)
	BRLO _0xC6
; 0000 0118                         {
; 0000 0119                             max = 0;
	RCALL SUBOPT_0x0
; 0000 011A                             min = 0;
; 0000 011B                         }
; 0000 011C                         else
	RJMP _0xCB
_0xC6:
; 0000 011D                         {
; 0000 011E                             max = 0;
	RCALL SUBOPT_0x1
; 0000 011F                             min = 1;
; 0000 0120                         };
_0xCB:
; 0000 0121                     }
; 0000 0122                     else
	RJMP _0xD0
_0xC5:
; 0000 0123                     {
; 0000 0124                         max = 1;
	RCALL SUBOPT_0x2
; 0000 0125                         min = 0;
; 0000 0126                     };
_0xD0:
; 0000 0127                     PORTC.2 = 0;
	CBI  0x8,2
; 0000 0128                     PORTC.3 = 0;
	CBI  0x8,3
; 0000 0129                     PORTC.4 = 1;
	SBI  0x8,4
; 0000 012A                     PORTC.5 = 0;
	CBI  0x8,5
; 0000 012B                     break;
	RJMP _0x91
; 0000 012C                 };
; 0000 012D                 case 3:
_0xC4:
	RCALL SUBOPT_0x8
	BRNE _0x91
; 0000 012E                 {
; 0000 012F                     if(PWM4 < 255)
	RCALL SUBOPT_0x9
	CPI  R26,LOW(0xFF)
	BRSH _0xDE
; 0000 0130                     {
; 0000 0131                         if(PWM4 > 0)
	RCALL SUBOPT_0x9
	CPI  R26,LOW(0x1)
	BRLO _0xDF
; 0000 0132                         {
; 0000 0133                             max = 0;
	RCALL SUBOPT_0x0
; 0000 0134                             min = 0;
; 0000 0135                         }
; 0000 0136                         else
	RJMP _0xE4
_0xDF:
; 0000 0137                         {
; 0000 0138                             max = 0;
	RCALL SUBOPT_0x1
; 0000 0139                             min = 1;
; 0000 013A                         };
_0xE4:
; 0000 013B                     }
; 0000 013C                     else
	RJMP _0xE9
_0xDE:
; 0000 013D                     {
; 0000 013E                         max = 1;
	RCALL SUBOPT_0x2
; 0000 013F                         min = 0;
; 0000 0140                     };
_0xE9:
; 0000 0141                     PORTC.2 = 0;
	CBI  0x8,2
; 0000 0142                     PORTC.3 = 0;
	CBI  0x8,3
; 0000 0143                     PORTC.4 = 0;
	CBI  0x8,4
; 0000 0144                     PORTC.5 = 1;
	SBI  0x8,5
; 0000 0145                     break;
; 0000 0146                 };
; 0000 0147             };
_0x91:
; 0000 0148             break;
	RJMP _0x1B
; 0000 0149         };
; 0000 014A         case KEY_SAVE:
_0x8C:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0xF6
; 0000 014B         {
; 0000 014C             pwm1 = PWM1;
	IN   R30,0x27
	LDI  R26,LOW(_pwm1)
	LDI  R27,HIGH(_pwm1)
	RCALL __EEPROMWRB
; 0000 014D             pwm2 = PWM2;
	IN   R30,0x28
	LDI  R26,LOW(_pwm2)
	LDI  R27,HIGH(_pwm2)
	RCALL __EEPROMWRB
; 0000 014E             pwm3 = PWM3;
	LDS  R30,179
	LDI  R26,LOW(_pwm3)
	LDI  R27,HIGH(_pwm3)
	RCALL __EEPROMWRB
; 0000 014F             pwm4 = PWM4;
	LDS  R30,180
	LDI  R26,LOW(_pwm4)
	LDI  R27,HIGH(_pwm4)
	RCALL __EEPROMWRB
; 0000 0150             tmax = max;
	LDI  R30,0
	SBIC 0xB,1
	LDI  R30,1
	MOV  R17,R30
; 0000 0151             tmin = min;
	LDI  R30,0
	SBIC 0xB,2
	LDI  R30,1
	MOV  R16,R30
; 0000 0152             max = 1;
	SBI  0xB,1
; 0000 0153             min = 1;
	SBI  0xB,2
; 0000 0154             delay_ms(2000);
	LDI  R30,LOW(2000)
	LDI  R31,HIGH(2000)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _delay_ms
; 0000 0155             max = tmax;
	CPI  R17,0
	BRNE _0xFB
	CBI  0xB,1
	RJMP _0xFC
_0xFB:
	SBI  0xB,1
_0xFC:
; 0000 0156             min = tmin;
	CPI  R16,0
	BRNE _0xFD
	CBI  0xB,2
	RJMP _0xFE
_0xFD:
	SBI  0xB,2
_0xFE:
; 0000 0157             break;
; 0000 0158         };
; 0000 0159         case KEY_NONE: break;
_0xF6:
; 0000 015A     };
_0x1B:
; 0000 015B };
	RCALL __LOADLOCR2P
	RET
;
;void InitPort(void)
; 0000 015E {
_InitPort:
; 0000 015F     PORTB=0x00;
	LDI  R30,LOW(0)
	OUT  0x5,R30
; 0000 0160     DDRB = (0<<0)|(0<<1)|(0<<2)|(1<<3)|(0<<4)|(0<<5)|(0<<6)|(0<<7);
	LDI  R30,LOW(8)
	OUT  0x4,R30
; 0000 0161 
; 0000 0162     PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x8,R30
; 0000 0163     DDRC = 0xff;//(1<<0)|(1<<1)|(1<<2)|(1<<3)|(1<<4)|(1<<5);
	LDI  R30,LOW(255)
	OUT  0x7,R30
; 0000 0164 
; 0000 0165     PORTD=0x00;
	LDI  R30,LOW(0)
	OUT  0xB,R30
; 0000 0166     DDRD = (0<<0)|(1<<1)|(1<<2)|(1<<3)|(0<<4)|(1<<5)|(1<<6)|(0<<7);
	LDI  R30,LOW(110)
	OUT  0xA,R30
; 0000 0167 };
	RET
;
;void InitMCU(void)
; 0000 016A {
_InitMCU:
; 0000 016B     // Crystal Oscillator division factor: 1
; 0000 016C     #pragma optsize-
; 0000 016D     CLKPR=0x80;
	LDI  R30,LOW(128)
	STS  97,R30
; 0000 016E     CLKPR=0x00;
	LDI  R30,LOW(0)
	STS  97,R30
; 0000 016F     #ifdef _OPTIMIZE_SIZE_
; 0000 0170     #pragma optsize+
; 0000 0171     #endif
; 0000 0172 
; 0000 0173     // Timer/Counter 0 initialization
; 0000 0174     // Clock source: System Clock
; 0000 0175     // Clock value: 0,977 kHz
; 0000 0176     // Mode: Fast PWM top=0xFF
; 0000 0177     // OC0A output: Non-Inverted PWM
; 0000 0178     // OC0B output: Non-Inverted PWM
; 0000 0179     TCCR0A=0xA3;
	LDI  R30,LOW(163)
	OUT  0x24,R30
; 0000 017A     TCCR0B=0x03;
	LDI  R30,LOW(3)
	OUT  0x25,R30
; 0000 017B     TCNT0=0x00;
	LDI  R30,LOW(0)
	OUT  0x26,R30
; 0000 017C     OCR0A=0x00;
	OUT  0x27,R30
; 0000 017D     OCR0B=0x00;
	OUT  0x28,R30
; 0000 017E 
; 0000 017F     TCCR1A=0x00;
	STS  128,R30
; 0000 0180     TCCR1B=0x00;
	STS  129,R30
; 0000 0181     TCNT1H=0x00;
	STS  133,R30
; 0000 0182     TCNT1L=0x00;
	STS  132,R30
; 0000 0183     ICR1H=0x00;
	STS  135,R30
; 0000 0184     ICR1L=0x00;
	STS  134,R30
; 0000 0185     OCR1AH=0x00;
	STS  137,R30
; 0000 0186     OCR1AL=0x00;
	STS  136,R30
; 0000 0187     OCR1BH=0x00;
	STS  139,R30
; 0000 0188     OCR1BL=0x00;
	STS  138,R30
; 0000 0189 
; 0000 018A     // Timer/Counter 2 initialization
; 0000 018B     // Clock source: System Clock
; 0000 018C     // Clock value: 0,977 kHz
; 0000 018D     // Mode: Fast PWM top=0xFF
; 0000 018E     // OC2A output: Non-Inverted PWM
; 0000 018F     // OC2B output: Non-Inverted PWM
; 0000 0190     ASSR=0x00;
	STS  182,R30
; 0000 0191     TCCR2A=0xA3;
	LDI  R30,LOW(163)
	STS  176,R30
; 0000 0192     TCCR2B=0x04;
	LDI  R30,LOW(4)
	STS  177,R30
; 0000 0193     TCNT2=0x00;
	LDI  R30,LOW(0)
	STS  178,R30
; 0000 0194     OCR2A=0x00;
	STS  179,R30
; 0000 0195     OCR2B=0x00;
	STS  180,R30
; 0000 0196 
; 0000 0197     // External Interrupt(s) initialization
; 0000 0198     // INT0: Off
; 0000 0199     // INT1: Off
; 0000 019A     // Interrupt on any change on pins PCINT0-7: Off
; 0000 019B     // Interrupt on any change on pins PCINT8-14: Off
; 0000 019C     // Interrupt on any change on pins PCINT16-23: Off
; 0000 019D     EICRA=0x00;
	STS  105,R30
; 0000 019E     EIMSK=0x00;
	OUT  0x1D,R30
; 0000 019F     PCICR=0x00;
	STS  104,R30
; 0000 01A0 
; 0000 01A1     // Timer/Counter 0 Interrupt(s) initialization
; 0000 01A2     TIMSK0=0x00;
	STS  110,R30
; 0000 01A3 
; 0000 01A4     // Timer/Counter 1 Interrupt(s) initialization
; 0000 01A5     TIMSK1=0x00;
	STS  111,R30
; 0000 01A6 
; 0000 01A7     // Timer/Counter 2 Interrupt(s) initialization
; 0000 01A8     TIMSK2=0x00;
	STS  112,R30
; 0000 01A9 
; 0000 01AA     // USART initialization
; 0000 01AB     // USART disabled
; 0000 01AC     UCSR0B=0x00;
	STS  193,R30
; 0000 01AD 
; 0000 01AE     // Analog Comparator initialization
; 0000 01AF     // Analog Comparator: Off
; 0000 01B0     // Analog Comparator Input Capture by Timer/Counter 1: Off
; 0000 01B1     ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x30,R30
; 0000 01B2     ADCSRB=0x00;
	LDI  R30,LOW(0)
	STS  123,R30
; 0000 01B3     DIDR1=0x00;
	STS  127,R30
; 0000 01B4 
; 0000 01B5     // ADC initialization
; 0000 01B6     // ADC disabled
; 0000 01B7     ADCSRA=0x00;
	STS  122,R30
; 0000 01B8 
; 0000 01B9     // SPI initialization
; 0000 01BA     // SPI disabled
; 0000 01BB     SPCR=0x00;
	OUT  0x2C,R30
; 0000 01BC 
; 0000 01BD     // TWI initialization
; 0000 01BE     // TWI disabled
; 0000 01BF     TWCR=0x00;
	STS  188,R30
; 0000 01C0 };
	RET
;
;void ReadKey(void)
; 0000 01C3 {
_ReadKey:
; 0000 01C4     static unsigned char key;
; 0000 01C5     static int CountKey;
; 0000 01C6     if((up==0)&&(dwn==0)){key = KEY_SAVE;}else
	LDI  R26,0
	SBIC 0x9,7
	LDI  R26,1
	CPI  R26,LOW(0x0)
	BRNE _0x101
	LDI  R26,0
	SBIC 0x3,1
	LDI  R26,1
	CPI  R26,LOW(0x0)
	BREQ _0x102
_0x101:
	RJMP _0x100
_0x102:
	LDI  R30,LOW(4)
	RJMP _0x113
_0x100:
; 0000 01C7     if(up==0){key = KEY_UP;}else
	SBIC 0x9,7
	RJMP _0x104
	LDI  R30,LOW(1)
	RJMP _0x113
_0x104:
; 0000 01C8     if(dwn==0){key = KEY_DWN;}else
	SBIC 0x3,1
	RJMP _0x106
	LDI  R30,LOW(2)
	RJMP _0x113
_0x106:
; 0000 01C9     if(channel==0){key = KEY_CHANNEL;}
	SBIC 0x3,0
	RJMP _0x108
	LDI  R30,LOW(3)
	RJMP _0x113
; 0000 01CA     else{key = KEY_NONE;};
_0x108:
	LDI  R30,LOW(0)
_0x113:
	STS  _key_S0000004000,R30
; 0000 01CB 
; 0000 01CC     if(key)
	CPI  R30,0
	BREQ _0x10A
; 0000 01CD     {
; 0000 01CE         if(CountKey > OLD_PRESS)
	RCALL SUBOPT_0xC
	CPI  R26,LOW(0x4E21)
	LDI  R30,HIGH(0x4E21)
	CPC  R27,R30
	BRLT _0x10B
; 0000 01CF         {
; 0000 01D0             CountKey = OLD_PRESS - SPEED_OLD_PRESS;
	LDI  R30,LOW(19500)
	LDI  R31,HIGH(19500)
	STS  _CountKey_S0000004000,R30
	STS  _CountKey_S0000004000+1,R31
; 0000 01D1             PressedKey = key;
	LDS  R3,_key_S0000004000
; 0000 01D2         }
; 0000 01D3         else
	RJMP _0x10C
_0x10B:
; 0000 01D4         {
; 0000 01D5             CountKey++;
	LDI  R26,LOW(_CountKey_S0000004000)
	LDI  R27,HIGH(_CountKey_S0000004000)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
; 0000 01D6         };
_0x10C:
; 0000 01D7         if(CountKey == ONE_PRESS)
	RCALL SUBOPT_0xC
	CPI  R26,LOW(0x3E8)
	LDI  R30,HIGH(0x3E8)
	CPC  R27,R30
	BRNE _0x10D
; 0000 01D8         {
; 0000 01D9             PressedKey = key;
	LDS  R3,_key_S0000004000
; 0000 01DA         };
_0x10D:
; 0000 01DB     }
; 0000 01DC     else {CountKey = 0;};
	RJMP _0x10E
_0x10A:
	LDI  R30,LOW(0)
	STS  _CountKey_S0000004000,R30
	STS  _CountKey_S0000004000+1,R30
_0x10E:
; 0000 01DD };
	RET
;

	.ESEG
_pwm1:
	.BYTE 0x1
_pwm2:
	.BYTE 0x1
_pwm3:
	.BYTE 0x1
_pwm4:
	.BYTE 0x1

	.DSEG
_key_S0000004000:
	.BYTE 0x1
_CountKey_S0000004000:
	.BYTE 0x2

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x0:
	CBI  0xB,1
	CBI  0xB,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x1:
	CBI  0xB,1
	SBI  0xB,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x2:
	SBI  0xB,1
	CBI  0xB,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x3:
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x4:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x5:
	MOV  R30,R4
	RCALL SUBOPT_0x3
	SBIW R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x6:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x7:
	LDS  R26,179
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x8:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x9:
	LDS  R26,180
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xA:
	SBI  0xB,2
	CBI  0xB,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xB:
	LD   R30,X
	SUBI R30,LOW(1)
	ST   X,R30
	RJMP SUBOPT_0x0

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xC:
	LDS  R26,_CountKey_S0000004000
	LDS  R27,_CountKey_S0000004000+1
	RET


	.CSEG
_delay_ms:
	ld   r30,y+
	ld   r31,y+
	adiw r30,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r30,1
	brne __delay_ms0
__delay_ms1:
	ret

__EEPROMRDB:
	SBIC EECR,EEWE
	RJMP __EEPROMRDB
	PUSH R31
	IN   R31,SREG
	CLI
	OUT  EEARL,R26
	SBI  EECR,EERE
	IN   R30,EEDR
	OUT  SREG,R31
	POP  R31
	RET

__EEPROMWRB:
	SBIS EECR,EEWE
	RJMP __EEPROMWRB1
	WDR
	RJMP __EEPROMWRB
__EEPROMWRB1:
	IN   R25,SREG
	CLI
	OUT  EEARL,R26
	SBI  EECR,EERE
	IN   R24,EEDR
	CP   R30,R24
	BREQ __EEPROMWRB0
	OUT  EEDR,R30
	SBI  EECR,EEMWE
	SBI  EECR,EEWE
__EEPROMWRB0:
	OUT  SREG,R25
	RET

__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR2P:
	LD   R16,Y+
	LD   R17,Y+
	RET

;END OF CODE MARKER
__END_OF_CODE:
