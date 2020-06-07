
_print:

;compy.c,56 :: 		void print(unsigned char line, unsigned char column, code const unsigned char* sprite) {
;compy.c,57 :: 		T6963C_graphics(1);
	BSF         _T6963C_display+0, 3 
	MOVF        _T6963C_display+0, 0 
	MOVWF       FARG_T6963C_writeCommand_mydata+0 
	CALL        _T6963C_writeCommand+0, 0
;compy.c,58 :: 		T6963C_text(0);
	BCF         _T6963C_display+0, 2 
	MOVF        _T6963C_display+0, 0 
	MOVWF       FARG_T6963C_writeCommand_mydata+0 
	CALL        _T6963C_writeCommand+0, 0
;compy.c,59 :: 		T6963C_sprite((column - 1) * 16, (line - 1) * 16, sprite, 16, 16);
	DECF        FARG_print_column+0, 0 
	MOVWF       FARG_T6963C_sprite_px+0 
	RLCF        FARG_T6963C_sprite_px+0, 1 
	BCF         FARG_T6963C_sprite_px+0, 0 
	RLCF        FARG_T6963C_sprite_px+0, 1 
	BCF         FARG_T6963C_sprite_px+0, 0 
	RLCF        FARG_T6963C_sprite_px+0, 1 
	BCF         FARG_T6963C_sprite_px+0, 0 
	RLCF        FARG_T6963C_sprite_px+0, 1 
	BCF         FARG_T6963C_sprite_px+0, 0 
	DECF        FARG_print_line+0, 0 
	MOVWF       FARG_T6963C_sprite_py+0 
	RLCF        FARG_T6963C_sprite_py+0, 1 
	BCF         FARG_T6963C_sprite_py+0, 0 
	RLCF        FARG_T6963C_sprite_py+0, 1 
	BCF         FARG_T6963C_sprite_py+0, 0 
	RLCF        FARG_T6963C_sprite_py+0, 1 
	BCF         FARG_T6963C_sprite_py+0, 0 
	RLCF        FARG_T6963C_sprite_py+0, 1 
	BCF         FARG_T6963C_sprite_py+0, 0 
	MOVF        FARG_print_sprite+0, 0 
	MOVWF       FARG_T6963C_sprite_pic+0 
	MOVF        FARG_print_sprite+1, 0 
	MOVWF       FARG_T6963C_sprite_pic+1 
	MOVF        FARG_print_sprite+2, 0 
	MOVWF       FARG_T6963C_sprite_pic+2 
	MOVLW       16
	MOVWF       FARG_T6963C_sprite_sx+0 
	MOVLW       16
	MOVWF       FARG_T6963C_sprite_sy+0 
	CALL        _T6963C_sprite+0, 0
;compy.c,60 :: 		}
	RETURN      0
; end of _print

_print_text:

;compy.c,62 :: 		void print_text(unsigned char line, unsigned char column, unsigned char* text) {
;compy.c,63 :: 		T6963C_graphics(0);
	BCF         _T6963C_display+0, 3 
	MOVF        _T6963C_display+0, 0 
	MOVWF       FARG_T6963C_writeCommand_mydata+0 
	CALL        _T6963C_writeCommand+0, 0
;compy.c,64 :: 		T6963C_text(1);
	BSF         _T6963C_display+0, 2 
	MOVF        _T6963C_display+0, 0 
	MOVWF       FARG_T6963C_writeCommand_mydata+0 
	CALL        _T6963C_writeCommand+0, 0
;compy.c,65 :: 		T6963C_write_text(text, line - 1, column - 1, T6963C_ROM_MODE_XOR);
	MOVF        FARG_print_text_text+0, 0 
	MOVWF       FARG_T6963C_write_text_str+0 
	MOVF        FARG_print_text_text+1, 0 
	MOVWF       FARG_T6963C_write_text_str+1 
	DECF        FARG_print_text_line+0, 0 
	MOVWF       FARG_T6963C_write_text_x+0 
	DECF        FARG_print_text_column+0, 0 
	MOVWF       FARG_T6963C_write_text_y+0 
	MOVLW       129
	MOVWF       FARG_T6963C_write_text_mode+0 
	CALL        _T6963C_write_text+0, 0
;compy.c,66 :: 		}
	RETURN      0
; end of _print_text

_InitTimer2:

;compy.c,104 :: 		void InitTimer2(){
;compy.c,105 :: 		T2CON         = 0x3C;
	MOVLW       60
	MOVWF       T2CON+0 
;compy.c,106 :: 		TMR2IE_bit         = 1;
	BSF         TMR2IE_bit+0, 1 
;compy.c,107 :: 		PR2                 = 249;
	MOVLW       249
	MOVWF       PR2+0 
;compy.c,108 :: 		INTCON         = 0xD0;  //INTCON = 1100 0000 (HABILITA TMR2 INTERRUPT E INT0 INTERRUPT)
	MOVLW       208
	MOVWF       INTCON+0 
;compy.c,109 :: 		}
	RETURN      0
; end of _InitTimer2

_external_interrupt:

;compy.c,111 :: 		void external_interrupt() {
;compy.c,112 :: 		PORTA.F2 = ~PORTA.F2;
	BTG         PORTA+0, 2 
;compy.c,113 :: 		}
	RETURN      0
; end of _external_interrupt

_interrupt:

;compy.c,116 :: 		void interrupt() {
;compy.c,117 :: 		if(int0if_bit)
	BTFSS       INT0IF_bit+0, 1 
	GOTO        L_interrupt0
;compy.c,119 :: 		cnt2++;
	INFSNZ      _cnt2+0, 1 
	INCF        _cnt2+1, 1 
;compy.c,120 :: 		if (cnt2 > 180) {
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _cnt2+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt143
	MOVF        _cnt2+0, 0 
	SUBLW       180
L__interrupt143:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt1
;compy.c,121 :: 		IS_FINISH = 1;
	MOVLW       1
	MOVWF       _IS_FINISH+0 
	MOVLW       0
	MOVWF       _IS_FINISH+1 
;compy.c,122 :: 		IS_GAME_OVER = 1;
	MOVLW       1
	MOVWF       _IS_GAME_OVER+0 
	MOVLW       0
	MOVWF       _IS_GAME_OVER+1 
;compy.c,123 :: 		}
L_interrupt1:
;compy.c,124 :: 		new_ghost_y = ghost_y;
	MOVF        _ghost_y+0, 0 
	MOVWF       _new_ghost_y+0 
	MOVF        _ghost_y+1, 0 
	MOVWF       _new_ghost_y+1 
;compy.c,125 :: 		new_ghost_x = ghost_x;
	MOVF        _ghost_x+0, 0 
	MOVWF       _new_ghost_x+0 
	MOVF        _ghost_x+1, 0 
	MOVWF       _new_ghost_x+1 
;compy.c,126 :: 		if (cnt2 % 6 == 0) {
	MOVLW       6
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _cnt2+0, 0 
	MOVWF       R0 
	MOVF        _cnt2+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt144
	MOVLW       0
	XORWF       R0, 0 
L__interrupt144:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt2
;compy.c,127 :: 		if (pacman_y > ghost_y) {
	MOVLW       128
	XORWF       _ghost_y+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _pacman_y+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt145
	MOVF        _pacman_y+0, 0 
	SUBWF       _ghost_y+0, 0 
L__interrupt145:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt3
;compy.c,128 :: 		new_ghost_y = (ghost_y + 1);
	MOVLW       1
	ADDWF       _ghost_y+0, 0 
	MOVWF       _new_ghost_y+0 
	MOVLW       0
	ADDWFC      _ghost_y+1, 0 
	MOVWF       _new_ghost_y+1 
;compy.c,129 :: 		} else if (pacman_y < ghost_y) {
	GOTO        L_interrupt4
L_interrupt3:
	MOVLW       128
	XORWF       _pacman_y+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _ghost_y+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt146
	MOVF        _ghost_y+0, 0 
	SUBWF       _pacman_y+0, 0 
L__interrupt146:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt5
;compy.c,130 :: 		new_ghost_y = (ghost_y - 1);
	MOVLW       1
	SUBWF       _ghost_y+0, 0 
	MOVWF       _new_ghost_y+0 
	MOVLW       0
	SUBWFB      _ghost_y+1, 0 
	MOVWF       _new_ghost_y+1 
;compy.c,131 :: 		} else {
	GOTO        L_interrupt6
L_interrupt5:
;compy.c,132 :: 		if (pacman_x > ghost_x) {
	MOVLW       128
	XORWF       _ghost_x+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _pacman_x+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt147
	MOVF        _pacman_x+0, 0 
	SUBWF       _ghost_x+0, 0 
L__interrupt147:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt7
;compy.c,133 :: 		new_ghost_x = (ghost_x + 1);
	MOVLW       1
	ADDWF       _ghost_x+0, 0 
	MOVWF       _new_ghost_x+0 
	MOVLW       0
	ADDWFC      _ghost_x+1, 0 
	MOVWF       _new_ghost_x+1 
;compy.c,135 :: 		} else if (pacman_x < ghost_x) {
	GOTO        L_interrupt8
L_interrupt7:
	MOVLW       128
	XORWF       _pacman_x+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _ghost_x+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt148
	MOVF        _ghost_x+0, 0 
	SUBWF       _pacman_x+0, 0 
L__interrupt148:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt9
;compy.c,136 :: 		new_ghost_x = (ghost_x - 1);
	MOVLW       1
	SUBWF       _ghost_x+0, 0 
	MOVWF       _new_ghost_x+0 
	MOVLW       0
	SUBWFB      _ghost_x+1, 0 
	MOVWF       _new_ghost_x+1 
;compy.c,137 :: 		}
L_interrupt9:
L_interrupt8:
;compy.c,138 :: 		}
L_interrupt6:
L_interrupt4:
;compy.c,139 :: 		if (world[new_ghost_x][new_ghost_x] == barrier_orientation) {
	MOVF        _new_ghost_x+0, 0 
	MOVWF       R0 
	MOVF        _new_ghost_x+1, 0 
	MOVWF       R1 
	MOVLW       30
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _world+0
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVLW       hi_addr(_world+0)
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVF        _new_ghost_x+0, 0 
	MOVWF       R0 
	MOVF        _new_ghost_x+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       R3, 0 
	MOVWF       FSR0L 
	MOVF        R1, 0 
	ADDWFC      R4, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt149
	MOVF        _barrier_orientation+0, 0 
	XORWF       R1, 0 
L__interrupt149:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt10
;compy.c,140 :: 		new_ghost_x = new_ghost_x + 1;
	INFSNZ      _new_ghost_x+0, 1 
	INCF        _new_ghost_x+1, 1 
;compy.c,141 :: 		}
L_interrupt10:
;compy.c,142 :: 		world[ghost_x][ghost_y] = old_ghost_obj != 0 ? old_ghost_obj : ' ';
	MOVF        _ghost_x+0, 0 
	MOVWF       R0 
	MOVF        _ghost_x+1, 0 
	MOVWF       R1 
	MOVLW       30
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _world+0
	ADDWF       R0, 0 
	MOVWF       R4 
	MOVLW       hi_addr(_world+0)
	ADDWFC      R1, 0 
	MOVWF       R5 
	MOVF        _ghost_y+0, 0 
	MOVWF       R0 
	MOVF        _ghost_y+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       R4, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	ADDWFC      R5, 0 
	MOVWF       R3 
	MOVF        _old_ghost_obj+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt11
	MOVF        _old_ghost_obj+0, 0 
	MOVWF       R0 
	GOTO        L_interrupt12
L_interrupt11:
	MOVLW       32
	MOVWF       R0 
L_interrupt12:
	MOVFF       R2, FSR1L
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;compy.c,143 :: 		old_ghost_obj = world[ghost_x][ghost_x] != ghost_orientation ? world[new_ghost_x][new_ghost_y] : ' ';
	MOVF        _ghost_x+0, 0 
	MOVWF       R0 
	MOVF        _ghost_x+1, 0 
	MOVWF       R1 
	MOVLW       30
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _world+0
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVLW       hi_addr(_world+0)
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVF        _ghost_x+0, 0 
	MOVWF       R0 
	MOVF        _ghost_x+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       R3, 0 
	MOVWF       FSR0L 
	MOVF        R1, 0 
	ADDWFC      R4, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt150
	MOVF        _ghost_orientation+0, 0 
	XORWF       R1, 0 
L__interrupt150:
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt13
	MOVF        _new_ghost_x+0, 0 
	MOVWF       R0 
	MOVF        _new_ghost_x+1, 0 
	MOVWF       R1 
	MOVLW       30
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _world+0
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVLW       hi_addr(_world+0)
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVF        _new_ghost_y+0, 0 
	MOVWF       R0 
	MOVF        _new_ghost_y+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       R3, 0 
	MOVWF       FSR0L 
	MOVF        R1, 0 
	ADDWFC      R4, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	GOTO        L_interrupt14
L_interrupt13:
	MOVLW       32
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
L_interrupt14:
	MOVF        R0, 0 
	MOVWF       _old_ghost_obj+0 
;compy.c,144 :: 		world[new_ghost_x][new_ghost_y] = ghost_orientation;
	MOVF        _new_ghost_x+0, 0 
	MOVWF       R0 
	MOVF        _new_ghost_x+1, 0 
	MOVWF       R1 
	MOVLW       30
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _world+0
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVLW       hi_addr(_world+0)
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVF        _new_ghost_y+0, 0 
	MOVWF       R0 
	MOVF        _new_ghost_y+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       R3, 0 
	MOVWF       FSR1L 
	MOVF        R1, 0 
	ADDWFC      R4, 0 
	MOVWF       FSR1H 
	MOVF        _ghost_orientation+0, 0 
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;compy.c,146 :: 		ghost_y = new_ghost_y;
	MOVF        _new_ghost_y+0, 0 
	MOVWF       _ghost_y+0 
	MOVF        _new_ghost_y+1, 0 
	MOVWF       _ghost_y+1 
;compy.c,147 :: 		ghost_x = new_ghost_x;
	MOVF        _new_ghost_x+0, 0 
	MOVWF       _ghost_x+0 
	MOVF        _new_ghost_x+1, 0 
	MOVWF       _ghost_x+1 
;compy.c,148 :: 		}
L_interrupt2:
;compy.c,149 :: 		int0if_bit=0;   // clear int0if_bit
	BCF         INT0IF_bit+0, 1 
;compy.c,150 :: 		}
L_interrupt0:
;compy.c,152 :: 		if (TMR2IF_bit) {
	BTFSS       TMR2IF_bit+0, 1 
	GOTO        L_interrupt15
;compy.c,153 :: 		cnt++;
	INFSNZ      _cnt+0, 1 
	INCF        _cnt+1, 1 
;compy.c,154 :: 		if (cnt >= 1000) {
	MOVLW       128
	XORWF       _cnt+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt151
	MOVLW       232
	SUBWF       _cnt+0, 0 
L__interrupt151:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt16
;compy.c,155 :: 		PORTA.F1 = ~PORTA.F1;
	BTG         PORTA+0, 1 
;compy.c,156 :: 		cnt = 0;
	CLRF        _cnt+0 
	CLRF        _cnt+1 
;compy.c,157 :: 		}
L_interrupt16:
;compy.c,158 :: 		TMR2IF_bit = 0;        // clear TMR2IF
	BCF         TMR2IF_bit+0, 1 
;compy.c,159 :: 		}
L_interrupt15:
;compy.c,160 :: 		}
L__interrupt142:
	RETFIE      1
; end of _interrupt

_Le_Teclado:

;compy.c,162 :: 		char Le_Teclado()
;compy.c,164 :: 		PORTD = 0B00010000; // VOCÊ SELECIONOU LA
	MOVLW       16
	MOVWF       PORTD+0 
;compy.c,165 :: 		if (PORTA.RA5 == 1) {
	BTFSS       PORTA+0, 5 
	GOTO        L_Le_Teclado17
;compy.c,166 :: 		while(PORTA.RA5 == 1);
L_Le_Teclado18:
	BTFSS       PORTA+0, 5 
	GOTO        L_Le_Teclado19
	GOTO        L_Le_Teclado18
L_Le_Teclado19:
;compy.c,167 :: 		return '7';
	MOVLW       55
	MOVWF       R0 
	RETURN      0
;compy.c,168 :: 		}
L_Le_Teclado17:
;compy.c,169 :: 		if (PORTB.RB1 == 1) {
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado20
;compy.c,170 :: 		while(PORTB.RB1 == 1);
L_Le_Teclado21:
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado22
	GOTO        L_Le_Teclado21
L_Le_Teclado22:
;compy.c,171 :: 		return '8';
	MOVLW       56
	MOVWF       R0 
	RETURN      0
;compy.c,172 :: 		}
L_Le_Teclado20:
;compy.c,173 :: 		if (PORTB.RB2 == 1) {
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado23
;compy.c,174 :: 		while(PORTB.RB2 == 1);
L_Le_Teclado24:
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado25
	GOTO        L_Le_Teclado24
L_Le_Teclado25:
;compy.c,175 :: 		return '9';
	MOVLW       57
	MOVWF       R0 
	RETURN      0
;compy.c,176 :: 		}
L_Le_Teclado23:
;compy.c,177 :: 		if (PORTB.RB3 == 1) {
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado26
;compy.c,178 :: 		while(PORTB.RB3 == 1);
L_Le_Teclado27:
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado28
	GOTO        L_Le_Teclado27
L_Le_Teclado28:
;compy.c,179 :: 		return '%';
	MOVLW       37
	MOVWF       R0 
	RETURN      0
;compy.c,180 :: 		}
L_Le_Teclado26:
;compy.c,182 :: 		PORTD = 0B00100000; // VOCÊ SELECIONOU LB
	MOVLW       32
	MOVWF       PORTD+0 
;compy.c,183 :: 		if (PORTA.RA5 == 1) {
	BTFSS       PORTA+0, 5 
	GOTO        L_Le_Teclado29
;compy.c,184 :: 		while(PORTA.RA5 == 1);
L_Le_Teclado30:
	BTFSS       PORTA+0, 5 
	GOTO        L_Le_Teclado31
	GOTO        L_Le_Teclado30
L_Le_Teclado31:
;compy.c,185 :: 		return '4';
	MOVLW       52
	MOVWF       R0 
	RETURN      0
;compy.c,186 :: 		}
L_Le_Teclado29:
;compy.c,187 :: 		if (PORTB.RB1 == 1) {
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado32
;compy.c,188 :: 		while(PORTB.RB1 == 1);
L_Le_Teclado33:
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado34
	GOTO        L_Le_Teclado33
L_Le_Teclado34:
;compy.c,189 :: 		return '5';
	MOVLW       53
	MOVWF       R0 
	RETURN      0
;compy.c,190 :: 		}
L_Le_Teclado32:
;compy.c,191 :: 		if (PORTB.RB2 == 1) {
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado35
;compy.c,192 :: 		while(PORTB.RB2 == 1);
L_Le_Teclado36:
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado37
	GOTO        L_Le_Teclado36
L_Le_Teclado37:
;compy.c,193 :: 		return '6';
	MOVLW       54
	MOVWF       R0 
	RETURN      0
;compy.c,194 :: 		}
L_Le_Teclado35:
;compy.c,195 :: 		if (PORTB.RB3 == 1) {
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado38
;compy.c,196 :: 		while(PORTB.RB3 == 1);
L_Le_Teclado39:
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado40
	GOTO        L_Le_Teclado39
L_Le_Teclado40:
;compy.c,197 :: 		return '*';
	MOVLW       42
	MOVWF       R0 
	RETURN      0
;compy.c,198 :: 		}
L_Le_Teclado38:
;compy.c,200 :: 		PORTD = 0B01000000; // VOCÊ SELECIONOU LC
	MOVLW       64
	MOVWF       PORTD+0 
;compy.c,201 :: 		if (PORTA.RA5 == 1) {
	BTFSS       PORTA+0, 5 
	GOTO        L_Le_Teclado41
;compy.c,202 :: 		while(PORTA.RA5 == 1);
L_Le_Teclado42:
	BTFSS       PORTA+0, 5 
	GOTO        L_Le_Teclado43
	GOTO        L_Le_Teclado42
L_Le_Teclado43:
;compy.c,203 :: 		return '1';
	MOVLW       49
	MOVWF       R0 
	RETURN      0
;compy.c,204 :: 		}
L_Le_Teclado41:
;compy.c,205 :: 		if (PORTB.RB1 == 1) {
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado44
;compy.c,206 :: 		while(PORTB.RB1 == 1);
L_Le_Teclado45:
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado46
	GOTO        L_Le_Teclado45
L_Le_Teclado46:
;compy.c,207 :: 		return '2';
	MOVLW       50
	MOVWF       R0 
	RETURN      0
;compy.c,208 :: 		}
L_Le_Teclado44:
;compy.c,209 :: 		if (PORTB.RB2 == 1) {
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado47
;compy.c,210 :: 		while(PORTB.RB2 == 1);
L_Le_Teclado48:
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado49
	GOTO        L_Le_Teclado48
L_Le_Teclado49:
;compy.c,211 :: 		return '3';
	MOVLW       51
	MOVWF       R0 
	RETURN      0
;compy.c,212 :: 		}
L_Le_Teclado47:
;compy.c,213 :: 		if (PORTB.RB3 == 1) {
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado50
;compy.c,214 :: 		while(PORTB.RB3 == 1);
L_Le_Teclado51:
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado52
	GOTO        L_Le_Teclado51
L_Le_Teclado52:
;compy.c,215 :: 		return '-';
	MOVLW       45
	MOVWF       R0 
	RETURN      0
;compy.c,216 :: 		}
L_Le_Teclado50:
;compy.c,218 :: 		PORTD = 0B10000000; // VOCÊ SELECIONOU LD
	MOVLW       128
	MOVWF       PORTD+0 
;compy.c,219 :: 		if (PORTA.RA5 == 1) {
	BTFSS       PORTA+0, 5 
	GOTO        L_Le_Teclado53
;compy.c,220 :: 		while(PORTA.RA5 == 1);
L_Le_Teclado54:
	BTFSS       PORTA+0, 5 
	GOTO        L_Le_Teclado55
	GOTO        L_Le_Teclado54
L_Le_Teclado55:
;compy.c,221 :: 		return 'C';
	MOVLW       67
	MOVWF       R0 
	RETURN      0
;compy.c,222 :: 		}
L_Le_Teclado53:
;compy.c,223 :: 		if (PORTB.RB1 == 1) {
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado56
;compy.c,224 :: 		while(PORTB.RB1 == 1);
L_Le_Teclado57:
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado58
	GOTO        L_Le_Teclado57
L_Le_Teclado58:
;compy.c,225 :: 		return '0';
	MOVLW       48
	MOVWF       R0 
	RETURN      0
;compy.c,226 :: 		}
L_Le_Teclado56:
;compy.c,227 :: 		if (PORTB.RB2 == 1) {
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado59
;compy.c,228 :: 		while(PORTB.RB2 == 1);
L_Le_Teclado60:
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado61
	GOTO        L_Le_Teclado60
L_Le_Teclado61:
;compy.c,229 :: 		return '=';
	MOVLW       61
	MOVWF       R0 
	RETURN      0
;compy.c,230 :: 		}
L_Le_Teclado59:
;compy.c,231 :: 		if (PORTB.RB3 == 1) {
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado62
;compy.c,232 :: 		while(PORTB.RB3 == 1);
L_Le_Teclado63:
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado64
	GOTO        L_Le_Teclado63
L_Le_Teclado64:
;compy.c,233 :: 		return '+';
	MOVLW       43
	MOVWF       R0 
	RETURN      0
;compy.c,234 :: 		}
L_Le_Teclado62:
;compy.c,236 :: 		return (char) 255;
	MOVLW       255
	MOVWF       R0 
;compy.c,237 :: 		}
	RETURN      0
; end of _Le_Teclado

_Pula_Linha:

;compy.c,239 :: 		void Pula_Linha(void)
;compy.c,241 :: 		UART1_WRITE(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;compy.c,242 :: 		UART1_WRITE(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;compy.c,243 :: 		}
	RETURN      0
; end of _Pula_Linha

_Move_Delay:

;compy.c,245 :: 		void Move_Delay() {                  // Function used for text moving
;compy.c,246 :: 		Delay_ms(100);                     // You can change the moving speed here
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_Move_Delay65:
	DECFSZ      R13, 1, 0
	BRA         L_Move_Delay65
	DECFSZ      R12, 1, 0
	BRA         L_Move_Delay65
	DECFSZ      R11, 1, 0
	BRA         L_Move_Delay65
	NOP
;compy.c,247 :: 		}
	RETURN      0
; end of _Move_Delay

_myrand:

;compy.c,252 :: 		int myrand(unsigned seed) {
;compy.c,253 :: 		next = seed;
	MOVF        FARG_myrand_seed+0, 0 
	MOVWF       _next+0 
	MOVF        FARG_myrand_seed+1, 0 
	MOVWF       _next+1 
	MOVLW       0
	MOVWF       _next+2 
	MOVWF       _next+3 
;compy.c,254 :: 		next = next * 1103515245 + 12345;
	MOVF        _next+0, 0 
	MOVWF       R0 
	MOVF        _next+1, 0 
	MOVWF       R1 
	MOVF        _next+2, 0 
	MOVWF       R2 
	MOVF        _next+3, 0 
	MOVWF       R3 
	MOVLW       109
	MOVWF       R4 
	MOVLW       78
	MOVWF       R5 
	MOVLW       198
	MOVWF       R6 
	MOVLW       65
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVLW       57
	ADDWF       R0, 0 
	MOVWF       R5 
	MOVLW       48
	ADDWFC      R1, 0 
	MOVWF       R6 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       R7 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       _next+0 
	MOVF        R6, 0 
	MOVWF       _next+1 
	MOVF        R7, 0 
	MOVWF       _next+2 
	MOVF        R8, 0 
	MOVWF       _next+3 
;compy.c,255 :: 		return((unsigned)(next/65536) % 32768);
	MOVF        R7, 0 
	MOVWF       R0 
	MOVF        R8, 0 
	MOVWF       R1 
	CLRF        R2 
	CLRF        R3 
	MOVLW       255
	ANDWF       R0, 1 
	MOVLW       127
	ANDWF       R1, 1 
;compy.c,256 :: 		}
	RETURN      0
; end of _myrand

_mysrand:

;compy.c,258 :: 		void mysrand(unsigned seed) {
;compy.c,259 :: 		next = seed;
	MOVF        FARG_mysrand_seed+0, 0 
	MOVWF       _next+0 
	MOVF        FARG_mysrand_seed+1, 0 
	MOVWF       _next+1 
	MOVLW       0
	MOVWF       _next+2 
	MOVWF       _next+3 
;compy.c,260 :: 		}
	RETURN      0
; end of _mysrand

_Read_RTC:

;compy.c,262 :: 		int Read_RTC(int END)
;compy.c,265 :: 		I2C1_Start();           // issue I2C start signal
	CALL        _I2C1_Start+0, 0
;compy.c,266 :: 		I2C1_Wr(0xD0);          // send byte via I2C  (device address + W)
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;compy.c,267 :: 		I2C1_Wr(END);             // send byte (data address)
	MOVF        FARG_Read_RTC_END+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;compy.c,268 :: 		I2C1_Repeated_Start();  // issue I2C signal repeated start
	CALL        _I2C1_Repeated_Start+0, 0
;compy.c,269 :: 		I2C1_Wr(0xD1);          // send byte (device address + R)
	MOVLW       209
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;compy.c,270 :: 		Dado = I2C1_Rd(0u);    // Read the data (NO acknowledge)
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       Read_RTC_Dado_L0+0 
	MOVLW       0
	MOVWF       Read_RTC_Dado_L0+1 
;compy.c,271 :: 		I2C1_Stop();            // issue I2C stop signal
	CALL        _I2C1_Stop+0, 0
;compy.c,272 :: 		return(Dado);
	MOVF        Read_RTC_Dado_L0+0, 0 
	MOVWF       R0 
	MOVF        Read_RTC_Dado_L0+1, 0 
	MOVWF       R1 
;compy.c,273 :: 		}
	RETURN      0
; end of _Read_RTC

_Create_World:

;compy.c,277 :: 		void Create_World() {
;compy.c,278 :: 		for(i = 0; i < 15; ++i) {
	CLRF        _i+0 
	CLRF        _i+1 
L_Create_World66:
	MOVLW       128
	XORWF       _i+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Create_World152
	MOVLW       15
	SUBWF       _i+0, 0 
L__Create_World152:
	BTFSC       STATUS+0, 0 
	GOTO        L_Create_World67
;compy.c,279 :: 		for(j = 0; j < 15 ; ++j)
	CLRF        _j+0 
	CLRF        _j+1 
L_Create_World69:
	MOVLW       128
	XORWF       _j+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Create_World153
	MOVLW       15
	SUBWF       _j+0, 0 
L__Create_World153:
	BTFSC       STATUS+0, 0 
	GOTO        L_Create_World70
;compy.c,281 :: 		world[i][j] = ' ';
	MOVF        _i+0, 0 
	MOVWF       R0 
	MOVF        _i+1, 0 
	MOVWF       R1 
	MOVLW       30
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _world+0
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVLW       hi_addr(_world+0)
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVF        _j+0, 0 
	MOVWF       R0 
	MOVF        _j+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       R3, 0 
	MOVWF       FSR1L 
	MOVF        R1, 0 
	ADDWFC      R4, 0 
	MOVWF       FSR1H 
	MOVLW       32
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;compy.c,279 :: 		for(j = 0; j < 15 ; ++j)
	INFSNZ      _j+0, 1 
	INCF        _j+1, 1 
;compy.c,282 :: 		}
	GOTO        L_Create_World69
L_Create_World70:
;compy.c,278 :: 		for(i = 0; i < 15; ++i) {
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;compy.c,283 :: 		}
	GOTO        L_Create_World66
L_Create_World67:
;compy.c,285 :: 		world[4][myrand(rands * 5) & 0b000000000000000111] = barrier_orientation;
	MOVF        _rands+0, 0 
	MOVWF       R0 
	MOVF        _rands+1, 0 
	MOVWF       R1 
	MOVLW       5
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_myrand_seed+0 
	MOVF        R1, 0 
	MOVWF       FARG_myrand_seed+1 
	CALL        _myrand+0, 0
	MOVLW       7
	ANDWF       R0, 0 
	MOVWF       R3 
	MOVF        R1, 0 
	MOVWF       R4 
	MOVLW       0
	ANDWF       R4, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _world+120
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       hi_addr(_world+120)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        _barrier_orientation+0, 0 
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;compy.c,286 :: 		world[myrand(rands * 1) & 0b000000000000000111][myrand(rands * 1) & 0b000000000000000111] = barrier_orientation;
	MOVF        _rands+0, 0 
	MOVWF       FARG_myrand_seed+0 
	MOVF        _rands+1, 0 
	MOVWF       FARG_myrand_seed+1 
	CALL        _myrand+0, 0
	MOVLW       7
	ANDWF       R0, 1 
	MOVLW       0
	ANDWF       R1, 1 
	MOVLW       30
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _world+0
	ADDWF       R0, 0 
	MOVWF       FLOC__Create_World+0 
	MOVLW       hi_addr(_world+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__Create_World+1 
	MOVF        _rands+0, 0 
	MOVWF       FARG_myrand_seed+0 
	MOVF        _rands+1, 0 
	MOVWF       FARG_myrand_seed+1 
	CALL        _myrand+0, 0
	MOVLW       7
	ANDWF       R0, 0 
	MOVWF       R3 
	MOVF        R1, 0 
	MOVWF       R4 
	MOVLW       0
	ANDWF       R4, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       FLOC__Create_World+0, 0 
	MOVWF       FSR1L 
	MOVF        R1, 0 
	ADDWFC      FLOC__Create_World+1, 0 
	MOVWF       FSR1H 
	MOVF        _barrier_orientation+0, 0 
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;compy.c,287 :: 		world[myrand(rands * 50) & 0b000000000000000111][myrand(rands * 26) & 0b000000000000000111] = barrier_orientation;
	MOVF        _rands+0, 0 
	MOVWF       R0 
	MOVF        _rands+1, 0 
	MOVWF       R1 
	MOVLW       50
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_myrand_seed+0 
	MOVF        R1, 0 
	MOVWF       FARG_myrand_seed+1 
	CALL        _myrand+0, 0
	MOVLW       7
	ANDWF       R0, 1 
	MOVLW       0
	ANDWF       R1, 1 
	MOVLW       30
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _world+0
	ADDWF       R0, 0 
	MOVWF       FLOC__Create_World+0 
	MOVLW       hi_addr(_world+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__Create_World+1 
	MOVF        _rands+0, 0 
	MOVWF       R0 
	MOVF        _rands+1, 0 
	MOVWF       R1 
	MOVLW       26
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_myrand_seed+0 
	MOVF        R1, 0 
	MOVWF       FARG_myrand_seed+1 
	CALL        _myrand+0, 0
	MOVLW       7
	ANDWF       R0, 0 
	MOVWF       R3 
	MOVF        R1, 0 
	MOVWF       R4 
	MOVLW       0
	ANDWF       R4, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       FLOC__Create_World+0, 0 
	MOVWF       FSR1L 
	MOVF        R1, 0 
	ADDWFC      FLOC__Create_World+1, 0 
	MOVWF       FSR1H 
	MOVF        _barrier_orientation+0, 0 
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;compy.c,288 :: 		world[myrand(rands * 985) & 0b000000000000000111][myrand(rands * 76) & 0b000000000000000111] = barrier_orientation;
	MOVF        _rands+0, 0 
	MOVWF       R0 
	MOVF        _rands+1, 0 
	MOVWF       R1 
	MOVLW       217
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_myrand_seed+0 
	MOVF        R1, 0 
	MOVWF       FARG_myrand_seed+1 
	CALL        _myrand+0, 0
	MOVLW       7
	ANDWF       R0, 1 
	MOVLW       0
	ANDWF       R1, 1 
	MOVLW       30
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _world+0
	ADDWF       R0, 0 
	MOVWF       FLOC__Create_World+0 
	MOVLW       hi_addr(_world+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__Create_World+1 
	MOVF        _rands+0, 0 
	MOVWF       R0 
	MOVF        _rands+1, 0 
	MOVWF       R1 
	MOVLW       76
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_myrand_seed+0 
	MOVF        R1, 0 
	MOVWF       FARG_myrand_seed+1 
	CALL        _myrand+0, 0
	MOVLW       7
	ANDWF       R0, 0 
	MOVWF       R3 
	MOVF        R1, 0 
	MOVWF       R4 
	MOVLW       0
	ANDWF       R4, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       FLOC__Create_World+0, 0 
	MOVWF       FSR1L 
	MOVF        R1, 0 
	ADDWFC      FLOC__Create_World+1, 0 
	MOVWF       FSR1H 
	MOVF        _barrier_orientation+0, 0 
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;compy.c,290 :: 		world[myrand(rands * 12)& 0b000000000000000111][myrand(rands * 500)& 0b000000000000000111] = food_orientation;
	MOVF        _rands+0, 0 
	MOVWF       R0 
	MOVF        _rands+1, 0 
	MOVWF       R1 
	MOVLW       12
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_myrand_seed+0 
	MOVF        R1, 0 
	MOVWF       FARG_myrand_seed+1 
	CALL        _myrand+0, 0
	MOVLW       7
	ANDWF       R0, 1 
	MOVLW       0
	ANDWF       R1, 1 
	MOVLW       30
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _world+0
	ADDWF       R0, 0 
	MOVWF       FLOC__Create_World+0 
	MOVLW       hi_addr(_world+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__Create_World+1 
	MOVF        _rands+0, 0 
	MOVWF       R0 
	MOVF        _rands+1, 0 
	MOVWF       R1 
	MOVLW       244
	MOVWF       R4 
	MOVLW       1
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_myrand_seed+0 
	MOVF        R1, 0 
	MOVWF       FARG_myrand_seed+1 
	CALL        _myrand+0, 0
	MOVLW       7
	ANDWF       R0, 0 
	MOVWF       R3 
	MOVF        R1, 0 
	MOVWF       R4 
	MOVLW       0
	ANDWF       R4, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       FLOC__Create_World+0, 0 
	MOVWF       FSR1L 
	MOVF        R1, 0 
	ADDWFC      FLOC__Create_World+1, 0 
	MOVWF       FSR1H 
	MOVF        _food_orientation+0, 0 
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;compy.c,291 :: 		world[myrand(rands * 85)& 0b000000000000000111][myrand(rands * 1)& 0b000000000000000111] = food_orientation;
	MOVF        _rands+0, 0 
	MOVWF       R0 
	MOVF        _rands+1, 0 
	MOVWF       R1 
	MOVLW       85
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_myrand_seed+0 
	MOVF        R1, 0 
	MOVWF       FARG_myrand_seed+1 
	CALL        _myrand+0, 0
	MOVLW       7
	ANDWF       R0, 1 
	MOVLW       0
	ANDWF       R1, 1 
	MOVLW       30
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _world+0
	ADDWF       R0, 0 
	MOVWF       FLOC__Create_World+0 
	MOVLW       hi_addr(_world+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__Create_World+1 
	MOVF        _rands+0, 0 
	MOVWF       FARG_myrand_seed+0 
	MOVF        _rands+1, 0 
	MOVWF       FARG_myrand_seed+1 
	CALL        _myrand+0, 0
	MOVLW       7
	ANDWF       R0, 0 
	MOVWF       R3 
	MOVF        R1, 0 
	MOVWF       R4 
	MOVLW       0
	ANDWF       R4, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       FLOC__Create_World+0, 0 
	MOVWF       FSR1L 
	MOVF        R1, 0 
	ADDWFC      FLOC__Create_World+1, 0 
	MOVWF       FSR1H 
	MOVF        _food_orientation+0, 0 
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;compy.c,292 :: 		world[myrand(rands * 552)& 0b000000000000000111][myrand(rands * 63)& 0b000000000000000111] = food_orientation;
	MOVF        _rands+0, 0 
	MOVWF       R0 
	MOVF        _rands+1, 0 
	MOVWF       R1 
	MOVLW       40
	MOVWF       R4 
	MOVLW       2
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_myrand_seed+0 
	MOVF        R1, 0 
	MOVWF       FARG_myrand_seed+1 
	CALL        _myrand+0, 0
	MOVLW       7
	ANDWF       R0, 1 
	MOVLW       0
	ANDWF       R1, 1 
	MOVLW       30
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _world+0
	ADDWF       R0, 0 
	MOVWF       FLOC__Create_World+0 
	MOVLW       hi_addr(_world+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__Create_World+1 
	MOVF        _rands+0, 0 
	MOVWF       R0 
	MOVF        _rands+1, 0 
	MOVWF       R1 
	MOVLW       63
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_myrand_seed+0 
	MOVF        R1, 0 
	MOVWF       FARG_myrand_seed+1 
	CALL        _myrand+0, 0
	MOVLW       7
	ANDWF       R0, 0 
	MOVWF       R3 
	MOVF        R1, 0 
	MOVWF       R4 
	MOVLW       0
	ANDWF       R4, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       FLOC__Create_World+0, 0 
	MOVWF       FSR1L 
	MOVF        R1, 0 
	ADDWFC      FLOC__Create_World+1, 0 
	MOVWF       FSR1H 
	MOVF        _food_orientation+0, 0 
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;compy.c,293 :: 		world[5][11] = food_orientation;
	MOVF        _food_orientation+0, 0 
	MOVWF       _world+172 
	MOVLW       0
	MOVWF       _world+173 
;compy.c,294 :: 		world[3][5] = food_orientation;
	MOVF        _food_orientation+0, 0 
	MOVWF       _world+100 
	MOVLW       0
	MOVWF       _world+101 
;compy.c,295 :: 		world[2][8] = food_orientation;
	MOVF        _food_orientation+0, 0 
	MOVWF       _world+76 
	MOVLW       0
	MOVWF       _world+77 
;compy.c,296 :: 		world[7][7] = food_orientation;
	MOVF        _food_orientation+0, 0 
	MOVWF       _world+224 
	MOVLW       0
	MOVWF       _world+225 
;compy.c,298 :: 		if (world[ghost_x][ghost_y] == food_orientation) --QTD_FOOD;
	MOVF        _ghost_x+0, 0 
	MOVWF       R0 
	MOVF        _ghost_x+1, 0 
	MOVWF       R1 
	MOVLW       30
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _world+0
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVLW       hi_addr(_world+0)
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVF        _ghost_y+0, 0 
	MOVWF       R0 
	MOVF        _ghost_y+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       R3, 0 
	MOVWF       FSR0L 
	MOVF        R1, 0 
	ADDWFC      R4, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Create_World154
	MOVF        _food_orientation+0, 0 
	XORWF       R1, 0 
L__Create_World154:
	BTFSS       STATUS+0, 2 
	GOTO        L_Create_World72
	MOVLW       1
	SUBWF       _QTD_FOOD+0, 1 
	MOVLW       0
	SUBWFB      _QTD_FOOD+1, 1 
L_Create_World72:
;compy.c,299 :: 		if (world[pacman_x][pacman_y] == food_orientation) --QTD_FOOD;
	MOVF        _pacman_x+0, 0 
	MOVWF       R0 
	MOVF        _pacman_x+1, 0 
	MOVWF       R1 
	MOVLW       30
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _world+0
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVLW       hi_addr(_world+0)
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVF        _pacman_y+0, 0 
	MOVWF       R0 
	MOVF        _pacman_y+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       R3, 0 
	MOVWF       FSR0L 
	MOVF        R1, 0 
	ADDWFC      R4, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Create_World155
	MOVF        _food_orientation+0, 0 
	XORWF       R1, 0 
L__Create_World155:
	BTFSS       STATUS+0, 2 
	GOTO        L_Create_World73
	MOVLW       1
	SUBWF       _QTD_FOOD+0, 1 
	MOVLW       0
	SUBWFB      _QTD_FOOD+1, 1 
L_Create_World73:
;compy.c,300 :: 		world[ghost_x][ghost_y] = ghost_orientation;
	MOVF        _ghost_x+0, 0 
	MOVWF       R0 
	MOVF        _ghost_x+1, 0 
	MOVWF       R1 
	MOVLW       30
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _world+0
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVLW       hi_addr(_world+0)
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVF        _ghost_y+0, 0 
	MOVWF       R0 
	MOVF        _ghost_y+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       R3, 0 
	MOVWF       FSR1L 
	MOVF        R1, 0 
	ADDWFC      R4, 0 
	MOVWF       FSR1H 
	MOVF        _ghost_orientation+0, 0 
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;compy.c,301 :: 		world[pacman_x][pacman_y] = (char) pacman_orientation;
	MOVF        _pacman_x+0, 0 
	MOVWF       R0 
	MOVF        _pacman_x+1, 0 
	MOVWF       R1 
	MOVLW       30
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _world+0
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVLW       hi_addr(_world+0)
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVF        _pacman_y+0, 0 
	MOVWF       R0 
	MOVF        _pacman_y+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       R3, 0 
	MOVWF       FSR1L 
	MOVF        R1, 0 
	ADDWFC      R4, 0 
	MOVWF       FSR1H 
	MOVF        _pacman_orientation+0, 0 
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;compy.c,302 :: 		}
	RETURN      0
; end of _Create_World

_Print_World:

;compy.c,305 :: 		void Print_World() {
;compy.c,307 :: 		for(i = 0; i < 15; ++i) {
	CLRF        _i+0 
	CLRF        _i+1 
L_Print_World74:
	MOVLW       128
	XORWF       _i+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Print_World156
	MOVLW       15
	SUBWF       _i+0, 0 
L__Print_World156:
	BTFSC       STATUS+0, 0 
	GOTO        L_Print_World75
;compy.c,308 :: 		for(j = 0; j < 15; ++j)
	CLRF        _j+0 
	CLRF        _j+1 
L_Print_World77:
	MOVLW       128
	XORWF       _j+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Print_World157
	MOVLW       15
	SUBWF       _j+0, 0 
L__Print_World157:
	BTFSC       STATUS+0, 0 
	GOTO        L_Print_World78
;compy.c,310 :: 		currentCharactere = world[i][j];
	MOVF        _i+0, 0 
	MOVWF       R0 
	MOVF        _i+1, 0 
	MOVWF       R1 
	MOVLW       30
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _world+0
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVLW       hi_addr(_world+0)
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVF        _j+0, 0 
	MOVWF       R0 
	MOVF        _j+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       R3, 0 
	MOVWF       FSR0L 
	MOVF        R1, 0 
	ADDWFC      R4, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       _currentCharactere+0 
;compy.c,311 :: 		if (currentCharactere == 0) {
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_World80
;compy.c,312 :: 		currentSprite = pacman_right;
	MOVLW       _pacman_right+0
	MOVWF       _currentSprite+0 
	MOVLW       hi_addr(_pacman_right+0)
	MOVWF       _currentSprite+1 
	MOVLW       higher_addr(_pacman_right+0)
	MOVWF       _currentSprite+2 
;compy.c,313 :: 		} else if (currentCharactere == 1) {
	GOTO        L_Print_World81
L_Print_World80:
	MOVF        _currentCharactere+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_World82
;compy.c,314 :: 		currentSprite = pacman_left;
	MOVLW       _pacman_left+0
	MOVWF       _currentSprite+0 
	MOVLW       hi_addr(_pacman_left+0)
	MOVWF       _currentSprite+1 
	MOVLW       higher_addr(_pacman_left+0)
	MOVWF       _currentSprite+2 
;compy.c,315 :: 		} else if (currentCharactere == 2) {
	GOTO        L_Print_World83
L_Print_World82:
	MOVF        _currentCharactere+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_World84
;compy.c,316 :: 		currentSprite = pacman_up;
	MOVLW       _pacman_up+0
	MOVWF       _currentSprite+0 
	MOVLW       hi_addr(_pacman_up+0)
	MOVWF       _currentSprite+1 
	MOVLW       higher_addr(_pacman_up+0)
	MOVWF       _currentSprite+2 
;compy.c,317 :: 		} else if (currentCharactere == 3) {
	GOTO        L_Print_World85
L_Print_World84:
	MOVF        _currentCharactere+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_World86
;compy.c,318 :: 		currentSprite = pacman_down;
	MOVLW       _pacman_down+0
	MOVWF       _currentSprite+0 
	MOVLW       hi_addr(_pacman_down+0)
	MOVWF       _currentSprite+1 
	MOVLW       higher_addr(_pacman_down+0)
	MOVWF       _currentSprite+2 
;compy.c,319 :: 		} else if (currentCharactere == food_orientation) {
	GOTO        L_Print_World87
L_Print_World86:
	MOVF        _currentCharactere+0, 0 
	XORWF       _food_orientation+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_World88
;compy.c,320 :: 		currentSprite = food;
	MOVLW       _food+0
	MOVWF       _currentSprite+0 
	MOVLW       hi_addr(_food+0)
	MOVWF       _currentSprite+1 
	MOVLW       higher_addr(_food+0)
	MOVWF       _currentSprite+2 
;compy.c,321 :: 		} else if (currentCharactere == ghost_orientation) {
	GOTO        L_Print_World89
L_Print_World88:
	MOVF        _currentCharactere+0, 0 
	XORWF       _ghost_orientation+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_World90
;compy.c,322 :: 		currentSprite = ghost;
	MOVLW       _ghost+0
	MOVWF       _currentSprite+0 
	MOVLW       hi_addr(_ghost+0)
	MOVWF       _currentSprite+1 
	MOVLW       higher_addr(_ghost+0)
	MOVWF       _currentSprite+2 
;compy.c,323 :: 		} else if (currentCharactere == barrier_orientation) {
	GOTO        L_Print_World91
L_Print_World90:
	MOVF        _currentCharactere+0, 0 
	XORWF       _barrier_orientation+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_World92
;compy.c,324 :: 		currentSprite = obstacle;
	MOVLW       _obstacle+0
	MOVWF       _currentSprite+0 
	MOVLW       hi_addr(_obstacle+0)
	MOVWF       _currentSprite+1 
	MOVLW       higher_addr(_obstacle+0)
	MOVWF       _currentSprite+2 
;compy.c,325 :: 		} else if (currentCharactere == ' ') {
	GOTO        L_Print_World93
L_Print_World92:
	MOVF        _currentCharactere+0, 0 
	XORLW       32
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_World94
;compy.c,326 :: 		currentSprite = blank;
	MOVLW       _blank+0
	MOVWF       _currentSprite+0 
	MOVLW       hi_addr(_blank+0)
	MOVWF       _currentSprite+1 
	MOVLW       higher_addr(_blank+0)
	MOVWF       _currentSprite+2 
;compy.c,327 :: 		} else {
	GOTO        L_Print_World95
L_Print_World94:
;compy.c,328 :: 		currentSprite = blank;
	MOVLW       _blank+0
	MOVWF       _currentSprite+0 
	MOVLW       hi_addr(_blank+0)
	MOVWF       _currentSprite+1 
	MOVLW       higher_addr(_blank+0)
	MOVWF       _currentSprite+2 
;compy.c,329 :: 		}
L_Print_World95:
L_Print_World93:
L_Print_World91:
L_Print_World89:
L_Print_World87:
L_Print_World85:
L_Print_World83:
L_Print_World81:
;compy.c,330 :: 		print(i, j, currentSprite);
	MOVF        _i+0, 0 
	MOVWF       FARG_print_line+0 
	MOVF        _j+0, 0 
	MOVWF       FARG_print_column+0 
	MOVF        _currentSprite+0, 0 
	MOVWF       FARG_print_sprite+0 
	MOVF        _currentSprite+1, 0 
	MOVWF       FARG_print_sprite+1 
	MOVF        _currentSprite+2, 0 
	MOVWF       FARG_print_sprite+2 
	CALL        _print+0, 0
;compy.c,308 :: 		for(j = 0; j < 15; ++j)
	INFSNZ      _j+0, 1 
	INCF        _j+1, 1 
;compy.c,331 :: 		}
	GOTO        L_Print_World77
L_Print_World78:
;compy.c,307 :: 		for(i = 0; i < 15; ++i) {
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;compy.c,332 :: 		}
	GOTO        L_Print_World74
L_Print_World75:
;compy.c,333 :: 		}
	RETURN      0
; end of _Print_World

_update_pacman_orientation:

;compy.c,335 :: 		char update_pacman_orientation(int newX, int newY) {
;compy.c,336 :: 		if (newX > pacman_x) {
	MOVLW       128
	XORWF       _pacman_x+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_update_pacman_orientation_newX+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman_orientation158
	MOVF        FARG_update_pacman_orientation_newX+0, 0 
	SUBWF       _pacman_x+0, 0 
L__update_pacman_orientation158:
	BTFSC       STATUS+0, 0 
	GOTO        L_update_pacman_orientation96
;compy.c,337 :: 		return (char) 0;
	CLRF        R0 
	RETURN      0
;compy.c,338 :: 		} else if (newX < pacman_x) {
L_update_pacman_orientation96:
	MOVLW       128
	XORWF       FARG_update_pacman_orientation_newX+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _pacman_x+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman_orientation159
	MOVF        _pacman_x+0, 0 
	SUBWF       FARG_update_pacman_orientation_newX+0, 0 
L__update_pacman_orientation159:
	BTFSC       STATUS+0, 0 
	GOTO        L_update_pacman_orientation98
;compy.c,339 :: 		return (char) 1;
	MOVLW       1
	MOVWF       R0 
	RETURN      0
;compy.c,340 :: 		} else if (newY > pacman_y) {
L_update_pacman_orientation98:
	MOVLW       128
	XORWF       _pacman_y+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_update_pacman_orientation_newY+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman_orientation160
	MOVF        FARG_update_pacman_orientation_newY+0, 0 
	SUBWF       _pacman_y+0, 0 
L__update_pacman_orientation160:
	BTFSC       STATUS+0, 0 
	GOTO        L_update_pacman_orientation100
;compy.c,341 :: 		return (char) 2;
	MOVLW       2
	MOVWF       R0 
	RETURN      0
;compy.c,342 :: 		} else if (newY < pacman_y) {
L_update_pacman_orientation100:
	MOVLW       128
	XORWF       FARG_update_pacman_orientation_newY+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _pacman_y+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman_orientation161
	MOVF        _pacman_y+0, 0 
	SUBWF       FARG_update_pacman_orientation_newY+0, 0 
L__update_pacman_orientation161:
	BTFSC       STATUS+0, 0 
	GOTO        L_update_pacman_orientation102
;compy.c,343 :: 		return 3;
	MOVLW       3
	MOVWF       R0 
	RETURN      0
;compy.c,344 :: 		}
L_update_pacman_orientation102:
;compy.c,345 :: 		return pacman_orientation;
	MOVF        _pacman_orientation+0, 0 
	MOVWF       R0 
;compy.c,346 :: 		}
	RETURN      0
; end of _update_pacman_orientation

_update_pacman:

;compy.c,351 :: 		void update_pacman(short direction) {
;compy.c,352 :: 		if (direction == 0) {
	MOVF        FARG_update_pacman_direction+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_update_pacman103
;compy.c,353 :: 		newPacman_x = pacman_x;
	MOVF        _pacman_x+0, 0 
	MOVWF       _newPacman_x+0 
	MOVF        _pacman_x+1, 0 
	MOVWF       _newPacman_x+1 
;compy.c,354 :: 		newPacman_y = pacman_y - 1;
	MOVLW       1
	SUBWF       _pacman_y+0, 0 
	MOVWF       _newPacman_y+0 
	MOVLW       0
	SUBWFB      _pacman_y+1, 0 
	MOVWF       _newPacman_y+1 
;compy.c,355 :: 		} else if (direction == 1) {
	GOTO        L_update_pacman104
L_update_pacman103:
	MOVF        FARG_update_pacman_direction+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_update_pacman105
;compy.c,356 :: 		newPacman_x = pacman_x;
	MOVF        _pacman_x+0, 0 
	MOVWF       _newPacman_x+0 
	MOVF        _pacman_x+1, 0 
	MOVWF       _newPacman_x+1 
;compy.c,357 :: 		newPacman_y = pacman_y + 1;
	MOVLW       1
	ADDWF       _pacman_y+0, 0 
	MOVWF       _newPacman_y+0 
	MOVLW       0
	ADDWFC      _pacman_y+1, 0 
	MOVWF       _newPacman_y+1 
;compy.c,358 :: 		} else if (direction == 2) {
	GOTO        L_update_pacman106
L_update_pacman105:
	MOVF        FARG_update_pacman_direction+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_update_pacman107
;compy.c,359 :: 		newPacman_x = pacman_x + 1;
	MOVLW       1
	ADDWF       _pacman_x+0, 0 
	MOVWF       _newPacman_x+0 
	MOVLW       0
	ADDWFC      _pacman_x+1, 0 
	MOVWF       _newPacman_x+1 
;compy.c,360 :: 		newPacman_y = pacman_y;
	MOVF        _pacman_y+0, 0 
	MOVWF       _newPacman_y+0 
	MOVF        _pacman_y+1, 0 
	MOVWF       _newPacman_y+1 
;compy.c,361 :: 		} else if (direction == 3) {
	GOTO        L_update_pacman108
L_update_pacman107:
	MOVF        FARG_update_pacman_direction+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_update_pacman109
;compy.c,362 :: 		newPacman_x = pacman_x - 1;
	MOVLW       1
	SUBWF       _pacman_x+0, 0 
	MOVWF       _newPacman_x+0 
	MOVLW       0
	SUBWFB      _pacman_x+1, 0 
	MOVWF       _newPacman_x+1 
;compy.c,363 :: 		newPacman_y = pacman_y;
	MOVF        _pacman_y+0, 0 
	MOVWF       _newPacman_y+0 
	MOVF        _pacman_y+1, 0 
	MOVWF       _newPacman_y+1 
;compy.c,364 :: 		}
L_update_pacman109:
L_update_pacman108:
L_update_pacman106:
L_update_pacman104:
;compy.c,366 :: 		newPacmanOrientation = update_pacman_orientation(newPacman_x, newPacman_y);
	MOVF        _newPacman_x+0, 0 
	MOVWF       FARG_update_pacman_orientation_newX+0 
	MOVF        _newPacman_x+1, 0 
	MOVWF       FARG_update_pacman_orientation_newX+1 
	MOVF        _newPacman_y+0, 0 
	MOVWF       FARG_update_pacman_orientation_newY+0 
	MOVF        _newPacman_y+1, 0 
	MOVWF       FARG_update_pacman_orientation_newY+1 
	CALL        _update_pacman_orientation+0, 0
	MOVF        R0, 0 
	MOVWF       _newPacmanOrientation+0 
	MOVLW       0
	MOVWF       _newPacmanOrientation+1 
;compy.c,368 :: 		if (newPacman_x < 0) newPacman_x = 14;
	MOVLW       128
	XORWF       _newPacman_x+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman162
	MOVLW       0
	SUBWF       _newPacman_x+0, 0 
L__update_pacman162:
	BTFSC       STATUS+0, 0 
	GOTO        L_update_pacman110
	MOVLW       14
	MOVWF       _newPacman_x+0 
	MOVLW       0
	MOVWF       _newPacman_x+1 
L_update_pacman110:
;compy.c,369 :: 		if (newPacman_x >= 14) newPacman_x = 0;
	MOVLW       128
	XORWF       _newPacman_x+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman163
	MOVLW       14
	SUBWF       _newPacman_x+0, 0 
L__update_pacman163:
	BTFSS       STATUS+0, 0 
	GOTO        L_update_pacman111
	CLRF        _newPacman_x+0 
	CLRF        _newPacman_x+1 
L_update_pacman111:
;compy.c,371 :: 		if (newPacman_y < 0) newPacman_y = 14;
	MOVLW       128
	XORWF       _newPacman_y+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman164
	MOVLW       0
	SUBWF       _newPacman_y+0, 0 
L__update_pacman164:
	BTFSC       STATUS+0, 0 
	GOTO        L_update_pacman112
	MOVLW       14
	MOVWF       _newPacman_y+0 
	MOVLW       0
	MOVWF       _newPacman_y+1 
L_update_pacman112:
;compy.c,372 :: 		if (newPacman_y >= 14) newPacman_y = 0;
	MOVLW       128
	XORWF       _newPacman_y+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman165
	MOVLW       14
	SUBWF       _newPacman_y+0, 0 
L__update_pacman165:
	BTFSS       STATUS+0, 0 
	GOTO        L_update_pacman113
	CLRF        _newPacman_y+0 
	CLRF        _newPacman_y+1 
L_update_pacman113:
;compy.c,374 :: 		if (world[newPacman_x][newPacman_y] != barrier_orientation) {
	MOVF        _newPacman_x+0, 0 
	MOVWF       R0 
	MOVF        _newPacman_x+1, 0 
	MOVWF       R1 
	MOVLW       30
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _world+0
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVLW       hi_addr(_world+0)
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVF        _newPacman_y+0, 0 
	MOVWF       R0 
	MOVF        _newPacman_y+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       R3, 0 
	MOVWF       FSR0L 
	MOVF        R1, 0 
	ADDWFC      R4, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman166
	MOVF        _barrier_orientation+0, 0 
	XORWF       R1, 0 
L__update_pacman166:
	BTFSC       STATUS+0, 2 
	GOTO        L_update_pacman114
;compy.c,375 :: 		if (world[newPacman_x][newPacman_y] == food_orientation) {
	MOVF        _newPacman_x+0, 0 
	MOVWF       R0 
	MOVF        _newPacman_x+1, 0 
	MOVWF       R1 
	MOVLW       30
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _world+0
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVLW       hi_addr(_world+0)
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVF        _newPacman_y+0, 0 
	MOVWF       R0 
	MOVF        _newPacman_y+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       R3, 0 
	MOVWF       FSR0L 
	MOVF        R1, 0 
	ADDWFC      R4, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman167
	MOVF        _food_orientation+0, 0 
	XORWF       R1, 0 
L__update_pacman167:
	BTFSS       STATUS+0, 2 
	GOTO        L_update_pacman115
;compy.c,376 :: 		QTD_FOOD --;
	MOVLW       1
	SUBWF       _QTD_FOOD+0, 1 
	MOVLW       0
	SUBWFB      _QTD_FOOD+1, 1 
;compy.c,377 :: 		}
L_update_pacman115:
;compy.c,378 :: 		if (QTD_FOOD == 0) {
	MOVLW       0
	XORWF       _QTD_FOOD+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman168
	MOVLW       0
	XORWF       _QTD_FOOD+0, 0 
L__update_pacman168:
	BTFSS       STATUS+0, 2 
	GOTO        L_update_pacman116
;compy.c,379 :: 		IS_FINISH = 1;
	MOVLW       1
	MOVWF       _IS_FINISH+0 
	MOVLW       0
	MOVWF       _IS_FINISH+1 
;compy.c,380 :: 		IS_GAME_OVER = 0;
	CLRF        _IS_GAME_OVER+0 
	CLRF        _IS_GAME_OVER+1 
;compy.c,381 :: 		}
L_update_pacman116:
;compy.c,383 :: 		pacman_orientation = newPacmanOrientation;
	MOVF        _newPacmanOrientation+0, 0 
	MOVWF       _pacman_orientation+0 
;compy.c,385 :: 		world[pacman_x][pacman_y] = ' ';
	MOVF        _pacman_x+0, 0 
	MOVWF       R0 
	MOVF        _pacman_x+1, 0 
	MOVWF       R1 
	MOVLW       30
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _world+0
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVLW       hi_addr(_world+0)
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVF        _pacman_y+0, 0 
	MOVWF       R0 
	MOVF        _pacman_y+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       R3, 0 
	MOVWF       FSR1L 
	MOVF        R1, 0 
	ADDWFC      R4, 0 
	MOVWF       FSR1H 
	MOVLW       32
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;compy.c,386 :: 		world[newPacman_x][newPacman_y] = pacman_orientation;
	MOVF        _newPacman_x+0, 0 
	MOVWF       R0 
	MOVF        _newPacman_x+1, 0 
	MOVWF       R1 
	MOVLW       30
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _world+0
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVLW       hi_addr(_world+0)
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVF        _newPacman_y+0, 0 
	MOVWF       R0 
	MOVF        _newPacman_y+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       R3, 0 
	MOVWF       FSR1L 
	MOVF        R1, 0 
	ADDWFC      R4, 0 
	MOVWF       FSR1H 
	MOVF        _pacman_orientation+0, 0 
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;compy.c,388 :: 		pacman_x = newPacman_x;
	MOVF        _newPacman_x+0, 0 
	MOVWF       _pacman_x+0 
	MOVF        _newPacman_x+1, 0 
	MOVWF       _pacman_x+1 
;compy.c,389 :: 		pacman_y = newPacman_y;
	MOVF        _newPacman_y+0, 0 
	MOVWF       _pacman_y+0 
	MOVF        _newPacman_y+1, 0 
	MOVWF       _pacman_y+1 
;compy.c,390 :: 		}
L_update_pacman114:
;compy.c,391 :: 		}
	RETURN      0
; end of _update_pacman

_Write_EEPROM:

;compy.c,393 :: 		void Write_EEPROM(int END, int DADO)
;compy.c,395 :: 		I2C1_Start();           // issue I2C start signal
	CALL        _I2C1_Start+0, 0
;compy.c,396 :: 		I2C1_Wr(0xA0);          // send byte via I2C  (device address + W)
	MOVLW       160
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;compy.c,397 :: 		I2C1_Wr(END);             // send byte (address of EEPROM location)
	MOVF        FARG_Write_EEPROM_END+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;compy.c,398 :: 		I2C1_Wr(DADO);          // send data (data to be written)
	MOVF        FARG_Write_EEPROM_DADO+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;compy.c,399 :: 		I2C1_Stop();            // issue I2C stop signal
	CALL        _I2C1_Stop+0, 0
;compy.c,400 :: 		delay_ms(10);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_Write_EEPROM117:
	DECFSZ      R13, 1, 0
	BRA         L_Write_EEPROM117
	DECFSZ      R12, 1, 0
	BRA         L_Write_EEPROM117
	NOP
;compy.c,401 :: 		}
	RETURN      0
; end of _Write_EEPROM

_Write_EEPROM_Int:

;compy.c,403 :: 		void Write_EEPROM_Int(int END, int dado) {
;compy.c,404 :: 		Write_EEPROM(END, dado / 256);
	MOVF        FARG_Write_EEPROM_Int_END+0, 0 
	MOVWF       FARG_Write_EEPROM_END+0 
	MOVF        FARG_Write_EEPROM_Int_END+1, 0 
	MOVWF       FARG_Write_EEPROM_END+1 
	MOVF        FARG_Write_EEPROM_Int_dado+1, 0 
	MOVWF       FARG_Write_EEPROM_DADO+0 
	MOVLW       0
	BTFSC       FARG_Write_EEPROM_Int_dado+1, 7 
	MOVLW       255
	MOVWF       FARG_Write_EEPROM_DADO+1 
	CALL        _Write_EEPROM+0, 0
;compy.c,405 :: 		Write_EEPROM(END + 1, dado % 256);
	MOVLW       1
	ADDWF       FARG_Write_EEPROM_Int_END+0, 0 
	MOVWF       FARG_Write_EEPROM_END+0 
	MOVLW       0
	ADDWFC      FARG_Write_EEPROM_Int_END+1, 0 
	MOVWF       FARG_Write_EEPROM_END+1 
	MOVLW       0
	MOVWF       R4 
	MOVLW       1
	MOVWF       R5 
	MOVF        FARG_Write_EEPROM_Int_dado+0, 0 
	MOVWF       R0 
	MOVF        FARG_Write_EEPROM_Int_dado+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       FARG_Write_EEPROM_DADO+0 
	MOVF        R1, 0 
	MOVWF       FARG_Write_EEPROM_DADO+1 
	CALL        _Write_EEPROM+0, 0
;compy.c,406 :: 		}
	RETURN      0
; end of _Write_EEPROM_Int

_Read_EEPROM:

;compy.c,408 :: 		int Read_EEPROM(int END)
;compy.c,411 :: 		I2C1_Start();           // issue I2C start signal
	CALL        _I2C1_Start+0, 0
;compy.c,412 :: 		I2C1_Wr(0xA0);          // send byte via I2C  (device address + W)
	MOVLW       160
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;compy.c,413 :: 		I2C1_Wr(END);             // send byte (data address)
	MOVF        FARG_Read_EEPROM_END+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;compy.c,414 :: 		I2C1_Repeated_Start();  // issue I2C signal repeated start
	CALL        _I2C1_Repeated_Start+0, 0
;compy.c,415 :: 		I2C1_Wr(0xA1);          // send byte (device address + R)
	MOVLW       161
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;compy.c,416 :: 		Dado = I2C1_Rd(0u);    // Read the data (NO acknowledge)
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       Read_EEPROM_Dado_L0+0 
	MOVLW       0
	MOVWF       Read_EEPROM_Dado_L0+1 
;compy.c,417 :: 		I2C1_Stop();            // issue I2C stop signal
	CALL        _I2C1_Stop+0, 0
;compy.c,418 :: 		return(Dado);
	MOVF        Read_EEPROM_Dado_L0+0, 0 
	MOVWF       R0 
	MOVF        Read_EEPROM_Dado_L0+1, 0 
	MOVWF       R1 
;compy.c,419 :: 		}
	RETURN      0
; end of _Read_EEPROM

_Read_EEPROM_Int:

;compy.c,423 :: 		int Read_EEPROM_Int(int END) {
;compy.c,424 :: 		byte_1 = Read_EEPROM(END);
	MOVF        FARG_Read_EEPROM_Int_END+0, 0 
	MOVWF       FARG_Read_EEPROM_END+0 
	MOVF        FARG_Read_EEPROM_Int_END+1, 0 
	MOVWF       FARG_Read_EEPROM_END+1 
	CALL        _Read_EEPROM+0, 0
	MOVF        R0, 0 
	MOVWF       _byte_1+0 
;compy.c,425 :: 		byte_2 = Read_EEPROM(END + 1);
	MOVLW       1
	ADDWF       FARG_Read_EEPROM_Int_END+0, 0 
	MOVWF       FARG_Read_EEPROM_END+0 
	MOVLW       0
	ADDWFC      FARG_Read_EEPROM_Int_END+1, 0 
	MOVWF       FARG_Read_EEPROM_END+1 
	CALL        _Read_EEPROM+0, 0
	MOVF        R0, 0 
	MOVWF       _byte_2+0 
;compy.c,427 :: 		return (byte_1 * 256) + byte_2;
	MOVF        _byte_1+0, 0 
	MOVWF       R3 
	CLRF        R2 
	MOVLW       0
	BTFSC       R0, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        R2, 0 
	ADDWF       R0, 1 
	MOVF        R3, 0 
	ADDWFC      R1, 1 
;compy.c,428 :: 		}
	RETURN      0
; end of _Read_EEPROM_Int

_Transform_Time:

;compy.c,432 :: 		void Transform_Time(char *sec, char *min, char *hr) {
;compy.c,433 :: 		*sec = ((*sec & 0xF0) >> 4)*10 + (*sec & 0x0F);
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
;compy.c,434 :: 		*min = ((*min & 0xF0) >> 4)*10 + (*min & 0x0F);
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
;compy.c,435 :: 		*hr = ((*hr & 0xF0) >> 4)*10 + (*hr & 0x0F);
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
;compy.c,436 :: 		}
	RETURN      0
; end of _Transform_Time

_Start_Screen:

;compy.c,442 :: 		void Start_Screen() {
;compy.c,443 :: 		print_text(1, 6, "PAC MAN");
	MOVLW       1
	MOVWF       FARG_print_text_line+0 
	MOVLW       6
	MOVWF       FARG_print_text_column+0 
	MOVLW       ?lstr1_compy+0
	MOVWF       FARG_print_text_text+0 
	MOVLW       hi_addr(?lstr1_compy+0)
	MOVWF       FARG_print_text_text+1 
	CALL        _print_text+0, 0
;compy.c,444 :: 		print_text(3, 1, "PRESSIONE UMA TECLA!");
	MOVLW       3
	MOVWF       FARG_print_text_line+0 
	MOVLW       1
	MOVWF       FARG_print_text_column+0 
	MOVLW       ?lstr2_compy+0
	MOVWF       FARG_print_text_text+0 
	MOVLW       hi_addr(?lstr2_compy+0)
	MOVWF       FARG_print_text_text+1 
	CALL        _print_text+0, 0
;compy.c,446 :: 		while (Le_Teclado() == 255);
L_Start_Screen118:
	CALL        _Le_Teclado+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_Start_Screen119
	GOTO        L_Start_Screen118
L_Start_Screen119:
;compy.c,447 :: 		}
	RETURN      0
; end of _Start_Screen

_Finish:

;compy.c,449 :: 		void Finish() {
;compy.c,450 :: 		for(i = 0; i < 15; ++i) {
	CLRF        _i+0 
	CLRF        _i+1 
L_Finish120:
	MOVLW       128
	XORWF       _i+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Finish169
	MOVLW       15
	SUBWF       _i+0, 0 
L__Finish169:
	BTFSC       STATUS+0, 0 
	GOTO        L_Finish121
;compy.c,451 :: 		for(j = 0; j < 8; ++j) {
	CLRF        _j+0 
	CLRF        _j+1 
L_Finish123:
	MOVLW       128
	XORWF       _j+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Finish170
	MOVLW       8
	SUBWF       _j+0, 0 
L__Finish170:
	BTFSC       STATUS+0, 0 
	GOTO        L_Finish124
;compy.c,452 :: 		world[i][j] = ' ';
	MOVF        _i+0, 0 
	MOVWF       R0 
	MOVF        _i+1, 0 
	MOVWF       R1 
	MOVLW       30
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _world+0
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVLW       hi_addr(_world+0)
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVF        _j+0, 0 
	MOVWF       R0 
	MOVF        _j+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       R3, 0 
	MOVWF       FSR1L 
	MOVF        R1, 0 
	ADDWFC      R4, 0 
	MOVWF       FSR1H 
	MOVLW       32
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;compy.c,451 :: 		for(j = 0; j < 8; ++j) {
	INFSNZ      _j+0, 1 
	INCF        _j+1, 1 
;compy.c,453 :: 		}
	GOTO        L_Finish123
L_Finish124:
;compy.c,450 :: 		for(i = 0; i < 15; ++i) {
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;compy.c,454 :: 		}
	GOTO        L_Finish120
L_Finish121:
;compy.c,455 :: 		Print_World();
	CALL        _Print_World+0, 0
;compy.c,456 :: 		if (IS_GAME_OVER) {
	MOVF        _IS_GAME_OVER+0, 0 
	IORWF       _IS_GAME_OVER+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Finish126
;compy.c,457 :: 		print_text(2, 1, "Game over");
	MOVLW       2
	MOVWF       FARG_print_text_line+0 
	MOVLW       1
	MOVWF       FARG_print_text_column+0 
	MOVLW       ?lstr3_compy+0
	MOVWF       FARG_print_text_text+0 
	MOVLW       hi_addr(?lstr3_compy+0)
	MOVWF       FARG_print_text_text+1 
	CALL        _print_text+0, 0
;compy.c,458 :: 		} else {
	GOTO        L_Finish127
L_Finish126:
;compy.c,459 :: 		print_text(2, 1, "Win");
	MOVLW       2
	MOVWF       FARG_print_text_line+0 
	MOVLW       1
	MOVWF       FARG_print_text_column+0 
	MOVLW       ?lstr4_compy+0
	MOVWF       FARG_print_text_text+0 
	MOVLW       hi_addr(?lstr4_compy+0)
	MOVWF       FARG_print_text_text+1 
	CALL        _print_text+0, 0
;compy.c,460 :: 		}
L_Finish127:
;compy.c,461 :: 		}
	RETURN      0
; end of _Finish

_main:

;compy.c,463 :: 		void main() {           // General purpose register
;compy.c,464 :: 		UART1_Init(19200);
	MOVLW       25
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;compy.c,465 :: 		I2C1_Init(100000);
	MOVLW       20
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;compy.c,466 :: 		ADCON1 = 0B00001110;
	MOVLW       14
	MOVWF       ADCON1+0 
;compy.c,467 :: 		TRISB = 0B00001111;
	MOVLW       15
	MOVWF       TRISB+0 
;compy.c,468 :: 		TRISA = 0B00100001;
	MOVLW       33
	MOVWF       TRISA+0 
;compy.c,470 :: 		TRISA3_bit = 1;               // Set RA3 as input
	BSF         TRISA3_bit+0, 3 
;compy.c,471 :: 		TRISA4_bit = 1;               // Set RA4 as input
	BSF         TRISA4_bit+0, 4 
;compy.c,475 :: 		T6963C_init(240, 128, 8);
	MOVLW       240
	MOVWF       FARG_T6963C_init_width+0 
	MOVLW       0
	MOVWF       FARG_T6963C_init_width+1 
	MOVLW       128
	MOVWF       FARG_T6963C_init_height+0 
	MOVLW       8
	MOVWF       FARG_T6963C_init_fntW+0 
	CALL        _T6963C_init+0, 0
;compy.c,480 :: 		T6963C_graphics(1);
	BSF         _T6963C_display+0, 3 
	MOVF        _T6963C_display+0, 0 
	MOVWF       FARG_T6963C_writeCommand_mydata+0 
	CALL        _T6963C_writeCommand+0, 0
;compy.c,481 :: 		T6963C_text(1);
	BSF         _T6963C_display+0, 2 
	MOVF        _T6963C_display+0, 0 
	MOVWF       FARG_T6963C_writeCommand_mydata+0 
	CALL        _T6963C_writeCommand+0, 0
;compy.c,484 :: 		InitTimer2();
	CALL        _InitTimer2+0, 0
;compy.c,487 :: 		Create_World();
	CALL        _Create_World+0, 0
;compy.c,490 :: 		while (1) {
L_main128:
;compy.c,491 :: 		if (IS_FINISH) {
	MOVF        _IS_FINISH+0, 0 
	IORWF       _IS_FINISH+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main130
;compy.c,492 :: 		break;
	GOTO        L_main129
;compy.c,493 :: 		}
L_main130:
;compy.c,494 :: 		command = Le_Teclado();
	CALL        _Le_Teclado+0, 0
	MOVF        R0, 0 
	MOVWF       _command+0 
;compy.c,495 :: 		if (command == '8') {
	MOVF        R0, 0 
	XORLW       56
	BTFSS       STATUS+0, 2 
	GOTO        L_main131
;compy.c,496 :: 		update_pacman(0);
	CLRF        FARG_update_pacman_direction+0 
	CALL        _update_pacman+0, 0
;compy.c,497 :: 		} else if (command == '2') {
	GOTO        L_main132
L_main131:
	MOVF        _command+0, 0 
	XORLW       50
	BTFSS       STATUS+0, 2 
	GOTO        L_main133
;compy.c,498 :: 		update_pacman(1);
	MOVLW       1
	MOVWF       FARG_update_pacman_direction+0 
	CALL        _update_pacman+0, 0
;compy.c,499 :: 		} else if (command == '6') {
	GOTO        L_main134
L_main133:
	MOVF        _command+0, 0 
	XORLW       54
	BTFSS       STATUS+0, 2 
	GOTO        L_main135
;compy.c,500 :: 		update_pacman(2);
	MOVLW       2
	MOVWF       FARG_update_pacman_direction+0 
	CALL        _update_pacman+0, 0
;compy.c,501 :: 		} else if (command == '4') {
	GOTO        L_main136
L_main135:
	MOVF        _command+0, 0 
	XORLW       52
	BTFSS       STATUS+0, 2 
	GOTO        L_main137
;compy.c,502 :: 		update_pacman(3);
	MOVLW       3
	MOVWF       FARG_update_pacman_direction+0 
	CALL        _update_pacman+0, 0
;compy.c,503 :: 		}
L_main137:
L_main136:
L_main134:
L_main132:
;compy.c,504 :: 		Print_World();
	CALL        _Print_World+0, 0
;compy.c,505 :: 		if (pacman_x == ghost_x && pacman_y == ghost_y) {
	MOVF        _pacman_x+1, 0 
	XORWF       _ghost_x+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main171
	MOVF        _ghost_x+0, 0 
	XORWF       _pacman_x+0, 0 
L__main171:
	BTFSS       STATUS+0, 2 
	GOTO        L_main140
	MOVF        _pacman_y+1, 0 
	XORWF       _ghost_y+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main172
	MOVF        _ghost_y+0, 0 
	XORWF       _pacman_y+0, 0 
L__main172:
	BTFSS       STATUS+0, 2 
	GOTO        L_main140
L__main141:
;compy.c,506 :: 		IS_FINISH = 1;
	MOVLW       1
	MOVWF       _IS_FINISH+0 
	MOVLW       0
	MOVWF       _IS_FINISH+1 
;compy.c,507 :: 		IS_GAME_OVER = 1;
	MOVLW       1
	MOVWF       _IS_GAME_OVER+0 
	MOVLW       0
	MOVWF       _IS_GAME_OVER+1 
;compy.c,508 :: 		}
L_main140:
;compy.c,509 :: 		}
	GOTO        L_main128
L_main129:
;compy.c,510 :: 		Finish();
	CALL        _Finish+0, 0
;compy.c,512 :: 		}
	GOTO        $+0
; end of _main
