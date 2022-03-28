;*******Header Files***********
list	    p=18f4550        ; list directive to define processor
#include    "p18f4550.inc"

;******Configuration Bits***********
; PIC18F4550 Configuration Bit Settings

; ASM source line config statements

;#include "p18F4550.inc"

; CONFIG1L
  CONFIG  PLLDIV = 5            ; PLL Prescaler Selection bits (Divide by 5 (20 MHz oscillator input))
  CONFIG  CPUDIV = OSC3_PLL4    ; System Clock Postscaler Selection bits ([Primary Oscillator Src: /3][96 MHz PLL Src: /4])
  CONFIG  USBDIV = 2            ; USB Clock Selection bit (used in Full-Speed USB mode only; UCFG:FSEN = 1) (USB clock source comes from the 96 MHz PLL divided by 2)

; CONFIG1H
  CONFIG  FOSC = INTOSC_HS      ; Oscillator Selection bits (Internal oscillator, HS oscillator used by USB (INTHS))
  CONFIG  FCMEN = OFF           ; Fail-Safe Clock Monitor Enable bit (Fail-Safe Clock Monitor disabled)
  CONFIG  IESO = OFF            ; Internal/External Oscillator Switchover bit (Oscillator Switchover mode disabled)

; CONFIG2L
  CONFIG  PWRT = ON             ; Power-up Timer Enable bit (PWRT enabled)
  CONFIG  BOR = OFF             ; Brown-out Reset Enable bits (Brown-out Reset disabled in hardware and software)
  CONFIG  BORV = 3              ; Brown-out Reset Voltage bits (Minimum setting 2.05V)
  CONFIG  VREGEN = OFF          ; USB Voltage Regulator Enable bit (USB voltage regulator disabled)

; CONFIG2H
  CONFIG  WDT = OFF             ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
  CONFIG  WDTPS = 32768         ; Watchdog Timer Postscale Select bits (1:32768)

; CONFIG3H
  CONFIG  CCP2MX = OFF          ; CCP2 MUX bit (CCP2 input/output is multiplexed with RB3)
  CONFIG  PBADEN = ON           ; PORTB A/D Enable bit (PORTB<4:0> pins are configured as analog input channels on Reset)
  CONFIG  LPT1OSC = OFF         ; Low-Power Timer 1 Oscillator Enable bit (Timer1 configured for higher power operation)
  CONFIG  MCLRE = ON            ; MCLR Pin Enable bit (MCLR pin enabled; RE3 input pin disabled)

; CONFIG4L
  CONFIG  STVREN = OFF          ; Stack Full/Underflow Reset Enable bit (Stack full/underflow will not cause Reset)
  CONFIG  LVP = OFF             ; Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)
  CONFIG  ICPRT = OFF           ; Dedicated In-Circuit Debug/Programming Port (ICPORT) Enable bit (ICPORT disabled)
  CONFIG  XINST = OFF           ; Extended Instruction Set Enable bit (Instruction set extension and Indexed Addressing mode disabled (Legacy mode))

; CONFIG5L
  CONFIG  CP0 = OFF             ; Code Protection bit (Block 0 (000800-001FFFh) is not code-protected)
  CONFIG  CP1 = OFF             ; Code Protection bit (Block 1 (002000-003FFFh) is not code-protected)
  CONFIG  CP2 = OFF             ; Code Protection bit (Block 2 (004000-005FFFh) is not code-protected)
  CONFIG  CP3 = OFF             ; Code Protection bit (Block 3 (006000-007FFFh) is not code-protected)

; CONFIG5H
  CONFIG  CPB = OFF             ; Boot Block Code Protection bit (Boot block (000000-0007FFh) is not code-protected)
  CONFIG  CPD = OFF             ; Data EEPROM Code Protection bit (Data EEPROM is not code-protected)

; CONFIG6L
  CONFIG  WRT0 = OFF            ; Write Protection bit (Block 0 (000800-001FFFh) is not write-protected)
  CONFIG  WRT1 = OFF            ; Write Protection bit (Block 1 (002000-003FFFh) is not write-protected)
  CONFIG  WRT2 = OFF            ; Write Protection bit (Block 2 (004000-005FFFh) is not write-protected)
  CONFIG  WRT3 = OFF            ; Write Protection bit (Block 3 (006000-007FFFh) is not write-protected)

; CONFIG6H
  CONFIG  WRTC = OFF            ; Configuration Register Write Protection bit (Configuration registers (300000-3000FFh) are not write-protected)
  CONFIG  WRTB = OFF            ; Boot Block Write Protection bit (Boot block (000000-0007FFh) is not write-protected)
  CONFIG  WRTD = OFF            ; Data EEPROM Write Protection bit (Data EEPROM is not write-protected)

; CONFIG7L
  CONFIG  EBTR0 = OFF           ; Table Read Protection bit (Block 0 (000800-001FFFh) is not protected from table reads executed in other blocks)
  CONFIG  EBTR1 = OFF           ; Table Read Protection bit (Block 1 (002000-003FFFh) is not protected from table reads executed in other blocks)
  CONFIG  EBTR2 = OFF           ; Table Read Protection bit (Block 2 (004000-005FFFh) is not protected from table reads executed in other blocks)
  CONFIG  EBTR3 = OFF           ; Table Read Protection bit (Block 3 (006000-007FFFh) is not protected from table reads executed in other blocks)

; CONFIG7H
  CONFIG  EBTRB = OFF           ; Boot Block Table Read Protection bit (Boot block (000000-0007FFh) is not protected from table reads executed in other blocks)


;*****Variables Definition************

SPEED			EQU	0x00
MINS_LOOP		EQU	0x01
DECS_LOOP		EQU	0x02
DECS			EQU	0X03
DELAY			EQU	0x04
R2			EQU	0x05
R1			EQU	0x06
MINS_VAL		EQU     0x07
PREVAL1			EQU	0x08
DIEZ			EQU	0x09
SEIS			EQU	0x0A
PREVAL2 		EQU	0x0B
PREVAL3 		EQU	0x0C
; 

CONSTANT		MASKA = b'00001111'
CONSTANT		MASKB = b'11110000'
;*****Main code**********
			ORG     0x000             	;reset vector
  			GOTO    MAIN              	;go to the main routine

INITIALIZE:		
    
			;Bits para push buttons
			BSF	TRISC, 0     ;PAUSAR
			BSF	TRISC, 1     ;INICIAR
			BSF	TRISC, 2     ;PRECHARGE
			
			
			;Puerto para display MINUTOS
			BCF	TRISD, 0
			BCF	TRISD, 1
			BCF	TRISD, 2
			BCF	TRISD, 3
			BCF	TRISD, 4
			BCF	TRISD, 5
			BCF	TRISD, 6
			BCF	TRISD, 7
			
			;Puerto para display SEGUNDOS1
			BCF	TRISB, 0
			BCF	TRISB, 1
			BCF	TRISB, 2
			BCF	TRISB, 3
			BCF	TRISB, 4
			BCF	TRISB, 5
			BCF	TRISB, 6
			BCF	TRISB, 7
			
			;Puerto para display SEGUNDOS2
			BCF	TRISA, 0
			BCF	TRISA, 1
			BCF	TRISA, 2
			BCF	TRISA, 3
			BCF	TRISA, 4
			BCF	TRISA, 5
			BCF	TRISA, 6
			BCF	TRISA, 7
			

			
			MOVLW	0x0F
			MOVWF	ADCON1
			
			
		
			RETURN				

MAIN:
			CALL 	INITIALIZE

LOOP:			CALL	START

		
START:
			MOVLW	0x3F	    ;INICIAR TIMER EN 3:00
			MOVWF	PORTB
			
			MOVLW	0x3F
			MOVWF	PORTD
			
			MOVLW	0x4F
			MOVWF	PORTA
			
			
			BTFSC	PORTC, 0   ;WAIT FOR START
			GOTO	START_TIMER
			
			MOVLW	0x16
			MOVWF	PREVAL1
			
			MOVLW	0x0E
			MOVWF	PREVAL2
			
			MOVLW	0x06
			MOVWF	PREVAL3
			
			BTFSC	PORTC, 2    ;PRECHARGE
			GOTO	PRECHARGE
			
			CALL	PAUSE	    ;DELAY
			GOTO	LOOP
START_TIMER:
			
			
			;INICIALIZAR VALORES DE SPEED Y DISPLAYS
			MOVLW	0x06	    ;SET SPEED AT 1 SE
			MOVWF	SPEED
			
			MOVLW	0x06	    ;INITIALIZE MINS AT 3
			MOVWF   MINS_VAL
			
			MOVLW	0x0C	    ;INITIALIZE DECS AT 6
			MOVWF	DECS
			
			MOVLW	0x03	    ;REPETIR 3 VECES
			MOVWF	MINS_LOOP
			
			GOTO	TIMER
			
			
PRECHARGE:		
			MOVLW	0x06	    ;SET SPEED AT 1 SE
			MOVWF	SPEED
			
			BTFSC	PORTC,  2	    ;CHANGE DISPLAY
			CALL	SET_VALUE
			
			BTFSC	PORTC, 0	    ;START TIMER AT DESIRED TIME
			GOTO	START_PRECHARGE
			
			CALL	PAUSE		    ;DELAY
			GOTO    PRECHARGE	    ;LOOP
    
SET_VALUE:		
			MOVLW	0x02		    ;RESTAR UN NUMERO
			SUBWF	PREVAL1
			MOVF	PREVAL1,0
					
			CALL	CHANGE_SECS_PRE	    ;IMPRIMIR SECS
PD1:			MOVWF	PORTB
			
			
			
			
			RETURN
			
CHANGE_SECS_PRE:		
			ADDWF   PCL,1
			GOTO	RESET_SECS
			RETLW   0x06    ;1
			RETLW   0x5B    ;2
			RETLW   0x4F    ;3
			RETLW   0x66    ;4
			RETLW   0x6D    ;5
			RETLW   0x7D    ;6
			RETLW	0x07	;7
			RETLW	0x7F	;8
			CALL	CHANGE_DECS_PRE	;9 CAMBIAR DECENAS
			RETLW	0x67
			
RESET_SECS:		MOVLW	0x16
			MOVWF	PREVAL1
			MOVLW	0x3F
			GOTO	PD1


CHANGE_DECS_PRE:	
			
			MOVLW	0x02	    ;RESTAR A DECENAS
			SUBWF	PREVAL2
			MOVF	PREVAL2,0
			
			CALL	PRINT_DECS  ;PRINT DECENAS
PD2:			MOVWF	PORTD
			
			RETURN

PRINT_DECS:		ADDWF   PCL,1
			GOTO	RESET_DECS
			RETLW   0x06    ;1
			RETLW   0x5B    ;2
			RETLW   0x4F    ;3
			RETLW   0x66    ;4
			CALL	CHANGE_MINS_PRE    ;5
			RETLW	0x6D
			
RESET_DECS:		MOVLW	0x0E
			MOVWF	PREVAL2
			MOVLW	0x3F
			GOTO	PD2

CHANGE_MINS_PRE:	
			
			MOVLW	0x02	    ;RESTAR A DECENAS
			SUBWF	PREVAL3
			MOVF	PREVAL3,0
			
			CALL    PRINT_MINS
			MOVWF	PORTA
			
			RETURN
    
PRINT_MINS:	        ADDWF   PCL,1
			RETLW   0x3F
			RETLW   0x06    ;1
			RETLW   0x5B    ;2
			RETLW   0x4F    ;3

START_PRECHARGE:	MOVLW	0x06	    ;SET SPEED AT 1 SE
			MOVWF	SPEED
			
			MOVLW	0X02
			SUBWF	PREVAL3
			MOVF	PREVAL3,0
			CALL	CHOOSE_MINS_START
			;MOVLW	0x06	    ;INITIALIZE MINS AT 3
			MOVWF   MINS_VAL
			
			MOVLW	0X02
			SUBWF	PREVAL2
			MOVF	PREVAL2,0
			CALL	CHOOSE_DECS_START
			;MOVLW	0x0A	    ;INITIALIZE DECS AT 6
			MOVWF	DECS
			
			MOVLW	0x03	    ;REPETIR 3 VECES
			MOVWF	MINS_LOOP
			
			MOVLW	0x06
			ADDWF	PREVAL1
			MOVF	PREVAL1,0
			GOTO	CHOOSE_START
			
CHOOSE_MINS_START:	ADDWF	PCL,1
			RETLW	0X0
			RETLW	0X02
			RETLW	0X04
			RETLW	0X06

CHOOSE_DECS_START:	ADDWF	PCL,1
			RETLW	0X0
			RETLW	0X02
			RETLW	0X04
			RETLW	0X06
			RETLW	0X08
			RETLW	0X0A
			
    
    
CHOOSE_START:		ADDWF	PCL,1
			GOTO	CERO
			GOTO	UNO
			GOTO	DOS
			GOTO	TRES
			GOTO	CUATRO
			GOTO	CINCO
			GOTO	SIX
			GOTO	SIETE
			GOTO	OCHO
			GOTO	NUEVE
			
			

BUTTONS:		BTFSC	PORTC,1
			GOTO	STOP
			RETURN
			
STOP:			
			BTFSC	PORTC,0
			RETURN
			GOTO	STOP
CHOOSE_SPEED:		
			ADDWF	PCL,1
			RETLW	0X01
			RETLW	0X01	    ;0.1 segs
			;BTFSC	PORTB,3
			RETLW	0X05	    ;0.5 segs
			;BTFSC	PORTB,4
			RETLW	0X0A	    ;1 segs
			;BTFSC	PORTB,5
			RETLW	0X32	    ;5 segs
			;BTFSC	PORTB,6
			RETLW	0x64	    ;10 segs
			
    
PAUSE:			
			CALL	BUTTONS
			MOVF	SPEED,0
			CALL	CHOOSE_SPEED	;Elegir número de repeticiones
			
			MOVWF	DELAY
RETARDO3:
			MOVLW	0x50  ;80
			MOVWF	R2
RETARDO2:			
			MOVLW	0xC8  ;250
			MOVWF	R1
RETARDO:		
			NOP
			NOP
			DECFSZ	R1
			GOTO RETARDO
			
			DECFSZ	R2
			GOTO RETARDO2
			
			DECFSZ  DELAY
			GOTO RETARDO3
			
			RETURN
			
			

TIMER:			MOVLW	0x06	    ;REPETIR 6 VECES
			MOVWF	DECS_LOOP   
			;;BAJAR MINS;;
			
			MOVLW	0x02
			SUBWF	MINS_VAL,0    ;SUMAR A MINS
			MOVWF	MINS_VAL
			
			CALL	CHANGE_MINS ;CHANGE MINS
			
			MOVWF	PORTA	    ;CARGAR MINS EN DISPLAY
			
			;;BAJAR MINS;;
			
SECS:			
			
			
			MOVLW	0x3F	    ;0
			MOVWF	PORTB
			
			CALL	PAUSE
			
			;BAJAR DECS;;
			MOVLW	0x02	    ;sumar a DECS
			SUBWF	DECS,0
			MOVWF	DECS
			
			
			CALL	CHANGE_DECS ;CHANGE DEC NUMBER
			
			MOVWF	PORTD	    ;CARGAR DECS EN 2DO DISPLAY
			
			;;BAJAR DECS;;
			
NUEVE:			MOVLW	0x67	    ;9
			MOVWF	PORTB
			
			CALL	PAUSE
			
OCHO:			MOVLW	0x7F	    ;8
			MOVWF	PORTB
			
			CALL	PAUSE
			
SIETE:			MOVLW	0x07	    ;7
			MOVWF	PORTB
			
			CALL	PAUSE
			
SIX:			MOVLW	0x7D	    ;6
			MOVWF	PORTB
			
			CALL	PAUSE
			
CINCO:			MOVLW	0x6D	    ;5
			MOVWF	PORTB
			
			CALL	PAUSE
			
CUATRO:			MOVLW	0x66	    ;4
			MOVWF	PORTB
			
			CALL	PAUSE
			
TRES:			MOVLW	0x4F	    ;3
			MOVWF	PORTB
			
			CALL	PAUSE
			
DOS:			MOVLW	0x5B	    ;2
			MOVWF	PORTB
			
			CALL	PAUSE
			
UNO:			MOVLW	0x06	    ;1
			MOVWF	PORTB
			
			CALL	PAUSE
			
CERO:			MOVLW	0x3F	    ;0
			MOVWF	PORTB
			
			
			DECFSZ	DECS_LOOP   
			GOTO	SECS	    ;IMPRIMIR DE 0 A 59
			
			MOVLW	0x0C	    ;RESETEAR DECS
			MOVWF	DECS
			
			
			DECFSZ	MINS_LOOP
			GOTO	TIMER
			
			MOVLW	0x06
			MOVWF	MINS_VAL    ;RESETEAR MINS
			
			
			MOVLW	0x02
			MOVWF	SPEED
			GOTO	LOOP	    

CHANGE_DECS:		
		    ADDWF   PCL,1
		    RETLW   0x3F
		    RETLW   0x06    ;1
		    RETLW   0x5B    ;2
		    RETLW   0x4F    ;3
		    RETLW   0x66    ;4
		    RETLW   0x6D    ;5
		    RETLW   0x3F    ;6
		    
CHANGE_MINS:		
		    ADDWF   PCL,1
		    RETLW   0x3F
		    RETLW   0x06    ;1
		    RETLW   0x5B    ;2
		    RETLW   0x4F  
		    
			
			END                       	;end of the main program