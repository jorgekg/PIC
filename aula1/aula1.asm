
_main:

;aula1.c,3 :: 		void main() {
;aula1.c,4 :: 		TRISB = 0B11110000;
	MOVLW       240
	MOVWF       TRISB+0 
;aula1.c,5 :: 		ADCON1 = 0B00001111;
	MOVLW       15
	MOVWF       ADCON1+0 
;aula1.c,6 :: 		while (True) {
L_main0:
;aula1.c,7 :: 		if (PORTB.F6 == 1 && PORTB.F7 == 1) {
	BTFSS       PORTB+0, 6 
	GOTO        L_main4
	BTFSS       PORTB+0, 7 
	GOTO        L_main4
L__main8:
;aula1.c,8 :: 		if (PORTB.F4 == 1) {
	BTFSS       PORTB+0, 4 
	GOTO        L_main5
;aula1.c,9 :: 		PORTB = 0B11111111;
	MOVLW       255
	MOVWF       PORTB+0 
;aula1.c,10 :: 		continue;
	GOTO        L_main0
;aula1.c,11 :: 		} else {
L_main5:
;aula1.c,12 :: 		if (PORTB.F5 == 0) {
	BTFSC       PORTB+0, 5 
	GOTO        L_main7
;aula1.c,13 :: 		PORTB = 0B11111111;
	MOVLW       255
	MOVWF       PORTB+0 
;aula1.c,14 :: 		continue;
	GOTO        L_main0
;aula1.c,15 :: 		}
L_main7:
;aula1.c,17 :: 		}
L_main4:
;aula1.c,18 :: 		PORTB = 0B0000000;
	CLRF        PORTB+0 
;aula1.c,19 :: 		}
	GOTO        L_main0
;aula1.c,20 :: 		}
	GOTO        $+0
; end of _main
