
_print:

;Aula2.c,10 :: 		void print(char value) {
;Aula2.c,11 :: 		UART1_Write(value);
	MOVF        FARG_print_value+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Aula2.c,12 :: 		}
	RETURN      0
; end of _print

_printL:

;Aula2.c,14 :: 		void printL(char* value) {
;Aula2.c,15 :: 		UART1_Write_Text(value);
	MOVF        FARG_printL_value+0, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVF        FARG_printL_value+1, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Aula2.c,16 :: 		}
	RETURN      0
; end of _printL

_println:

;Aula2.c,18 :: 		void println(char* value) {
;Aula2.c,19 :: 		UART1_Write_Text(value);
	MOVF        FARG_println_value+0, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVF        FARG_println_value+1, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Aula2.c,20 :: 		print(13);
	MOVLW       13
	MOVWF       FARG_print_value+0 
	CALL        _print+0, 0
;Aula2.c,21 :: 		print(10);
	MOVLW       10
	MOVWF       FARG_print_value+0 
	CALL        _print+0, 0
;Aula2.c,22 :: 		}
	RETURN      0
; end of _println

_clear:

;Aula2.c,24 :: 		void clear() {
;Aula2.c,25 :: 		print(12);
	MOVLW       12
	MOVWF       FARG_print_value+0 
	CALL        _print+0, 0
;Aula2.c,26 :: 		}
	RETURN      0
; end of _clear

_main:

;Aula2.c,28 :: 		void main() {
;Aula2.c,29 :: 		TRISB = 0B11110000;
	MOVLW       240
	MOVWF       TRISB+0 
;Aula2.c,30 :: 		ADCON1 = 0B00001111;
	MOVLW       15
	MOVWF       ADCON1+0 
;Aula2.c,31 :: 		UART1_Init(19200);
	MOVLW       25
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;Aula2.c,32 :: 		while (True) {
L_main0:
;Aula2.c,33 :: 		if (draw == 3) {
	MOVF        _draw+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_main2
;Aula2.c,34 :: 		clear();
	CALL        _clear+0, 0
;Aula2.c,35 :: 		state = 3;
	MOVLW       3
	MOVWF       _state+0 
;Aula2.c,36 :: 		println("Automacao residencial");
	MOVLW       ?lstr1_Aula2+0
	MOVWF       FARG_println_value+0 
	MOVLW       hi_addr(?lstr1_Aula2+0)
	MOVWF       FARG_println_value+1 
	CALL        _println+0, 0
;Aula2.c,37 :: 		println("O que vc quer atuar? 1 - lampada ou 2 - janela");
	MOVLW       ?lstr2_Aula2+0
	MOVWF       FARG_println_value+0 
	MOVLW       hi_addr(?lstr2_Aula2+0)
	MOVWF       FARG_println_value+1 
	CALL        _println+0, 0
;Aula2.c,38 :: 		draw = 0;
	CLRF        _draw+0 
;Aula2.c,39 :: 		}
L_main2:
;Aula2.c,40 :: 		if (draw == 1) {
	MOVF        _draw+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main3
;Aula2.c,41 :: 		clear();
	CALL        _clear+0, 0
;Aula2.c,42 :: 		state = 1;
	MOVLW       1
	MOVWF       _state+0 
;Aula2.c,43 :: 		println("Automacao residencial");
	MOVLW       ?lstr3_Aula2+0
	MOVWF       FARG_println_value+0 
	MOVLW       hi_addr(?lstr3_Aula2+0)
	MOVWF       FARG_println_value+1 
	CALL        _println+0, 0
;Aula2.c,44 :: 		println("Qual lampada queres acesar? 1, 2, 3, 4");
	MOVLW       ?lstr4_Aula2+0
	MOVWF       FARG_println_value+0 
	MOVLW       hi_addr(?lstr4_Aula2+0)
	MOVWF       FARG_println_value+1 
	CALL        _println+0, 0
;Aula2.c,45 :: 		draw = 0;
	CLRF        _draw+0 
;Aula2.c,46 :: 		}
L_main3:
;Aula2.c,47 :: 		if (draw == 2) {
	MOVF        _draw+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
;Aula2.c,48 :: 		clear();
	CALL        _clear+0, 0
;Aula2.c,49 :: 		state = 2;
	MOVLW       2
	MOVWF       _state+0 
;Aula2.c,50 :: 		println("Qual estado? 1 ou 0");
	MOVLW       ?lstr5_Aula2+0
	MOVWF       FARG_println_value+0 
	MOVLW       hi_addr(?lstr5_Aula2+0)
	MOVWF       FARG_println_value+1 
	CALL        _println+0, 0
;Aula2.c,51 :: 		draw = 0;
	CLRF        _draw+0 
;Aula2.c,52 :: 		}
L_main4:
;Aula2.c,54 :: 		if(UART1_Data_Ready()==1) {
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main5
;Aula2.c,55 :: 		caracter = UART1_read();
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _caracter+0 
;Aula2.c,56 :: 		print(caracter);
	MOVF        R0, 0 
	MOVWF       FARG_print_value+0 
	CALL        _print+0, 0
;Aula2.c,57 :: 		if (state == 4) {
	MOVF        _state+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_main6
;Aula2.c,58 :: 		draw = 3;
	MOVLW       3
	MOVWF       _draw+0 
;Aula2.c,59 :: 		}
L_main6:
;Aula2.c,60 :: 		if (state == 3) {
	MOVF        _state+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_main7
;Aula2.c,61 :: 		if (caracter == '1') {
	MOVF        _caracter+0, 0 
	XORLW       49
	BTFSS       STATUS+0, 2 
	GOTO        L_main8
;Aula2.c,62 :: 		draw = 1;
	MOVLW       1
	MOVWF       _draw+0 
;Aula2.c,63 :: 		} else {
	GOTO        L_main9
L_main8:
;Aula2.c,64 :: 		printL("Janela 1 = ");
	MOVLW       ?lstr6_Aula2+0
	MOVWF       FARG_printL_value+0 
	MOVLW       hi_addr(?lstr6_Aula2+0)
	MOVWF       FARG_printL_value+1 
	CALL        _printL+0, 0
;Aula2.c,65 :: 		if (PORTB.F7) println("aberto"); else println("fechado");
	BTFSS       PORTB+0, 7 
	GOTO        L_main10
	MOVLW       ?lstr7_Aula2+0
	MOVWF       FARG_println_value+0 
	MOVLW       hi_addr(?lstr7_Aula2+0)
	MOVWF       FARG_println_value+1 
	CALL        _println+0, 0
	GOTO        L_main11
L_main10:
	MOVLW       ?lstr8_Aula2+0
	MOVWF       FARG_println_value+0 
	MOVLW       hi_addr(?lstr8_Aula2+0)
	MOVWF       FARG_println_value+1 
	CALL        _println+0, 0
L_main11:
;Aula2.c,67 :: 		printL("Janela 2 = ");
	MOVLW       ?lstr9_Aula2+0
	MOVWF       FARG_printL_value+0 
	MOVLW       hi_addr(?lstr9_Aula2+0)
	MOVWF       FARG_printL_value+1 
	CALL        _printL+0, 0
;Aula2.c,68 :: 		if (PORTB.F6) println("aberto"); else println("fechado");
	BTFSS       PORTB+0, 6 
	GOTO        L_main12
	MOVLW       ?lstr10_Aula2+0
	MOVWF       FARG_println_value+0 
	MOVLW       hi_addr(?lstr10_Aula2+0)
	MOVWF       FARG_println_value+1 
	CALL        _println+0, 0
	GOTO        L_main13
L_main12:
	MOVLW       ?lstr11_Aula2+0
	MOVWF       FARG_println_value+0 
	MOVLW       hi_addr(?lstr11_Aula2+0)
	MOVWF       FARG_println_value+1 
	CALL        _println+0, 0
L_main13:
;Aula2.c,70 :: 		printL("Janela 3 = ");
	MOVLW       ?lstr12_Aula2+0
	MOVWF       FARG_printL_value+0 
	MOVLW       hi_addr(?lstr12_Aula2+0)
	MOVWF       FARG_printL_value+1 
	CALL        _printL+0, 0
;Aula2.c,71 :: 		if (PORTB.F5) println("aberto"); else println("fechado");
	BTFSS       PORTB+0, 5 
	GOTO        L_main14
	MOVLW       ?lstr13_Aula2+0
	MOVWF       FARG_println_value+0 
	MOVLW       hi_addr(?lstr13_Aula2+0)
	MOVWF       FARG_println_value+1 
	CALL        _println+0, 0
	GOTO        L_main15
L_main14:
	MOVLW       ?lstr14_Aula2+0
	MOVWF       FARG_println_value+0 
	MOVLW       hi_addr(?lstr14_Aula2+0)
	MOVWF       FARG_println_value+1 
	CALL        _println+0, 0
L_main15:
;Aula2.c,73 :: 		printL("Janela 4 = ");
	MOVLW       ?lstr15_Aula2+0
	MOVWF       FARG_printL_value+0 
	MOVLW       hi_addr(?lstr15_Aula2+0)
	MOVWF       FARG_printL_value+1 
	CALL        _printL+0, 0
;Aula2.c,74 :: 		if (PORTB.F4) println("aberto"); else println("fechado");
	BTFSS       PORTB+0, 4 
	GOTO        L_main16
	MOVLW       ?lstr16_Aula2+0
	MOVWF       FARG_println_value+0 
	MOVLW       hi_addr(?lstr16_Aula2+0)
	MOVWF       FARG_println_value+1 
	CALL        _println+0, 0
	GOTO        L_main17
L_main16:
	MOVLW       ?lstr17_Aula2+0
	MOVWF       FARG_println_value+0 
	MOVLW       hi_addr(?lstr17_Aula2+0)
	MOVWF       FARG_println_value+1 
	CALL        _println+0, 0
L_main17:
;Aula2.c,75 :: 		println("Toque em qualquer teclar para continuar...");
	MOVLW       ?lstr18_Aula2+0
	MOVWF       FARG_println_value+0 
	MOVLW       hi_addr(?lstr18_Aula2+0)
	MOVWF       FARG_println_value+1 
	CALL        _println+0, 0
;Aula2.c,76 :: 		state = 4;
	MOVLW       4
	MOVWF       _state+0 
;Aula2.c,77 :: 		}
L_main9:
;Aula2.c,78 :: 		}
L_main7:
;Aula2.c,79 :: 		if (state == 1) {
	MOVF        _state+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main18
;Aula2.c,80 :: 		led = caracter;
	MOVF        _caracter+0, 0 
	MOVWF       _led+0 
;Aula2.c,81 :: 		draw = 2;
	MOVLW       2
	MOVWF       _draw+0 
;Aula2.c,82 :: 		}
L_main18:
;Aula2.c,83 :: 		if (state == 2) {
	MOVF        _state+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main19
;Aula2.c,84 :: 		draw = 3;
	MOVLW       3
	MOVWF       _draw+0 
;Aula2.c,85 :: 		if (led == '1') {
	MOVF        _led+0, 0 
	XORLW       49
	BTFSS       STATUS+0, 2 
	GOTO        L_main20
;Aula2.c,86 :: 		PORTB.F0 = caracter;
	BTFSC       _caracter+0, 0 
	GOTO        L__main24
	BCF         PORTB+0, 0 
	GOTO        L__main25
L__main24:
	BSF         PORTB+0, 0 
L__main25:
;Aula2.c,87 :: 		}
L_main20:
;Aula2.c,88 :: 		if (led == '2') {
	MOVF        _led+0, 0 
	XORLW       50
	BTFSS       STATUS+0, 2 
	GOTO        L_main21
;Aula2.c,89 :: 		PORTB.F1 = caracter;
	BTFSC       _caracter+0, 0 
	GOTO        L__main26
	BCF         PORTB+0, 1 
	GOTO        L__main27
L__main26:
	BSF         PORTB+0, 1 
L__main27:
;Aula2.c,90 :: 		}
L_main21:
;Aula2.c,91 :: 		if (led == '3') {
	MOVF        _led+0, 0 
	XORLW       51
	BTFSS       STATUS+0, 2 
	GOTO        L_main22
;Aula2.c,92 :: 		PORTB.F2 = caracter;
	BTFSC       _caracter+0, 0 
	GOTO        L__main28
	BCF         PORTB+0, 2 
	GOTO        L__main29
L__main28:
	BSF         PORTB+0, 2 
L__main29:
;Aula2.c,93 :: 		}
L_main22:
;Aula2.c,94 :: 		if (led == '4') {
	MOVF        _led+0, 0 
	XORLW       52
	BTFSS       STATUS+0, 2 
	GOTO        L_main23
;Aula2.c,95 :: 		PORTB.F3 = caracter;
	BTFSC       _caracter+0, 0 
	GOTO        L__main30
	BCF         PORTB+0, 3 
	GOTO        L__main31
L__main30:
	BSF         PORTB+0, 3 
L__main31:
;Aula2.c,96 :: 		}
L_main23:
;Aula2.c,97 :: 		}
L_main19:
;Aula2.c,98 :: 		}
L_main5:
;Aula2.c,99 :: 		}
	GOTO        L_main0
;Aula2.c,100 :: 		}
	GOTO        $+0
; end of _main
