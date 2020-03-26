
_pulaLinha:

;analogico.c,6 :: 		void pulaLinha(void) {
;analogico.c,7 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;analogico.c,8 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;analogico.c,9 :: 		}
	RETURN      0
; end of _pulaLinha

_main:

;analogico.c,11 :: 		void main() {
;analogico.c,12 :: 		UART1_Init(19200);
	MOVLW       25
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;analogico.c,13 :: 		TRISB = 0B11110000;
	MOVLW       240
	MOVWF       TRISB+0 
;analogico.c,14 :: 		ADCON1 = 0B00001111;
	MOVLW       15
	MOVWF       ADCON1+0 
;analogico.c,15 :: 		PORTB = 0B00000000;
	CLRF        PORTB+0 
;analogico.c,16 :: 		while(1) {
L_main0:
;analogico.c,17 :: 		analogicDigital = ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _analogicDigital+0 
	MOVF        R1, 0 
	MOVWF       _analogicDigital+1 
;analogico.c,18 :: 		temp = ((float) analogicDigital * 5.0 / 1024.0) * 100.0;
	CALL        _Int2Double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       137
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _Double2Byte+0, 0
	MOVF        R0, 0 
	MOVWF       _temp+0 
;analogico.c,19 :: 		if (temp <= 24.0) {
	CALL        _Byte2Double+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       64
	MOVWF       R2 
	MOVLW       131
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main2
;analogico.c,20 :: 		PORTB = 0B00001000;
	MOVLW       8
	MOVWF       PORTB+0 
;analogico.c,21 :: 		}
L_main2:
;analogico.c,22 :: 		if (temp > 24.0 && temp <= 33.0) {
	MOVF        _temp+0, 0 
	MOVWF       R0 
	CALL        _Byte2Double+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       64
	MOVWF       R2 
	MOVLW       131
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main5
	MOVF        _temp+0, 0 
	MOVWF       R0 
	CALL        _Byte2Double+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       4
	MOVWF       R2 
	MOVLW       132
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main5
L__main14:
;analogico.c,23 :: 		PORTB = 0B00001100;
	MOVLW       12
	MOVWF       PORTB+0 
;analogico.c,24 :: 		}
L_main5:
;analogico.c,25 :: 		if (temp > 33.0 && temp <= 43.0) {
	MOVF        _temp+0, 0 
	MOVWF       R0 
	CALL        _Byte2Double+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       4
	MOVWF       R2 
	MOVLW       132
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main8
	MOVF        _temp+0, 0 
	MOVWF       R0 
	CALL        _Byte2Double+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       44
	MOVWF       R2 
	MOVLW       132
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main8
L__main13:
;analogico.c,26 :: 		PORTB = 0B00001110;
	MOVLW       14
	MOVWF       PORTB+0 
;analogico.c,27 :: 		}
L_main8:
;analogico.c,28 :: 		if (temp > 43.0 && temp <= 89.0) {
	MOVF        _temp+0, 0 
	MOVWF       R0 
	CALL        _Byte2Double+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       44
	MOVWF       R2 
	MOVLW       132
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main11
	MOVF        _temp+0, 0 
	MOVWF       R0 
	CALL        _Byte2Double+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       50
	MOVWF       R2 
	MOVLW       133
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main11
L__main12:
;analogico.c,29 :: 		PORTB = 0B00001111;
	MOVLW       15
	MOVWF       PORTB+0 
;analogico.c,30 :: 		}
L_main11:
;analogico.c,31 :: 		IntToStr(temp, text);
	MOVF        _temp+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _text+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_text+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;analogico.c,32 :: 		UART1_Write_Text(text);
	MOVLW       _text+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_text+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;analogico.c,33 :: 		pulaLinha();
	CALL        _pulaLinha+0, 0
;analogico.c,34 :: 		}
	GOTO        L_main0
;analogico.c,35 :: 		}
	GOTO        $+0
; end of _main
