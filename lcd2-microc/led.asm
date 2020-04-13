
_Pula_Linha:

;led.c,27 :: 		void Pula_Linha(void)
;led.c,29 :: 		UART1_WRITE(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;led.c,30 :: 		UART1_WRITE(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;led.c,31 :: 		}
	RETURN      0
; end of _Pula_Linha

_CustomChar:

;led.c,38 :: 		void CustomChar() {
;led.c,40 :: 		LCD_Cmd(64); //entra na CGRAM
	MOVLW       64
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;led.c,41 :: 		for (i = 0; i<=7; i++) LCD_Chr_Cp(character_0[i]); //grava 8 bytes na cgram ENDER 0 a 7  cgram
	CLRF        CustomChar_i_L0+0 
L_CustomChar0:
	MOVF        CustomChar_i_L0+0, 0 
	SUBLW       7
	BTFSS       STATUS+0, 0 
	GOTO        L_CustomChar1
	MOVLW       _character_0+0
	ADDWF       CustomChar_i_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_character_0+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_character_0+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_Lcd_Chr_CP_out_char+0
	CALL        _Lcd_Chr_CP+0, 0
	INCF        CustomChar_i_L0+0, 1 
	GOTO        L_CustomChar0
L_CustomChar1:
;led.c,42 :: 		for (i = 0; i<=7; i++) LCD_Chr_Cp(character_1[i]); //grava 8 bytes na cgram ENDER 8 a 15 cgram
	CLRF        CustomChar_i_L0+0 
L_CustomChar3:
	MOVF        CustomChar_i_L0+0, 0 
	SUBLW       7
	BTFSS       STATUS+0, 0 
	GOTO        L_CustomChar4
	MOVLW       _character_1+0
	ADDWF       CustomChar_i_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_character_1+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_character_1+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_Lcd_Chr_CP_out_char+0
	CALL        _Lcd_Chr_CP+0, 0
	INCF        CustomChar_i_L0+0, 1 
	GOTO        L_CustomChar3
L_CustomChar4:
;led.c,43 :: 		LCD_Cmd(_LCD_RETURN_HOME); //sai da cgram
	MOVLW       2
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;led.c,44 :: 		}
	RETURN      0
; end of _CustomChar

_Move_Delay:

;led.c,46 :: 		void Move_Delay() {                  // Function used for text moving
;led.c,47 :: 		Delay_ms(100);                     // You can change the moving speed here
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_Move_Delay6:
	DECFSZ      R13, 1, 0
	BRA         L_Move_Delay6
	DECFSZ      R12, 1, 0
	BRA         L_Move_Delay6
	DECFSZ      R11, 1, 0
	BRA         L_Move_Delay6
	NOP
;led.c,48 :: 		}
	RETURN      0
; end of _Move_Delay

_main:

;led.c,50 :: 		void main()
;led.c,52 :: 		UART1_Init(19200);
	MOVLW       25
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;led.c,53 :: 		UART1_Write_Text("Qual a Temperatura maxima\r");
	MOVLW       ?lstr1_led+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_led+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;led.c,54 :: 		UART1_Read_Text(entrada, enter, 32);
	MOVLW       _entrada+0
	MOVWF       FARG_UART1_Read_Text_Output+0 
	MOVLW       hi_addr(_entrada+0)
	MOVWF       FARG_UART1_Read_Text_Output+1 
	MOVLW       _enter+0
	MOVWF       FARG_UART1_Read_Text_Delimiter+0 
	MOVLW       hi_addr(_enter+0)
	MOVWF       FARG_UART1_Read_Text_Delimiter+1 
	MOVLW       32
	MOVWF       FARG_UART1_Read_Text_Attempts+0 
	CALL        _UART1_Read_Text+0, 0
;led.c,55 :: 		UART1_Write_Text(entrada);
	MOVLW       _entrada+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_entrada+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;led.c,56 :: 		temp = atoi(entrada);
	MOVLW       _entrada+0
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(_entrada+0)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
;led.c,58 :: 		ADCON1=0B00001110;
	MOVLW       14
	MOVWF       ADCON1+0 
;led.c,59 :: 		TRISB = 0B00001111;
	MOVLW       15
	MOVWF       TRISB+0 
;led.c,60 :: 		PORTB = 0B00000000;
	CLRF        PORTB+0 
;led.c,61 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;led.c,63 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;led.c,65 :: 		CustomChar();
	CALL        _CustomChar+0, 0
;led.c,67 :: 		Lcd_Out(1, 6, "Temperatura");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_led+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_led+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;led.c,72 :: 		while(1)
L_main7:
;led.c,74 :: 		AD = ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _AD+0 
	MOVF        R1, 0 
	MOVWF       _AD+1 
;led.c,75 :: 		Temperatura = ((float) AD * 5.0/1024.0) * 100.0;
	CALL        _Word2Double+0, 0
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
	MOVWF       _Temperatura+0 
;led.c,76 :: 		inttostr(Temperatura, TXT);
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _TXT+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_TXT+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;led.c,77 :: 		Lcd_Out(2, 6, TXT);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _TXT+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_TXT+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;led.c,78 :: 		Lcd_Chr_Cp(0);
	CLRF        FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;led.c,79 :: 		Lcd_Chr_CP('C');
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;led.c,80 :: 		Lcd_Out(3, 5, "Temp. Maxima");
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_led+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_led+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;led.c,81 :: 		inttostr(temp, TXT);
	MOVF        _temp+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _TXT+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_TXT+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;led.c,82 :: 		Lcd_Out(4, 6, TXT);
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _TXT+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_TXT+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;led.c,83 :: 		Lcd_Chr_Cp(0);
	CLRF        FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;led.c,84 :: 		Lcd_Chr_CP('C');
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;led.c,85 :: 		if (Temperatura > temp) {
	MOVLW       128
	XORWF       _temp+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main23
	MOVF        _Temperatura+0, 0 
	SUBWF       _temp+0, 0 
L__main23:
	BTFSC       STATUS+0, 0 
	GOTO        L_main9
;led.c,86 :: 		int i = 0;
	CLRF        main_i_L2+0 
	CLRF        main_i_L2+1 
;led.c,87 :: 		for(i=0; i<4; i++) {
	CLRF        main_i_L2+0 
	CLRF        main_i_L2+1 
L_main10:
	MOVLW       128
	XORWF       main_i_L2+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main24
	MOVLW       4
	SUBWF       main_i_L2+0, 0 
L__main24:
	BTFSC       STATUS+0, 0 
	GOTO        L_main11
;led.c,88 :: 		Lcd_Cmd(_LCD_SHIFT_RIGHT);
	MOVLW       28
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;led.c,89 :: 		Move_Delay();
	CALL        _Move_Delay+0, 0
;led.c,87 :: 		for(i=0; i<4; i++) {
	INFSNZ      main_i_L2+0, 1 
	INCF        main_i_L2+1, 1 
;led.c,90 :: 		}
	GOTO        L_main10
L_main11:
;led.c,91 :: 		for( i=0; i<4; i++) {
	CLRF        main_i_L2+0 
	CLRF        main_i_L2+1 
L_main13:
	MOVLW       128
	XORWF       main_i_L2+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main25
	MOVLW       4
	SUBWF       main_i_L2+0, 0 
L__main25:
	BTFSC       STATUS+0, 0 
	GOTO        L_main14
;led.c,92 :: 		Lcd_Cmd(_LCD_SHIFT_LEFT);
	MOVLW       24
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;led.c,93 :: 		Move_Delay();
	CALL        _Move_Delay+0, 0
;led.c,91 :: 		for( i=0; i<4; i++) {
	INFSNZ      main_i_L2+0, 1 
	INCF        main_i_L2+1, 1 
;led.c,94 :: 		}
	GOTO        L_main13
L_main14:
;led.c,95 :: 		}
L_main9:
;led.c,96 :: 		if (Temperatura > temp) {
	MOVLW       128
	XORWF       _temp+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main26
	MOVF        _Temperatura+0, 0 
	SUBWF       _temp+0, 0 
L__main26:
	BTFSC       STATUS+0, 0 
	GOTO        L_main16
;led.c,97 :: 		int i = 0;
	CLRF        main_i_L2_L2+0 
	CLRF        main_i_L2_L2+1 
;led.c,98 :: 		for(i=0; i<4; i++) {
	CLRF        main_i_L2_L2+0 
	CLRF        main_i_L2_L2+1 
L_main17:
	MOVLW       128
	XORWF       main_i_L2_L2+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main27
	MOVLW       4
	SUBWF       main_i_L2_L2+0, 0 
L__main27:
	BTFSC       STATUS+0, 0 
	GOTO        L_main18
;led.c,99 :: 		Lcd_Cmd(_LCD_SHIFT_LEFT);
	MOVLW       24
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;led.c,100 :: 		Move_Delay();
	CALL        _Move_Delay+0, 0
;led.c,98 :: 		for(i=0; i<4; i++) {
	INFSNZ      main_i_L2_L2+0, 1 
	INCF        main_i_L2_L2+1, 1 
;led.c,101 :: 		}
	GOTO        L_main17
L_main18:
;led.c,102 :: 		for( i=0; i<4; i++) {
	CLRF        main_i_L2_L2+0 
	CLRF        main_i_L2_L2+1 
L_main20:
	MOVLW       128
	XORWF       main_i_L2_L2+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main28
	MOVLW       4
	SUBWF       main_i_L2_L2+0, 0 
L__main28:
	BTFSC       STATUS+0, 0 
	GOTO        L_main21
;led.c,103 :: 		Lcd_Cmd(_LCD_SHIFT_RIGHT);
	MOVLW       28
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;led.c,104 :: 		Move_Delay();
	CALL        _Move_Delay+0, 0
;led.c,102 :: 		for( i=0; i<4; i++) {
	INFSNZ      main_i_L2_L2+0, 1 
	INCF        main_i_L2_L2+1, 1 
;led.c,105 :: 		}
	GOTO        L_main20
L_main21:
;led.c,106 :: 		}
L_main16:
;led.c,108 :: 		}
	GOTO        L_main7
;led.c,109 :: 		}
	GOTO        $+0
; end of _main
