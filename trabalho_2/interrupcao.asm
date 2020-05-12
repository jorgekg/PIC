
_interrupt:

;interrupcao.c,44 :: 		void interrupt() {
;interrupcao.c,45 :: 		if(int0if_bit)
	BTFSS       INT0IF_bit+0, 1 
	GOTO        L_interrupt0
;interrupcao.c,47 :: 		cnt2++;
	INFSNZ      _cnt2+0, 1 
	INCF        _cnt2+1, 1 
;interrupcao.c,48 :: 		PORTA.F2 = ~PORTA.F2;
	BTG         PORTA+0, 2 
;interrupcao.c,49 :: 		int0if_bit=0;   // clear int0if_bit
	BCF         INT0IF_bit+0, 1 
;interrupcao.c,51 :: 		}
L_interrupt0:
;interrupcao.c,53 :: 		if (TMR2IF_bit) {
	BTFSS       TMR2IF_bit+0, 1 
	GOTO        L_interrupt1
;interrupcao.c,54 :: 		cnt++;
	INFSNZ      _cnt+0, 1 
	INCF        _cnt+1, 1 
;interrupcao.c,55 :: 		if (cnt >= 1000) {
	MOVLW       128
	XORWF       _cnt+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt92
	MOVLW       232
	SUBWF       _cnt+0, 0 
L__interrupt92:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt2
;interrupcao.c,56 :: 		if (peca_por_min == 0) {
	MOVLW       0
	XORWF       _peca_por_min+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt93
	MOVLW       0
	XORWF       _peca_por_min+0, 0 
L__interrupt93:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt3
;interrupcao.c,57 :: 		peca_por_min = cnt2 * 60;
	MOVF        _cnt2+0, 0 
	MOVWF       R0 
	MOVF        _cnt2+1, 0 
	MOVWF       R1 
	MOVLW       60
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _peca_por_min+0 
	MOVF        R1, 0 
	MOVWF       _peca_por_min+1 
;interrupcao.c,59 :: 		}
L_interrupt3:
;interrupcao.c,60 :: 		PORTA.F1 = ~PORTA.F1;
	BTG         PORTA+0, 1 
;interrupcao.c,61 :: 		cnt = 0;
	CLRF        _cnt+0 
	CLRF        _cnt+1 
;interrupcao.c,62 :: 		}
L_interrupt2:
;interrupcao.c,63 :: 		TMR2IF_bit = 0;        // clear TMR2IF
	BCF         TMR2IF_bit+0, 1 
;interrupcao.c,64 :: 		}
L_interrupt1:
;interrupcao.c,65 :: 		}
L__interrupt91:
	RETFIE      1
; end of _interrupt

_InitTimer2:

;interrupcao.c,67 :: 		void InitTimer2(){
;interrupcao.c,68 :: 		T2CON         = 0x3C;
	MOVLW       60
	MOVWF       T2CON+0 
;interrupcao.c,69 :: 		TMR2IE_bit         = 1;
	BSF         TMR2IE_bit+0, 1 
;interrupcao.c,70 :: 		PR2                 = 249;
	MOVLW       249
	MOVWF       PR2+0 
;interrupcao.c,71 :: 		INTCON         = 0xD0;  //INTCON = 1100 0000 (HABILITA TMR2 INTERRUPT E INT0 INTERRUPT)
	MOVLW       208
	MOVWF       INTCON+0 
;interrupcao.c,72 :: 		}
	RETURN      0
; end of _InitTimer2

_Le_Teclado:

;interrupcao.c,74 :: 		short Le_Teclado()
;interrupcao.c,76 :: 		PORTD = 0B00010000; // VOCÊ SELECIONOU LA
	MOVLW       16
	MOVWF       PORTD+0 
;interrupcao.c,77 :: 		if (PORTA.RA5 == 1) {while(PORTA.RA5==1); return '7';};
	BTFSS       PORTA+0, 5 
	GOTO        L_Le_Teclado4
L_Le_Teclado5:
	BTFSS       PORTA+0, 5 
	GOTO        L_Le_Teclado6
	GOTO        L_Le_Teclado5
L_Le_Teclado6:
	MOVLW       55
	MOVWF       R0 
	RETURN      0
L_Le_Teclado4:
;interrupcao.c,78 :: 		if (PORTB.RB1 == 1) {while(PORTB.RB1==1); return '8';};
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado7
L_Le_Teclado8:
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado9
	GOTO        L_Le_Teclado8
L_Le_Teclado9:
	MOVLW       56
	MOVWF       R0 
	RETURN      0
L_Le_Teclado7:
;interrupcao.c,79 :: 		if (PORTB.RB2 == 1) {while(PORTB.RB2==1); return '9';};
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado10
L_Le_Teclado11:
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado12
	GOTO        L_Le_Teclado11
L_Le_Teclado12:
	MOVLW       57
	MOVWF       R0 
	RETURN      0
L_Le_Teclado10:
;interrupcao.c,80 :: 		if (PORTB.RB3 == 1) {while(PORTB.RB3==1); return '%';};
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado13
L_Le_Teclado14:
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado15
	GOTO        L_Le_Teclado14
L_Le_Teclado15:
	MOVLW       37
	MOVWF       R0 
	RETURN      0
L_Le_Teclado13:
;interrupcao.c,82 :: 		PORTD = 0B00100000; // VOCÊ SELECIONOU LB
	MOVLW       32
	MOVWF       PORTD+0 
;interrupcao.c,83 :: 		if (PORTA.RA5 == 1) {while(PORTA.RA5==1);return '4';};
	BTFSS       PORTA+0, 5 
	GOTO        L_Le_Teclado16
L_Le_Teclado17:
	BTFSS       PORTA+0, 5 
	GOTO        L_Le_Teclado18
	GOTO        L_Le_Teclado17
L_Le_Teclado18:
	MOVLW       52
	MOVWF       R0 
	RETURN      0
L_Le_Teclado16:
;interrupcao.c,84 :: 		if (PORTB.RB1 == 1) {while(PORTB.RB1==1);return '5';};
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado19
L_Le_Teclado20:
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado21
	GOTO        L_Le_Teclado20
L_Le_Teclado21:
	MOVLW       53
	MOVWF       R0 
	RETURN      0
L_Le_Teclado19:
;interrupcao.c,85 :: 		if (PORTB.RB2 == 1) {while(PORTB.RB2==1);return '6';};
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado22
L_Le_Teclado23:
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado24
	GOTO        L_Le_Teclado23
L_Le_Teclado24:
	MOVLW       54
	MOVWF       R0 
	RETURN      0
L_Le_Teclado22:
;interrupcao.c,86 :: 		if (PORTB.RB3 == 1) {while(PORTB.RB3==1);return '*';};
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado25
L_Le_Teclado26:
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado27
	GOTO        L_Le_Teclado26
L_Le_Teclado27:
	MOVLW       42
	MOVWF       R0 
	RETURN      0
L_Le_Teclado25:
;interrupcao.c,88 :: 		PORTD = 0B01000000; // VOCÊ SELECIONOU LC
	MOVLW       64
	MOVWF       PORTD+0 
;interrupcao.c,89 :: 		if (PORTA.RA5 == 1) {while(PORTA.RA5==1);return '1';};
	BTFSS       PORTA+0, 5 
	GOTO        L_Le_Teclado28
L_Le_Teclado29:
	BTFSS       PORTA+0, 5 
	GOTO        L_Le_Teclado30
	GOTO        L_Le_Teclado29
L_Le_Teclado30:
	MOVLW       49
	MOVWF       R0 
	RETURN      0
L_Le_Teclado28:
;interrupcao.c,90 :: 		if (PORTB.RB1 == 1) {while(PORTB.RB1==1);return '2';};
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado31
L_Le_Teclado32:
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado33
	GOTO        L_Le_Teclado32
L_Le_Teclado33:
	MOVLW       50
	MOVWF       R0 
	RETURN      0
L_Le_Teclado31:
;interrupcao.c,91 :: 		if (PORTB.RB2 == 1) {while(PORTB.RB2==1);return '3';};
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado34
L_Le_Teclado35:
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado36
	GOTO        L_Le_Teclado35
L_Le_Teclado36:
	MOVLW       51
	MOVWF       R0 
	RETURN      0
L_Le_Teclado34:
;interrupcao.c,92 :: 		if (PORTB.RB3 == 1) {while(PORTB.RB3==1);return '-';};
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado37
L_Le_Teclado38:
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado39
	GOTO        L_Le_Teclado38
L_Le_Teclado39:
	MOVLW       45
	MOVWF       R0 
	RETURN      0
L_Le_Teclado37:
;interrupcao.c,94 :: 		PORTD = 0B10000000; // VOCÊ SELECIONOU LD
	MOVLW       128
	MOVWF       PORTD+0 
;interrupcao.c,95 :: 		if (PORTA.RA5 == 1) {while(PORTA.RA5==1);return 'C';};
	BTFSS       PORTA+0, 5 
	GOTO        L_Le_Teclado40
L_Le_Teclado41:
	BTFSS       PORTA+0, 5 
	GOTO        L_Le_Teclado42
	GOTO        L_Le_Teclado41
L_Le_Teclado42:
	MOVLW       67
	MOVWF       R0 
	RETURN      0
L_Le_Teclado40:
;interrupcao.c,96 :: 		if (PORTB.RB1 == 1) {while(PORTB.RB1==1);return '0';};
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado43
L_Le_Teclado44:
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado45
	GOTO        L_Le_Teclado44
L_Le_Teclado45:
	MOVLW       48
	MOVWF       R0 
	RETURN      0
L_Le_Teclado43:
;interrupcao.c,97 :: 		if (PORTB.RB2 == 1) {while(PORTB.RB2==1);return '=';};
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado46
L_Le_Teclado47:
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado48
	GOTO        L_Le_Teclado47
L_Le_Teclado48:
	MOVLW       61
	MOVWF       R0 
	RETURN      0
L_Le_Teclado46:
;interrupcao.c,98 :: 		if (PORTB.RB3 == 1) {while(PORTB.RB3==1);return '+';};
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado49
L_Le_Teclado50:
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado51
	GOTO        L_Le_Teclado50
L_Le_Teclado51:
	MOVLW       43
	MOVWF       R0 
	RETURN      0
L_Le_Teclado49:
;interrupcao.c,100 :: 		return 255;
	MOVLW       255
	MOVWF       R0 
;interrupcao.c,101 :: 		}
	RETURN      0
; end of _Le_Teclado

_Pula_Linha:

;interrupcao.c,103 :: 		void Pula_Linha(void)
;interrupcao.c,105 :: 		UART1_WRITE(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;interrupcao.c,106 :: 		UART1_WRITE(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;interrupcao.c,107 :: 		}
	RETURN      0
; end of _Pula_Linha

_Move_Delay:

;interrupcao.c,109 :: 		void Move_Delay() {                  // Function used for text moving
;interrupcao.c,110 :: 		Delay_ms(100);                     // You can change the moving speed here
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_Move_Delay52:
	DECFSZ      R13, 1, 0
	BRA         L_Move_Delay52
	DECFSZ      R12, 1, 0
	BRA         L_Move_Delay52
	DECFSZ      R11, 1, 0
	BRA         L_Move_Delay52
	NOP
;interrupcao.c,111 :: 		}
	RETURN      0
; end of _Move_Delay

_CustomChar:

;interrupcao.c,135 :: 		void CustomChar() {
;interrupcao.c,137 :: 		LCD_Cmd(64); //entra na
	MOVLW       64
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;interrupcao.c,138 :: 		for (i = 0; i<=7; i++) LCD_Chr_Cp(character_0[i]); //grava 8 bytes na cgram ENDER 0 a 7  cgram
	CLRF        CustomChar_i_L0+0 
L_CustomChar53:
	MOVF        CustomChar_i_L0+0, 0 
	SUBLW       7
	BTFSS       STATUS+0, 0 
	GOTO        L_CustomChar54
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
	GOTO        L_CustomChar53
L_CustomChar54:
;interrupcao.c,139 :: 		for (i = 0; i<=7; i++) LCD_Chr_Cp(character_1[i]); //grava 8 bytes na cgram ENDER 8 a 15 cgram
	CLRF        CustomChar_i_L0+0 
L_CustomChar56:
	MOVF        CustomChar_i_L0+0, 0 
	SUBLW       7
	BTFSS       STATUS+0, 0 
	GOTO        L_CustomChar57
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
	GOTO        L_CustomChar56
L_CustomChar57:
;interrupcao.c,140 :: 		for (i = 0; i<=7; i++) LCD_Chr_Cp(character_2[i]); //grava 8 bytes na cgram ENDER 8 a 15 cgram
	CLRF        CustomChar_i_L0+0 
L_CustomChar59:
	MOVF        CustomChar_i_L0+0, 0 
	SUBLW       7
	BTFSS       STATUS+0, 0 
	GOTO        L_CustomChar60
	MOVLW       _character_2+0
	ADDWF       CustomChar_i_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_character_2+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_character_2+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_Lcd_Chr_CP_out_char+0
	CALL        _Lcd_Chr_CP+0, 0
	INCF        CustomChar_i_L0+0, 1 
	GOTO        L_CustomChar59
L_CustomChar60:
;interrupcao.c,141 :: 		for (i = 0; i<=7; i++) LCD_Chr_Cp(character_3[i]); //grava 8 bytes na cgram ENDER 8 a 15 cgram
	CLRF        CustomChar_i_L0+0 
L_CustomChar62:
	MOVF        CustomChar_i_L0+0, 0 
	SUBLW       7
	BTFSS       STATUS+0, 0 
	GOTO        L_CustomChar63
	MOVLW       _character_3+0
	ADDWF       CustomChar_i_L0+0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_character_3+0)
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      TBLPTRH, 1 
	MOVLW       higher_addr(_character_3+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_Lcd_Chr_CP_out_char+0
	CALL        _Lcd_Chr_CP+0, 0
	INCF        CustomChar_i_L0+0, 1 
	GOTO        L_CustomChar62
L_CustomChar63:
;interrupcao.c,142 :: 		LCD_Cmd(_LCD_RETURN_HOME); //sai da cgram
	MOVLW       2
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;interrupcao.c,143 :: 		}
	RETURN      0
; end of _CustomChar

_Create_World:

;interrupcao.c,145 :: 		void Create_World() {
;interrupcao.c,146 :: 		objects_location_x[PACMAN] = 0;
	CLRF        _objects_location_x+0 
	CLRF        _objects_location_x+1 
;interrupcao.c,147 :: 		objects_location_y[PACMAN] = 0;
	CLRF        _objects_location_y+0 
	CLRF        _objects_location_y+1 
;interrupcao.c,149 :: 		for(i = 0; i < WORLD_WIDTH; ++i) {
	CLRF        _i+0 
	CLRF        _i+1 
L_Create_World65:
	MOVLW       128
	XORWF       _i+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       0
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Create_World94
	MOVLW       20
	SUBWF       _i+0, 0 
L__Create_World94:
	BTFSC       STATUS+0, 0 
	GOTO        L_Create_World66
;interrupcao.c,150 :: 		for(j = 0; j < WORLD_HEIGHT ; ++j)
	CLRF        _j+0 
	CLRF        _j+1 
L_Create_World68:
	MOVLW       128
	XORWF       _j+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       0
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Create_World95
	MOVLW       4
	SUBWF       _j+0, 0 
L__Create_World95:
	BTFSC       STATUS+0, 0 
	GOTO        L_Create_World69
;interrupcao.c,152 :: 		world[i][j] = '-';
	MOVF        _i+0, 0 
	MOVWF       R0 
	MOVF        _i+1, 0 
	MOVWF       R1 
	MOVLW       20
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _world+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_world+0)
	ADDWFC      R1, 1 
	MOVF        _j+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVF        _j+1, 0 
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       45
	MOVWF       POSTINC1+0 
;interrupcao.c,150 :: 		for(j = 0; j < WORLD_HEIGHT ; ++j)
	INFSNZ      _j+0, 1 
	INCF        _j+1, 1 
;interrupcao.c,153 :: 		}
	GOTO        L_Create_World68
L_Create_World69:
;interrupcao.c,149 :: 		for(i = 0; i < WORLD_WIDTH; ++i) {
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;interrupcao.c,154 :: 		}
	GOTO        L_Create_World65
L_Create_World66:
;interrupcao.c,155 :: 		inttostr(TXT, objects_location_x[PACMAN]);
	MOVLW       _TXT+0
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       hi_addr(_TXT+0)
	MOVWF       FARG_IntToStr_input+1 
	MOVF        _objects_location_x+0, 0 
	MOVWF       FARG_IntToStr_output+0 
	MOVF        _objects_location_x+1, 0 
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;interrupcao.c,156 :: 		UART1_Write_Text(TXT);
	MOVLW       _TXT+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_TXT+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;interrupcao.c,157 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;interrupcao.c,158 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;interrupcao.c,159 :: 		inttostr(TXT, objects_location_y[PACMAN]);
	MOVLW       _TXT+0
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       hi_addr(_TXT+0)
	MOVWF       FARG_IntToStr_input+1 
	MOVF        _objects_location_y+0, 0 
	MOVWF       FARG_IntToStr_output+0 
	MOVF        _objects_location_y+1, 0 
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;interrupcao.c,160 :: 		UART1_Write_Text(TXT);
	MOVLW       _TXT+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_TXT+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;interrupcao.c,161 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;interrupcao.c,162 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;interrupcao.c,163 :: 		world[objects_location_x[PACMAN]][objects_location_y[PACMAN]] = pacman_orientation;
	MOVF        _objects_location_x+0, 0 
	MOVWF       R0 
	MOVF        _objects_location_x+1, 0 
	MOVWF       R1 
	MOVLW       20
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _world+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_world+0)
	ADDWFC      R1, 1 
	MOVF        _objects_location_y+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVF        _objects_location_y+1, 0 
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        _pacman_orientation+0, 0 
	MOVWF       POSTINC1+0 
;interrupcao.c,164 :: 		}
	RETURN      0
; end of _Create_World

_Print_World:

;interrupcao.c,166 :: 		void Print_World() {
;interrupcao.c,167 :: 		for(i = 0; i < WORLD_WIDTH; ++i) {
	CLRF        _i+0 
	CLRF        _i+1 
L_Print_World71:
	MOVLW       128
	XORWF       _i+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       0
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Print_World96
	MOVLW       20
	SUBWF       _i+0, 0 
L__Print_World96:
	BTFSC       STATUS+0, 0 
	GOTO        L_Print_World72
;interrupcao.c,168 :: 		for(j = 0; j < WORLD_HEIGHT ; ++j)
	CLRF        _j+0 
	CLRF        _j+1 
L_Print_World74:
	MOVLW       128
	XORWF       _j+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       0
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Print_World97
	MOVLW       4
	SUBWF       _j+0, 0 
L__Print_World97:
	BTFSC       STATUS+0, 0 
	GOTO        L_Print_World75
;interrupcao.c,170 :: 		Lcd_Chr(j + 1, i + 1, world[i][j]);
	MOVF        _j+0, 0 
	ADDLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVF        _i+0, 0 
	ADDLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _i+0, 0 
	MOVWF       R0 
	MOVF        _i+1, 0 
	MOVWF       R1 
	MOVLW       20
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _world+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_world+0)
	ADDWFC      R1, 1 
	MOVF        _j+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR0L 
	MOVF        _j+1, 0 
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;interrupcao.c,168 :: 		for(j = 0; j < WORLD_HEIGHT ; ++j)
	INFSNZ      _j+0, 1 
	INCF        _j+1, 1 
;interrupcao.c,171 :: 		}
	GOTO        L_Print_World74
L_Print_World75:
;interrupcao.c,167 :: 		for(i = 0; i < WORLD_WIDTH; ++i) {
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;interrupcao.c,172 :: 		}
	GOTO        L_Print_World71
L_Print_World72:
;interrupcao.c,173 :: 		}
	RETURN      0
; end of _Print_World

_update_pacman_orientation:

;interrupcao.c,175 :: 		void update_pacman_orientation(short newX, short newY) {
;interrupcao.c,176 :: 		if (newX > objects_location_x[PACMAN]) {
	MOVLW       128
	XORWF       _objects_location_x+1, 0 
	MOVWF       R0 
	MOVLW       128
	BTFSC       FARG_update_pacman_orientation_newX+0, 7 
	MOVLW       127
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman_orientation98
	MOVF        FARG_update_pacman_orientation_newX+0, 0 
	SUBWF       _objects_location_x+0, 0 
L__update_pacman_orientation98:
	BTFSC       STATUS+0, 0 
	GOTO        L_update_pacman_orientation77
;interrupcao.c,177 :: 		pacman_orientation = 0;
	CLRF        _pacman_orientation+0 
;interrupcao.c,178 :: 		} else if (newX < objects_location_x[PACMAN]) {
	GOTO        L_update_pacman_orientation78
L_update_pacman_orientation77:
	MOVLW       128
	BTFSC       FARG_update_pacman_orientation_newX+0, 7 
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	XORWF       _objects_location_x+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman_orientation99
	MOVF        _objects_location_x+0, 0 
	SUBWF       FARG_update_pacman_orientation_newX+0, 0 
L__update_pacman_orientation99:
	BTFSC       STATUS+0, 0 
	GOTO        L_update_pacman_orientation79
;interrupcao.c,179 :: 		pacman_orientation = 1;
	MOVLW       1
	MOVWF       _pacman_orientation+0 
;interrupcao.c,180 :: 		} else if (newY > objects_location_y[PACMAN]) {
	GOTO        L_update_pacman_orientation80
L_update_pacman_orientation79:
	MOVLW       128
	XORWF       _objects_location_y+1, 0 
	MOVWF       R0 
	MOVLW       128
	BTFSC       FARG_update_pacman_orientation_newY+0, 7 
	MOVLW       127
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman_orientation100
	MOVF        FARG_update_pacman_orientation_newY+0, 0 
	SUBWF       _objects_location_y+0, 0 
L__update_pacman_orientation100:
	BTFSC       STATUS+0, 0 
	GOTO        L_update_pacman_orientation81
;interrupcao.c,181 :: 		pacman_orientation = 2;
	MOVLW       2
	MOVWF       _pacman_orientation+0 
;interrupcao.c,182 :: 		} else if (newY < objects_location_y[PACMAN]) {
	GOTO        L_update_pacman_orientation82
L_update_pacman_orientation81:
	MOVLW       128
	BTFSC       FARG_update_pacman_orientation_newY+0, 7 
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	XORWF       _objects_location_y+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman_orientation101
	MOVF        _objects_location_y+0, 0 
	SUBWF       FARG_update_pacman_orientation_newY+0, 0 
L__update_pacman_orientation101:
	BTFSC       STATUS+0, 0 
	GOTO        L_update_pacman_orientation83
;interrupcao.c,183 :: 		pacman_orientation = 3;
	MOVLW       3
	MOVWF       _pacman_orientation+0 
;interrupcao.c,184 :: 		}
L_update_pacman_orientation83:
L_update_pacman_orientation82:
L_update_pacman_orientation80:
L_update_pacman_orientation78:
;interrupcao.c,185 :: 		}
	RETURN      0
; end of _update_pacman_orientation

_Alert:

;interrupcao.c,187 :: 		void Alert()
;interrupcao.c,190 :: 		for(i=0; i<1; i++) {               // Move text to the right 4 times
	CLRF        Alert_i_L0+0 
	CLRF        Alert_i_L0+1 
L_Alert84:
	MOVLW       128
	XORWF       Alert_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Alert102
	MOVLW       1
	SUBWF       Alert_i_L0+0, 0 
L__Alert102:
	BTFSC       STATUS+0, 0 
	GOTO        L_Alert85
;interrupcao.c,191 :: 		Lcd_Cmd(_LCD_SHIFT_RIGHT);
	MOVLW       28
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;interrupcao.c,192 :: 		Move_Delay();
	CALL        _Move_Delay+0, 0
;interrupcao.c,190 :: 		for(i=0; i<1; i++) {               // Move text to the right 4 times
	INFSNZ      Alert_i_L0+0, 1 
	INCF        Alert_i_L0+1, 1 
;interrupcao.c,193 :: 		}
	GOTO        L_Alert84
L_Alert85:
;interrupcao.c,194 :: 		for(i=0; i<1; i++) {               // Move text to the left 4 times
	CLRF        Alert_i_L0+0 
	CLRF        Alert_i_L0+1 
L_Alert87:
	MOVLW       128
	XORWF       Alert_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Alert103
	MOVLW       1
	SUBWF       Alert_i_L0+0, 0 
L__Alert103:
	BTFSC       STATUS+0, 0 
	GOTO        L_Alert88
;interrupcao.c,195 :: 		Lcd_Cmd(_LCD_SHIFT_LEFT);
	MOVLW       24
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;interrupcao.c,196 :: 		Move_Delay();
	CALL        _Move_Delay+0, 0
;interrupcao.c,194 :: 		for(i=0; i<1; i++) {               // Move text to the left 4 times
	INFSNZ      Alert_i_L0+0, 1 
	INCF        Alert_i_L0+1, 1 
;interrupcao.c,197 :: 		}
	GOTO        L_Alert87
L_Alert88:
;interrupcao.c,198 :: 		}
	RETURN      0
; end of _Alert

_Write_EEPROM:

;interrupcao.c,200 :: 		void Write_EEPROM(int END, int DADO)
;interrupcao.c,202 :: 		I2C1_Start();           // issue I2C start signal
	CALL        _I2C1_Start+0, 0
;interrupcao.c,203 :: 		I2C1_Wr(0xA0);          // send byte via I2C  (device address + W)
	MOVLW       160
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;interrupcao.c,204 :: 		I2C1_Wr(END);             // send byte (address of EEPROM location)
	MOVF        FARG_Write_EEPROM_END+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;interrupcao.c,205 :: 		I2C1_Wr(DADO);          // send data (data to be written)
	MOVF        FARG_Write_EEPROM_DADO+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;interrupcao.c,206 :: 		I2C1_Stop();            // issue I2C stop signal
	CALL        _I2C1_Stop+0, 0
;interrupcao.c,207 :: 		delay_ms(10);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_Write_EEPROM90:
	DECFSZ      R13, 1, 0
	BRA         L_Write_EEPROM90
	DECFSZ      R12, 1, 0
	BRA         L_Write_EEPROM90
	NOP
;interrupcao.c,208 :: 		}
	RETURN      0
; end of _Write_EEPROM

_Read_EEPROM:

;interrupcao.c,210 :: 		int Read_EEPROM(int END)
;interrupcao.c,213 :: 		I2C1_Start();           // issue I2C start signal
	CALL        _I2C1_Start+0, 0
;interrupcao.c,214 :: 		I2C1_Wr(0xA0);          // send byte via I2C  (device address + W)
	MOVLW       160
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;interrupcao.c,215 :: 		I2C1_Wr(END);             // send byte (data address)
	MOVF        FARG_Read_EEPROM_END+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;interrupcao.c,216 :: 		I2C1_Repeated_Start();  // issue I2C signal repeated start
	CALL        _I2C1_Repeated_Start+0, 0
;interrupcao.c,217 :: 		I2C1_Wr(0xA1);          // send byte (device address + R)
	MOVLW       161
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;interrupcao.c,218 :: 		Dado = I2C1_Rd(0u);    // Read the data (NO acknowledge)
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       Read_EEPROM_Dado_L0+0 
	MOVLW       0
	MOVWF       Read_EEPROM_Dado_L0+1 
;interrupcao.c,219 :: 		I2C1_Stop();            // issue I2C stop signal
	CALL        _I2C1_Stop+0, 0
;interrupcao.c,220 :: 		return(Dado);
	MOVF        Read_EEPROM_Dado_L0+0, 0 
	MOVWF       R0 
	MOVF        Read_EEPROM_Dado_L0+1, 0 
	MOVWF       R1 
;interrupcao.c,221 :: 		}
	RETURN      0
; end of _Read_EEPROM

_Write_RTC:

;interrupcao.c,223 :: 		void Write_RTC(int END, int DADO)
;interrupcao.c,225 :: 		I2C1_Start();           // issue I2C start signal
	CALL        _I2C1_Start+0, 0
;interrupcao.c,226 :: 		I2C1_Wr(0xD0);          // send byte via I2C  (device address + W)
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;interrupcao.c,227 :: 		I2C1_Wr(END);             // send byte (address of EEPROM location)
	MOVF        FARG_Write_RTC_END+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;interrupcao.c,228 :: 		I2C1_Wr(DADO);          // send data (data to be written)
	MOVF        FARG_Write_RTC_DADO+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;interrupcao.c,229 :: 		I2C1_Stop();            // issue I2C stop signal
	CALL        _I2C1_Stop+0, 0
;interrupcao.c,230 :: 		}
	RETURN      0
; end of _Write_RTC

_Read_RTC:

;interrupcao.c,232 :: 		int Read_RTC(int END)
;interrupcao.c,235 :: 		I2C1_Start();           // issue I2C start signal
	CALL        _I2C1_Start+0, 0
;interrupcao.c,236 :: 		I2C1_Wr(0xD0);          // send byte via I2C  (device address + W)
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;interrupcao.c,237 :: 		I2C1_Wr(END);             // send byte (data address)
	MOVF        FARG_Read_RTC_END+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;interrupcao.c,238 :: 		I2C1_Repeated_Start();  // issue I2C signal repeated start
	CALL        _I2C1_Repeated_Start+0, 0
;interrupcao.c,239 :: 		I2C1_Wr(0xD1);          // send byte (device address + R)
	MOVLW       209
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;interrupcao.c,240 :: 		Dado = I2C1_Rd(0u);    // Read the data (NO acknowledge)
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       Read_RTC_Dado_L0+0 
	MOVLW       0
	MOVWF       Read_RTC_Dado_L0+1 
;interrupcao.c,241 :: 		I2C1_Stop();            // issue I2C stop signal
	CALL        _I2C1_Stop+0, 0
;interrupcao.c,242 :: 		return(Dado);
	MOVF        Read_RTC_Dado_L0+0, 0 
	MOVWF       R0 
	MOVF        Read_RTC_Dado_L0+1, 0 
	MOVWF       R1 
;interrupcao.c,243 :: 		}
	RETURN      0
; end of _Read_RTC

_Transform_Time:

;interrupcao.c,246 :: 		void Transform_Time(char *sec, char *min, char *hr) {
;interrupcao.c,247 :: 		*sec = ((*sec & 0xF0) >> 4)*10 + (*sec & 0x0F);
	MOVFF       FARG_Transform_Time_sec+0, FSR0L
	MOVFF       FARG_Transform_Time_sec+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVLW       240
	ANDWF       R3, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R1 
	MOVLW       15
	ANDWF       R3, 0 
	MOVWF       R0 
	MOVFF       FARG_Transform_Time_sec+0, FSR1L
	MOVFF       FARG_Transform_Time_sec+1, FSR1H
	MOVF        R0, 0 
	ADDWF       R1, 0 
	MOVWF       POSTINC1+0 
;interrupcao.c,248 :: 		*min = ((*min & 0xF0) >> 4)*10 + (*min & 0x0F);
	MOVFF       FARG_Transform_Time_min+0, FSR0L
	MOVFF       FARG_Transform_Time_min+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVLW       240
	ANDWF       R3, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R1 
	MOVLW       15
	ANDWF       R3, 0 
	MOVWF       R0 
	MOVFF       FARG_Transform_Time_min+0, FSR1L
	MOVFF       FARG_Transform_Time_min+1, FSR1H
	MOVF        R0, 0 
	ADDWF       R1, 0 
	MOVWF       POSTINC1+0 
;interrupcao.c,249 :: 		*hr = ((*hr & 0xF0) >> 4)*10 + (*hr & 0x0F);
	MOVFF       FARG_Transform_Time_hr+0, FSR0L
	MOVFF       FARG_Transform_Time_hr+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVLW       240
	ANDWF       R3, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R1 
	MOVLW       15
	ANDWF       R3, 0 
	MOVWF       R0 
	MOVFF       FARG_Transform_Time_hr+0, FSR1L
	MOVFF       FARG_Transform_Time_hr+1, FSR1H
	MOVF        R0, 0 
	ADDWF       R1, 0 
	MOVWF       POSTINC1+0 
;interrupcao.c,250 :: 		}
	RETURN      0
; end of _Transform_Time

_main:

;interrupcao.c,252 :: 		void main()
;interrupcao.c,254 :: 		UART1_Init(19200);
	MOVLW       25
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;interrupcao.c,255 :: 		I2C1_Init(100000);// i2c para acessar ID = D0h  = RTC
	MOVLW       20
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;interrupcao.c,257 :: 		ADCON1=0B00001110;
	MOVLW       14
	MOVWF       ADCON1+0 
;interrupcao.c,258 :: 		TRISB = 0B00001111;
	MOVLW       15
	MOVWF       TRISB+0 
;interrupcao.c,259 :: 		PORTB = 0B00000000;
	CLRF        PORTB+0 
;interrupcao.c,260 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;interrupcao.c,262 :: 		TRISA=0B00100001;
	MOVLW       33
	MOVWF       TRISA+0 
;interrupcao.c,263 :: 		InitTimer2();
	CALL        _InitTimer2+0, 0
;interrupcao.c,265 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;interrupcao.c,266 :: 		CustomChar();
	CALL        _CustomChar+0, 0
;interrupcao.c,268 :: 		Create_World();
	CALL        _Create_World+0, 0
;interrupcao.c,269 :: 		Print_World();
	CALL        _Print_World+0, 0
;interrupcao.c,335 :: 		}
	GOTO        $+0
; end of _main
