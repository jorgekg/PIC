
_print:

;compy.c,56 :: 		void print(unsigned char column, unsigned char line, code const unsigned char* sprite) {
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
;compy.c,59 :: 		T6963C_sprite(column * 16, line * 16, sprite, 16, 16);
	MOVF        FARG_print_column+0, 0 
	MOVWF       FARG_T6963C_sprite_px+0 
	RLCF        FARG_T6963C_sprite_px+0, 1 
	BCF         FARG_T6963C_sprite_px+0, 0 
	RLCF        FARG_T6963C_sprite_px+0, 1 
	BCF         FARG_T6963C_sprite_px+0, 0 
	RLCF        FARG_T6963C_sprite_px+0, 1 
	BCF         FARG_T6963C_sprite_px+0, 0 
	RLCF        FARG_T6963C_sprite_px+0, 1 
	BCF         FARG_T6963C_sprite_px+0, 0 
	MOVF        FARG_print_line+0, 0 
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

;compy.c,62 :: 		void print_text(unsigned char column, unsigned char line, unsigned char* text) {
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

_getSprite:

;compy.c,85 :: 		const unsigned char* getSprite(char charactereValue) {
;compy.c,86 :: 		if (charactereValue == 0) {
	MOVF        FARG_getSprite_charactereValue+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_getSprite0
;compy.c,87 :: 		return pacman_up;
	MOVLW       _pacman_up+0
	MOVWF       R0 
	MOVLW       hi_addr(_pacman_up+0)
	MOVWF       R1 
	MOVLW       higher_addr(_pacman_up+0)
	MOVWF       R2 
	RETURN      0
;compy.c,88 :: 		} else if (charactereValue == 1) {
L_getSprite0:
	MOVF        FARG_getSprite_charactereValue+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_getSprite2
;compy.c,89 :: 		return pacman_right;
	MOVLW       _pacman_right+0
	MOVWF       R0 
	MOVLW       hi_addr(_pacman_right+0)
	MOVWF       R1 
	MOVLW       higher_addr(_pacman_right+0)
	MOVWF       R2 
	RETURN      0
;compy.c,90 :: 		} else if (charactereValue == 2) {
L_getSprite2:
	MOVF        FARG_getSprite_charactereValue+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_getSprite4
;compy.c,91 :: 		return pacman_down;
	MOVLW       _pacman_down+0
	MOVWF       R0 
	MOVLW       hi_addr(_pacman_down+0)
	MOVWF       R1 
	MOVLW       higher_addr(_pacman_down+0)
	MOVWF       R2 
	RETURN      0
;compy.c,92 :: 		} else if (charactereValue == 3) {
L_getSprite4:
	MOVF        FARG_getSprite_charactereValue+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_getSprite6
;compy.c,93 :: 		return pacman_left;
	MOVLW       _pacman_left+0
	MOVWF       R0 
	MOVLW       hi_addr(_pacman_left+0)
	MOVWF       R1 
	MOVLW       higher_addr(_pacman_left+0)
	MOVWF       R2 
	RETURN      0
;compy.c,94 :: 		} else if (charactereValue == food_orientation) {
L_getSprite6:
	MOVF        FARG_getSprite_charactereValue+0, 0 
	XORWF       _food_orientation+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_getSprite8
;compy.c,95 :: 		return food;
	MOVLW       _food+0
	MOVWF       R0 
	MOVLW       hi_addr(_food+0)
	MOVWF       R1 
	MOVLW       higher_addr(_food+0)
	MOVWF       R2 
	RETURN      0
;compy.c,96 :: 		} else if (charactereValue == ghost_orientation) {
L_getSprite8:
	MOVF        FARG_getSprite_charactereValue+0, 0 
	XORWF       _ghost_orientation+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_getSprite10
;compy.c,97 :: 		return ghost;
	MOVLW       _ghost+0
	MOVWF       R0 
	MOVLW       hi_addr(_ghost+0)
	MOVWF       R1 
	MOVLW       higher_addr(_ghost+0)
	MOVWF       R2 
	RETURN      0
;compy.c,98 :: 		} else if (charactereValue == barrier_orientation) {
L_getSprite10:
	MOVF        FARG_getSprite_charactereValue+0, 0 
	XORWF       _barrier_orientation+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_getSprite12
;compy.c,99 :: 		return obstacle;
	MOVLW       _obstacle+0
	MOVWF       R0 
	MOVLW       hi_addr(_obstacle+0)
	MOVWF       R1 
	MOVLW       higher_addr(_obstacle+0)
	MOVWF       R2 
	RETURN      0
;compy.c,100 :: 		}
L_getSprite12:
;compy.c,101 :: 		return blank;
	MOVLW       _blank+0
	MOVWF       R0 
	MOVLW       hi_addr(_blank+0)
	MOVWF       R1 
	MOVLW       higher_addr(_blank+0)
	MOVWF       R2 
;compy.c,102 :: 		}
	RETURN      0
; end of _getSprite

_printCoordinate:

;compy.c,104 :: 		void printCoordinate(int x, int y) {
;compy.c,105 :: 		print(x, y, getSprite(world[x][y]));
	MOVF        FARG_printCoordinate_x+0, 0 
	MOVWF       R0 
	MOVF        FARG_printCoordinate_x+1, 0 
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
	MOVF        FARG_printCoordinate_y+0, 0 
	MOVWF       R0 
	MOVF        FARG_printCoordinate_y+1, 0 
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
	MOVWF       FARG_getSprite_charactereValue+0 
	CALL        _getSprite+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_print_sprite+0 
	MOVF        R1, 0 
	MOVWF       FARG_print_sprite+1 
	MOVF        R2, 0 
	MOVWF       FARG_print_sprite+2 
	MOVF        FARG_printCoordinate_x+0, 0 
	MOVWF       FARG_print_column+0 
	MOVF        FARG_printCoordinate_y+0, 0 
	MOVWF       FARG_print_line+0 
	CALL        _print+0, 0
;compy.c,106 :: 		}
	RETURN      0
; end of _printCoordinate

_InitTimer2:

;compy.c,127 :: 		void InitTimer2(){
;compy.c,128 :: 		T2CON         = 0x3C;
	MOVLW       60
	MOVWF       T2CON+0 
;compy.c,129 :: 		TMR2IE_bit         = 1;
	BSF         TMR2IE_bit+0, 1 
;compy.c,130 :: 		PR2                 = 249;
	MOVLW       249
	MOVWF       PR2+0 
;compy.c,131 :: 		INTCON         = 0xD0;  //INTCON = 1100 0000 (HABILITA TMR2 INTERRUPT E INT0 INTERRUPT)
	MOVLW       208
	MOVWF       INTCON+0 
;compy.c,132 :: 		}
	RETURN      0
; end of _InitTimer2

_external_interrupt:

;compy.c,134 :: 		void external_interrupt() {
;compy.c,135 :: 		PORTA.F2 = ~PORTA.F2;
	BTG         PORTA+0, 2 
;compy.c,136 :: 		}
	RETURN      0
; end of _external_interrupt

_move_ghost:

;compy.c,140 :: 		void move_ghost() {
;compy.c,141 :: 		new_ghost_y = ghost_y;
	MOVF        _ghost_y+0, 0 
	MOVWF       _new_ghost_y+0 
	MOVF        _ghost_y+1, 0 
	MOVWF       _new_ghost_y+1 
;compy.c,142 :: 		new_ghost_x = ghost_x;
	MOVF        _ghost_x+0, 0 
	MOVWF       _new_ghost_x+0 
	MOVF        _ghost_x+1, 0 
	MOVWF       _new_ghost_x+1 
;compy.c,143 :: 		if (pacman_y > ghost_y) {
	MOVLW       128
	XORWF       _ghost_y+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _pacman_y+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ghost139
	MOVF        _pacman_y+0, 0 
	SUBWF       _ghost_y+0, 0 
L__move_ghost139:
	BTFSC       STATUS+0, 0 
	GOTO        L_move_ghost13
;compy.c,144 :: 		new_ghost_y = (ghost_y + 1);
	MOVLW       1
	ADDWF       _ghost_y+0, 0 
	MOVWF       _new_ghost_y+0 
	MOVLW       0
	ADDWFC      _ghost_y+1, 0 
	MOVWF       _new_ghost_y+1 
;compy.c,145 :: 		} else if (pacman_y < ghost_y) {
	GOTO        L_move_ghost14
L_move_ghost13:
	MOVLW       128
	XORWF       _pacman_y+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _ghost_y+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ghost140
	MOVF        _ghost_y+0, 0 
	SUBWF       _pacman_y+0, 0 
L__move_ghost140:
	BTFSC       STATUS+0, 0 
	GOTO        L_move_ghost15
;compy.c,146 :: 		new_ghost_y = (ghost_y - 1);
	MOVLW       1
	SUBWF       _ghost_y+0, 0 
	MOVWF       _new_ghost_y+0 
	MOVLW       0
	SUBWFB      _ghost_y+1, 0 
	MOVWF       _new_ghost_y+1 
;compy.c,147 :: 		} else {
	GOTO        L_move_ghost16
L_move_ghost15:
;compy.c,148 :: 		if (pacman_x > ghost_x) {
	MOVLW       128
	XORWF       _ghost_x+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _pacman_x+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ghost141
	MOVF        _pacman_x+0, 0 
	SUBWF       _ghost_x+0, 0 
L__move_ghost141:
	BTFSC       STATUS+0, 0 
	GOTO        L_move_ghost17
;compy.c,149 :: 		new_ghost_x = (ghost_x + 1);
	MOVLW       1
	ADDWF       _ghost_x+0, 0 
	MOVWF       _new_ghost_x+0 
	MOVLW       0
	ADDWFC      _ghost_x+1, 0 
	MOVWF       _new_ghost_x+1 
;compy.c,151 :: 		} else if (pacman_x < ghost_x) {
	GOTO        L_move_ghost18
L_move_ghost17:
	MOVLW       128
	XORWF       _pacman_x+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _ghost_x+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ghost142
	MOVF        _ghost_x+0, 0 
	SUBWF       _pacman_x+0, 0 
L__move_ghost142:
	BTFSC       STATUS+0, 0 
	GOTO        L_move_ghost19
;compy.c,152 :: 		new_ghost_x = (ghost_x - 1);
	MOVLW       1
	SUBWF       _ghost_x+0, 0 
	MOVWF       _new_ghost_x+0 
	MOVLW       0
	SUBWFB      _ghost_x+1, 0 
	MOVWF       _new_ghost_x+1 
;compy.c,153 :: 		}
L_move_ghost19:
L_move_ghost18:
;compy.c,154 :: 		}
L_move_ghost16:
L_move_ghost14:
;compy.c,155 :: 		if (world[new_ghost_x][new_ghost_x] == barrier_orientation) {
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
	GOTO        L__move_ghost143
	MOVF        _barrier_orientation+0, 0 
	XORWF       R1, 0 
L__move_ghost143:
	BTFSS       STATUS+0, 2 
	GOTO        L_move_ghost20
;compy.c,156 :: 		new_ghost_x = new_ghost_x + 1;
	INFSNZ      _new_ghost_x+0, 1 
	INCF        _new_ghost_x+1, 1 
;compy.c,157 :: 		}
L_move_ghost20:
;compy.c,159 :: 		world[ghost_x][ghost_y] = old_ghost_obj != 0 ? old_ghost_obj : ' ';
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
	GOTO        L_move_ghost21
	MOVF        _old_ghost_obj+0, 0 
	MOVWF       R0 
	GOTO        L_move_ghost22
L_move_ghost21:
	MOVLW       32
	MOVWF       R0 
L_move_ghost22:
	MOVFF       R2, FSR1L
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;compy.c,160 :: 		printCoordinate(ghost_x, ghost_y);
	MOVF        _ghost_x+0, 0 
	MOVWF       FARG_printCoordinate_x+0 
	MOVF        _ghost_x+1, 0 
	MOVWF       FARG_printCoordinate_x+1 
	MOVF        _ghost_y+0, 0 
	MOVWF       FARG_printCoordinate_y+0 
	MOVF        _ghost_y+1, 0 
	MOVWF       FARG_printCoordinate_y+1 
	CALL        _printCoordinate+0, 0
;compy.c,163 :: 		old_ghost_obj = world[ghost_x][ghost_x] != ghost_orientation ? world[new_ghost_x][new_ghost_y] : ' ';
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
	GOTO        L__move_ghost144
	MOVF        _ghost_orientation+0, 0 
	XORWF       R1, 0 
L__move_ghost144:
	BTFSC       STATUS+0, 2 
	GOTO        L_move_ghost23
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
	GOTO        L_move_ghost24
L_move_ghost23:
	MOVLW       32
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
L_move_ghost24:
	MOVF        R0, 0 
	MOVWF       _old_ghost_obj+0 
;compy.c,164 :: 		world[new_ghost_x][new_ghost_y] = ghost_orientation;
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
;compy.c,165 :: 		printCoordinate(new_ghost_x, new_ghost_y);
	MOVF        _new_ghost_x+0, 0 
	MOVWF       FARG_printCoordinate_x+0 
	MOVF        _new_ghost_x+1, 0 
	MOVWF       FARG_printCoordinate_x+1 
	MOVF        _new_ghost_y+0, 0 
	MOVWF       FARG_printCoordinate_y+0 
	MOVF        _new_ghost_y+1, 0 
	MOVWF       FARG_printCoordinate_y+1 
	CALL        _printCoordinate+0, 0
;compy.c,167 :: 		ghost_y = new_ghost_y;
	MOVF        _new_ghost_y+0, 0 
	MOVWF       _ghost_y+0 
	MOVF        _new_ghost_y+1, 0 
	MOVWF       _ghost_y+1 
;compy.c,168 :: 		ghost_x = new_ghost_x;
	MOVF        _new_ghost_x+0, 0 
	MOVWF       _ghost_x+0 
	MOVF        _new_ghost_x+1, 0 
	MOVWF       _ghost_x+1 
;compy.c,169 :: 		}
	RETURN      0
; end of _move_ghost

_interrupt:

;compy.c,172 :: 		void interrupt() {
;compy.c,173 :: 		if(int0if_bit)
	BTFSS       INT0IF_bit+0, 1 
	GOTO        L_interrupt25
;compy.c,175 :: 		cnt2++;
	INFSNZ      _cnt2+0, 1 
	INCF        _cnt2+1, 1 
;compy.c,176 :: 		if (cnt2 > 180) {
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _cnt2+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt146
	MOVF        _cnt2+0, 0 
	SUBLW       180
L__interrupt146:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt26
;compy.c,177 :: 		IS_FINISH = 1;
	MOVLW       1
	MOVWF       _IS_FINISH+0 
	MOVLW       0
	MOVWF       _IS_FINISH+1 
;compy.c,178 :: 		IS_GAME_OVER = 1;
	MOVLW       1
	MOVWF       _IS_GAME_OVER+0 
	MOVLW       0
	MOVWF       _IS_GAME_OVER+1 
;compy.c,179 :: 		}
L_interrupt26:
;compy.c,180 :: 		int0if_bit = 0;   // clear int0if_bit
	BCF         INT0IF_bit+0, 1 
;compy.c,181 :: 		}
L_interrupt25:
;compy.c,183 :: 		if (TMR2IF_bit) {
	BTFSS       TMR2IF_bit+0, 1 
	GOTO        L_interrupt27
;compy.c,184 :: 		cnt++;
	INFSNZ      _cnt+0, 1 
	INCF        _cnt+1, 1 
;compy.c,185 :: 		if (cnt >= 1000) {
	MOVLW       128
	XORWF       _cnt+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt147
	MOVLW       232
	SUBWF       _cnt+0, 0 
L__interrupt147:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt28
;compy.c,186 :: 		PORTA.F1 = ~PORTA.F1;
	BTG         PORTA+0, 1 
;compy.c,187 :: 		cnt = 0;
	CLRF        _cnt+0 
	CLRF        _cnt+1 
;compy.c,188 :: 		move_ghost_bool = 1;
	MOVLW       1
	MOVWF       _move_ghost_bool+0 
	MOVLW       0
	MOVWF       _move_ghost_bool+1 
;compy.c,189 :: 		}
L_interrupt28:
;compy.c,190 :: 		TMR2IF_bit = 0;        // clear TMR2IF
	BCF         TMR2IF_bit+0, 1 
;compy.c,191 :: 		}
L_interrupt27:
;compy.c,192 :: 		}
L__interrupt145:
	RETFIE      1
; end of _interrupt

_Le_Teclado:

;compy.c,194 :: 		char Le_Teclado()
;compy.c,196 :: 		PORTD = 0B00010000; // VOCÃŠ SELECIONOU LA
	MOVLW       16
	MOVWF       PORTD+0 
;compy.c,197 :: 		if (PORTA.RA5 == 1) {
	BTFSS       PORTA+0, 5 
	GOTO        L_Le_Teclado29
;compy.c,198 :: 		while(PORTA.RA5 == 1);
L_Le_Teclado30:
	BTFSS       PORTA+0, 5 
	GOTO        L_Le_Teclado31
	GOTO        L_Le_Teclado30
L_Le_Teclado31:
;compy.c,199 :: 		return '7';
	MOVLW       55
	MOVWF       R0 
	RETURN      0
;compy.c,200 :: 		}
L_Le_Teclado29:
;compy.c,201 :: 		if (PORTB.RB1 == 1) {
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado32
;compy.c,202 :: 		while(PORTB.RB1 == 1);
L_Le_Teclado33:
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado34
	GOTO        L_Le_Teclado33
L_Le_Teclado34:
;compy.c,203 :: 		return '8';
	MOVLW       56
	MOVWF       R0 
	RETURN      0
;compy.c,204 :: 		}
L_Le_Teclado32:
;compy.c,205 :: 		if (PORTB.RB2 == 1) {
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado35
;compy.c,206 :: 		while(PORTB.RB2 == 1);
L_Le_Teclado36:
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado37
	GOTO        L_Le_Teclado36
L_Le_Teclado37:
;compy.c,207 :: 		return '9';
	MOVLW       57
	MOVWF       R0 
	RETURN      0
;compy.c,208 :: 		}
L_Le_Teclado35:
;compy.c,209 :: 		if (PORTB.RB3 == 1) {
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado38
;compy.c,210 :: 		while(PORTB.RB3 == 1);
L_Le_Teclado39:
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado40
	GOTO        L_Le_Teclado39
L_Le_Teclado40:
;compy.c,211 :: 		return '%';
	MOVLW       37
	MOVWF       R0 
	RETURN      0
;compy.c,212 :: 		}
L_Le_Teclado38:
;compy.c,214 :: 		PORTD = 0B00100000; // VOCÃŠ SELECIONOU LB
	MOVLW       32
	MOVWF       PORTD+0 
;compy.c,215 :: 		if (PORTA.RA5 == 1) {
	BTFSS       PORTA+0, 5 
	GOTO        L_Le_Teclado41
;compy.c,216 :: 		while(PORTA.RA5 == 1);
L_Le_Teclado42:
	BTFSS       PORTA+0, 5 
	GOTO        L_Le_Teclado43
	GOTO        L_Le_Teclado42
L_Le_Teclado43:
;compy.c,217 :: 		return '4';
	MOVLW       52
	MOVWF       R0 
	RETURN      0
;compy.c,218 :: 		}
L_Le_Teclado41:
;compy.c,219 :: 		if (PORTB.RB1 == 1) {
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado44
;compy.c,220 :: 		while(PORTB.RB1 == 1);
L_Le_Teclado45:
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado46
	GOTO        L_Le_Teclado45
L_Le_Teclado46:
;compy.c,221 :: 		return '5';
	MOVLW       53
	MOVWF       R0 
	RETURN      0
;compy.c,222 :: 		}
L_Le_Teclado44:
;compy.c,223 :: 		if (PORTB.RB2 == 1) {
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado47
;compy.c,224 :: 		while(PORTB.RB2 == 1);
L_Le_Teclado48:
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado49
	GOTO        L_Le_Teclado48
L_Le_Teclado49:
;compy.c,225 :: 		return '6';
	MOVLW       54
	MOVWF       R0 
	RETURN      0
;compy.c,226 :: 		}
L_Le_Teclado47:
;compy.c,227 :: 		if (PORTB.RB3 == 1) {
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado50
;compy.c,228 :: 		while(PORTB.RB3 == 1);
L_Le_Teclado51:
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado52
	GOTO        L_Le_Teclado51
L_Le_Teclado52:
;compy.c,229 :: 		return '*';
	MOVLW       42
	MOVWF       R0 
	RETURN      0
;compy.c,230 :: 		}
L_Le_Teclado50:
;compy.c,232 :: 		PORTD = 0B01000000; // VOCÃŠ SELECIONOU LC
	MOVLW       64
	MOVWF       PORTD+0 
;compy.c,233 :: 		if (PORTA.RA5 == 1) {
	BTFSS       PORTA+0, 5 
	GOTO        L_Le_Teclado53
;compy.c,234 :: 		while(PORTA.RA5 == 1);
L_Le_Teclado54:
	BTFSS       PORTA+0, 5 
	GOTO        L_Le_Teclado55
	GOTO        L_Le_Teclado54
L_Le_Teclado55:
;compy.c,235 :: 		return '1';
	MOVLW       49
	MOVWF       R0 
	RETURN      0
;compy.c,236 :: 		}
L_Le_Teclado53:
;compy.c,237 :: 		if (PORTB.RB1 == 1) {
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado56
;compy.c,238 :: 		while(PORTB.RB1 == 1);
L_Le_Teclado57:
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado58
	GOTO        L_Le_Teclado57
L_Le_Teclado58:
;compy.c,239 :: 		return '2';
	MOVLW       50
	MOVWF       R0 
	RETURN      0
;compy.c,240 :: 		}
L_Le_Teclado56:
;compy.c,241 :: 		if (PORTB.RB2 == 1) {
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado59
;compy.c,242 :: 		while(PORTB.RB2 == 1);
L_Le_Teclado60:
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado61
	GOTO        L_Le_Teclado60
L_Le_Teclado61:
;compy.c,243 :: 		return '3';
	MOVLW       51
	MOVWF       R0 
	RETURN      0
;compy.c,244 :: 		}
L_Le_Teclado59:
;compy.c,245 :: 		if (PORTB.RB3 == 1) {
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado62
;compy.c,246 :: 		while(PORTB.RB3 == 1);
L_Le_Teclado63:
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado64
	GOTO        L_Le_Teclado63
L_Le_Teclado64:
;compy.c,247 :: 		return '-';
	MOVLW       45
	MOVWF       R0 
	RETURN      0
;compy.c,248 :: 		}
L_Le_Teclado62:
;compy.c,250 :: 		PORTD = 0B10000000; // VOCÃŠ SELECIONOU LD
	MOVLW       128
	MOVWF       PORTD+0 
;compy.c,251 :: 		if (PORTA.RA5 == 1) {
	BTFSS       PORTA+0, 5 
	GOTO        L_Le_Teclado65
;compy.c,252 :: 		while(PORTA.RA5 == 1);
L_Le_Teclado66:
	BTFSS       PORTA+0, 5 
	GOTO        L_Le_Teclado67
	GOTO        L_Le_Teclado66
L_Le_Teclado67:
;compy.c,253 :: 		return 'C';
	MOVLW       67
	MOVWF       R0 
	RETURN      0
;compy.c,254 :: 		}
L_Le_Teclado65:
;compy.c,255 :: 		if (PORTB.RB1 == 1) {
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado68
;compy.c,256 :: 		while(PORTB.RB1 == 1);
L_Le_Teclado69:
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado70
	GOTO        L_Le_Teclado69
L_Le_Teclado70:
;compy.c,257 :: 		return '0';
	MOVLW       48
	MOVWF       R0 
	RETURN      0
;compy.c,258 :: 		}
L_Le_Teclado68:
;compy.c,259 :: 		if (PORTB.RB2 == 1) {
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado71
;compy.c,260 :: 		while(PORTB.RB2 == 1);
L_Le_Teclado72:
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado73
	GOTO        L_Le_Teclado72
L_Le_Teclado73:
;compy.c,261 :: 		return '=';
	MOVLW       61
	MOVWF       R0 
	RETURN      0
;compy.c,262 :: 		}
L_Le_Teclado71:
;compy.c,263 :: 		if (PORTB.RB3 == 1) {
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado74
;compy.c,264 :: 		while(PORTB.RB3 == 1);
L_Le_Teclado75:
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado76
	GOTO        L_Le_Teclado75
L_Le_Teclado76:
;compy.c,265 :: 		return '+';
	MOVLW       43
	MOVWF       R0 
	RETURN      0
;compy.c,266 :: 		}
L_Le_Teclado74:
;compy.c,268 :: 		return (char) 255;
	MOVLW       255
	MOVWF       R0 
;compy.c,269 :: 		}
	RETURN      0
; end of _Le_Teclado

_Pula_Linha:

;compy.c,271 :: 		void Pula_Linha(void)
;compy.c,273 :: 		UART1_WRITE(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;compy.c,274 :: 		UART1_WRITE(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;compy.c,275 :: 		}
	RETURN      0
; end of _Pula_Linha

_Move_Delay:

;compy.c,277 :: 		void Move_Delay() {                  // Function used for text moving
;compy.c,278 :: 		Delay_ms(100);                     // You can change the moving speed here
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_Move_Delay77:
	DECFSZ      R13, 1, 0
	BRA         L_Move_Delay77
	DECFSZ      R12, 1, 0
	BRA         L_Move_Delay77
	DECFSZ      R11, 1, 0
	BRA         L_Move_Delay77
	NOP
;compy.c,279 :: 		}
	RETURN      0
; end of _Move_Delay

_myrand:

;compy.c,284 :: 		int myrand(unsigned seed) {
;compy.c,285 :: 		next = seed;
	MOVF        FARG_myrand_seed+0, 0 
	MOVWF       _next+0 
	MOVF        FARG_myrand_seed+1, 0 
	MOVWF       _next+1 
	MOVLW       0
	MOVWF       _next+2 
	MOVWF       _next+3 
;compy.c,286 :: 		next = next * 1103515245 + 12345;
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
;compy.c,287 :: 		return((unsigned)(next/65536) % 32768);
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
;compy.c,288 :: 		}
	RETURN      0
; end of _myrand

_mysrand:

;compy.c,290 :: 		void mysrand(unsigned seed) {
;compy.c,291 :: 		next = seed;
	MOVF        FARG_mysrand_seed+0, 0 
	MOVWF       _next+0 
	MOVF        FARG_mysrand_seed+1, 0 
	MOVWF       _next+1 
	MOVLW       0
	MOVWF       _next+2 
	MOVWF       _next+3 
;compy.c,292 :: 		}
	RETURN      0
; end of _mysrand

_Read_RTC:

;compy.c,294 :: 		int Read_RTC(int END)
;compy.c,297 :: 		I2C1_Start();           // issue I2C start signal
	CALL        _I2C1_Start+0, 0
;compy.c,298 :: 		I2C1_Wr(0xD0);          // send byte via I2C  (device address + W)
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;compy.c,299 :: 		I2C1_Wr(END);             // send byte (data address)
	MOVF        FARG_Read_RTC_END+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;compy.c,300 :: 		I2C1_Repeated_Start();  // issue I2C signal repeated start
	CALL        _I2C1_Repeated_Start+0, 0
;compy.c,301 :: 		I2C1_Wr(0xD1);          // send byte (device address + R)
	MOVLW       209
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;compy.c,302 :: 		Dado = I2C1_Rd(0u);    // Read the data (NO acknowledge)
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       Read_RTC_Dado_L0+0 
	MOVLW       0
	MOVWF       Read_RTC_Dado_L0+1 
;compy.c,303 :: 		I2C1_Stop();            // issue I2C stop signal
	CALL        _I2C1_Stop+0, 0
;compy.c,304 :: 		return(Dado);
	MOVF        Read_RTC_Dado_L0+0, 0 
	MOVWF       R0 
	MOVF        Read_RTC_Dado_L0+1, 0 
	MOVWF       R1 
;compy.c,305 :: 		}
	RETURN      0
; end of _Read_RTC

_Print_World:

;compy.c,307 :: 		void Print_World() {
;compy.c,308 :: 		for(i = 0; i < 15; ++i) {
	CLRF        _i+0 
	CLRF        _i+1 
L_Print_World78:
	MOVLW       128
	XORWF       _i+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Print_World148
	MOVLW       15
	SUBWF       _i+0, 0 
L__Print_World148:
	BTFSC       STATUS+0, 0 
	GOTO        L_Print_World79
;compy.c,309 :: 		for(j = 0; j < 8; ++j)
	CLRF        _j+0 
	CLRF        _j+1 
L_Print_World81:
	MOVLW       128
	XORWF       _j+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Print_World149
	MOVLW       8
	SUBWF       _j+0, 0 
L__Print_World149:
	BTFSC       STATUS+0, 0 
	GOTO        L_Print_World82
;compy.c,311 :: 		printCoordinate(i, j);
	MOVF        _i+0, 0 
	MOVWF       FARG_printCoordinate_x+0 
	MOVF        _i+1, 0 
	MOVWF       FARG_printCoordinate_x+1 
	MOVF        _j+0, 0 
	MOVWF       FARG_printCoordinate_y+0 
	MOVF        _j+1, 0 
	MOVWF       FARG_printCoordinate_y+1 
	CALL        _printCoordinate+0, 0
;compy.c,309 :: 		for(j = 0; j < 8; ++j)
	INFSNZ      _j+0, 1 
	INCF        _j+1, 1 
;compy.c,312 :: 		}
	GOTO        L_Print_World81
L_Print_World82:
;compy.c,308 :: 		for(i = 0; i < 15; ++i) {
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;compy.c,313 :: 		}
	GOTO        L_Print_World78
L_Print_World79:
;compy.c,314 :: 		}
	RETURN      0
; end of _Print_World

_Create_World:

;compy.c,318 :: 		void Create_World() {
;compy.c,319 :: 		for(i = 0; i < 15; ++i) {
	CLRF        _i+0 
	CLRF        _i+1 
L_Create_World84:
	MOVLW       128
	XORWF       _i+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Create_World150
	MOVLW       15
	SUBWF       _i+0, 0 
L__Create_World150:
	BTFSC       STATUS+0, 0 
	GOTO        L_Create_World85
;compy.c,320 :: 		for(j = 0; j < 8 ; ++j)
	CLRF        _j+0 
	CLRF        _j+1 
L_Create_World87:
	MOVLW       128
	XORWF       _j+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Create_World151
	MOVLW       8
	SUBWF       _j+0, 0 
L__Create_World151:
	BTFSC       STATUS+0, 0 
	GOTO        L_Create_World88
;compy.c,322 :: 		world[i][j] = ' ';
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
;compy.c,320 :: 		for(j = 0; j < 8 ; ++j)
	INFSNZ      _j+0, 1 
	INCF        _j+1, 1 
;compy.c,323 :: 		}
	GOTO        L_Create_World87
L_Create_World88:
;compy.c,319 :: 		for(i = 0; i < 15; ++i) {
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;compy.c,324 :: 		}
	GOTO        L_Create_World84
L_Create_World85:
;compy.c,326 :: 		world[4][myrand(rands * 5) & 0b000000000000000111] = barrier_orientation;
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
;compy.c,327 :: 		world[myrand(rands * 1) & 0b000000000000000111][myrand(rands * 1) & 0b000000000000000111] = barrier_orientation;
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
;compy.c,328 :: 		world[myrand(rands * 26) & 0b000000000000000111][myrand(rands * 50) & 0b000000000000000111] = barrier_orientation;
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
;compy.c,329 :: 		world[myrand(rands * 76) & 0b000000000000000111][myrand(rands * 985) & 0b000000000000000111] = barrier_orientation;
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
;compy.c,331 :: 		world[myrand(rands * 500)& 0b000000000000000111][myrand(rands * 12)& 0b000000000000000111] = food_orientation;
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
;compy.c,332 :: 		world[myrand(rands * 1)& 0b000000000000000111][myrand(rands * 85)& 0b000000000000000111] = food_orientation;
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
;compy.c,333 :: 		world[myrand(rands * 63)& 0b000000000000000111][myrand(rands * 552)& 0b000000000000000111] = food_orientation;
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
;compy.c,335 :: 		world[11][5] = food_orientation;
	MOVF        _food_orientation+0, 0 
	MOVWF       _world+340 
	MOVLW       0
	MOVWF       _world+341 
;compy.c,336 :: 		world[5][3] = food_orientation;
	MOVF        _food_orientation+0, 0 
	MOVWF       _world+156 
	MOVLW       0
	MOVWF       _world+157 
;compy.c,337 :: 		world[8][2] = food_orientation;
	MOVF        _food_orientation+0, 0 
	MOVWF       _world+244 
	MOVLW       0
	MOVWF       _world+245 
;compy.c,338 :: 		world[7][7] = food_orientation;
	MOVF        _food_orientation+0, 0 
	MOVWF       _world+224 
	MOVLW       0
	MOVWF       _world+225 
;compy.c,340 :: 		if (world[ghost_x][ghost_y] == food_orientation) {
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
	GOTO        L__Create_World152
	MOVF        _food_orientation+0, 0 
	XORWF       R1, 0 
L__Create_World152:
	BTFSS       STATUS+0, 2 
	GOTO        L_Create_World90
;compy.c,341 :: 		--QTD_FOOD;
	MOVLW       1
	SUBWF       _QTD_FOOD+0, 1 
	MOVLW       0
	SUBWFB      _QTD_FOOD+1, 1 
;compy.c,342 :: 		}
L_Create_World90:
;compy.c,343 :: 		if (world[pacman_x][pacman_y] == food_orientation){
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
	GOTO        L__Create_World153
	MOVF        _food_orientation+0, 0 
	XORWF       R1, 0 
L__Create_World153:
	BTFSS       STATUS+0, 2 
	GOTO        L_Create_World91
;compy.c,344 :: 		--QTD_FOOD;
	MOVLW       1
	SUBWF       _QTD_FOOD+0, 1 
	MOVLW       0
	SUBWFB      _QTD_FOOD+1, 1 
;compy.c,345 :: 		}
L_Create_World91:
;compy.c,346 :: 		world[ghost_x][ghost_y] = ghost_orientation;
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
;compy.c,347 :: 		world[pacman_x][pacman_y] = (char) pacman_orientation;
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
;compy.c,349 :: 		Print_World();
	CALL        _Print_World+0, 0
;compy.c,350 :: 		}
	RETURN      0
; end of _Create_World

_update_pacman_orientation:

;compy.c,352 :: 		char update_pacman_orientation(int newX, int newY) {
;compy.c,353 :: 		if (newX > pacman_x) {
	MOVLW       128
	XORWF       _pacman_x+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_update_pacman_orientation_newX+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman_orientation154
	MOVF        FARG_update_pacman_orientation_newX+0, 0 
	SUBWF       _pacman_x+0, 0 
L__update_pacman_orientation154:
	BTFSC       STATUS+0, 0 
	GOTO        L_update_pacman_orientation92
;compy.c,354 :: 		return (char) 1;
	MOVLW       1
	MOVWF       R0 
	RETURN      0
;compy.c,355 :: 		} else if (newX < pacman_x) {
L_update_pacman_orientation92:
	MOVLW       128
	XORWF       FARG_update_pacman_orientation_newX+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _pacman_x+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman_orientation155
	MOVF        _pacman_x+0, 0 
	SUBWF       FARG_update_pacman_orientation_newX+0, 0 
L__update_pacman_orientation155:
	BTFSC       STATUS+0, 0 
	GOTO        L_update_pacman_orientation94
;compy.c,356 :: 		return (char) 3;
	MOVLW       3
	MOVWF       R0 
	RETURN      0
;compy.c,357 :: 		} else if (newY > pacman_y) {
L_update_pacman_orientation94:
	MOVLW       128
	XORWF       _pacman_y+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_update_pacman_orientation_newY+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman_orientation156
	MOVF        FARG_update_pacman_orientation_newY+0, 0 
	SUBWF       _pacman_y+0, 0 
L__update_pacman_orientation156:
	BTFSC       STATUS+0, 0 
	GOTO        L_update_pacman_orientation96
;compy.c,358 :: 		return (char) 2;
	MOVLW       2
	MOVWF       R0 
	RETURN      0
;compy.c,359 :: 		} else if (newY < pacman_y) {
L_update_pacman_orientation96:
	MOVLW       128
	XORWF       FARG_update_pacman_orientation_newY+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _pacman_y+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman_orientation157
	MOVF        _pacman_y+0, 0 
	SUBWF       FARG_update_pacman_orientation_newY+0, 0 
L__update_pacman_orientation157:
	BTFSC       STATUS+0, 0 
	GOTO        L_update_pacman_orientation98
;compy.c,360 :: 		return 0;
	CLRF        R0 
	RETURN      0
;compy.c,361 :: 		}
L_update_pacman_orientation98:
;compy.c,362 :: 		return pacman_orientation;
	MOVF        _pacman_orientation+0, 0 
	MOVWF       R0 
;compy.c,363 :: 		}
	RETURN      0
; end of _update_pacman_orientation

_update_pacman:

;compy.c,368 :: 		void update_pacman(short direction) {
;compy.c,369 :: 		if (direction == 0) {
	MOVF        FARG_update_pacman_direction+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_update_pacman99
;compy.c,370 :: 		newPacman_x = pacman_x;
	MOVF        _pacman_x+0, 0 
	MOVWF       _newPacman_x+0 
	MOVF        _pacman_x+1, 0 
	MOVWF       _newPacman_x+1 
;compy.c,371 :: 		newPacman_y = pacman_y - 1;
	MOVLW       1
	SUBWF       _pacman_y+0, 0 
	MOVWF       _newPacman_y+0 
	MOVLW       0
	SUBWFB      _pacman_y+1, 0 
	MOVWF       _newPacman_y+1 
;compy.c,372 :: 		} else if (direction == 1) {
	GOTO        L_update_pacman100
L_update_pacman99:
	MOVF        FARG_update_pacman_direction+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_update_pacman101
;compy.c,373 :: 		newPacman_x = pacman_x + 1;
	MOVLW       1
	ADDWF       _pacman_x+0, 0 
	MOVWF       _newPacman_x+0 
	MOVLW       0
	ADDWFC      _pacman_x+1, 0 
	MOVWF       _newPacman_x+1 
;compy.c,374 :: 		newPacman_y = pacman_y;
	MOVF        _pacman_y+0, 0 
	MOVWF       _newPacman_y+0 
	MOVF        _pacman_y+1, 0 
	MOVWF       _newPacman_y+1 
;compy.c,375 :: 		} else if (direction == 2) {
	GOTO        L_update_pacman102
L_update_pacman101:
	MOVF        FARG_update_pacman_direction+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_update_pacman103
;compy.c,376 :: 		newPacman_x = pacman_x;
	MOVF        _pacman_x+0, 0 
	MOVWF       _newPacman_x+0 
	MOVF        _pacman_x+1, 0 
	MOVWF       _newPacman_x+1 
;compy.c,377 :: 		newPacman_y = pacman_y + 1;
	MOVLW       1
	ADDWF       _pacman_y+0, 0 
	MOVWF       _newPacman_y+0 
	MOVLW       0
	ADDWFC      _pacman_y+1, 0 
	MOVWF       _newPacman_y+1 
;compy.c,378 :: 		} else if (direction == 3) {
	GOTO        L_update_pacman104
L_update_pacman103:
	MOVF        FARG_update_pacman_direction+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_update_pacman105
;compy.c,379 :: 		newPacman_x = pacman_x - 1;
	MOVLW       1
	SUBWF       _pacman_x+0, 0 
	MOVWF       _newPacman_x+0 
	MOVLW       0
	SUBWFB      _pacman_x+1, 0 
	MOVWF       _newPacman_x+1 
;compy.c,380 :: 		newPacman_y = pacman_y;
	MOVF        _pacman_y+0, 0 
	MOVWF       _newPacman_y+0 
	MOVF        _pacman_y+1, 0 
	MOVWF       _newPacman_y+1 
;compy.c,381 :: 		}
L_update_pacman105:
L_update_pacman104:
L_update_pacman102:
L_update_pacman100:
;compy.c,383 :: 		newPacmanOrientation = update_pacman_orientation(newPacman_x, newPacman_y);
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
;compy.c,385 :: 		if (newPacman_x < 0) newPacman_x = 14;
	MOVLW       128
	XORWF       _newPacman_x+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman158
	MOVLW       0
	SUBWF       _newPacman_x+0, 0 
L__update_pacman158:
	BTFSC       STATUS+0, 0 
	GOTO        L_update_pacman106
	MOVLW       14
	MOVWF       _newPacman_x+0 
	MOVLW       0
	MOVWF       _newPacman_x+1 
L_update_pacman106:
;compy.c,386 :: 		if (newPacman_x > 14) newPacman_x = 0;
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _newPacman_x+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman159
	MOVF        _newPacman_x+0, 0 
	SUBLW       14
L__update_pacman159:
	BTFSC       STATUS+0, 0 
	GOTO        L_update_pacman107
	CLRF        _newPacman_x+0 
	CLRF        _newPacman_x+1 
L_update_pacman107:
;compy.c,388 :: 		if (newPacman_y < 0) newPacman_y = 7;
	MOVLW       128
	XORWF       _newPacman_y+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman160
	MOVLW       0
	SUBWF       _newPacman_y+0, 0 
L__update_pacman160:
	BTFSC       STATUS+0, 0 
	GOTO        L_update_pacman108
	MOVLW       7
	MOVWF       _newPacman_y+0 
	MOVLW       0
	MOVWF       _newPacman_y+1 
L_update_pacman108:
;compy.c,389 :: 		if (newPacman_y > 7) newPacman_y = 0;
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _newPacman_y+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman161
	MOVF        _newPacman_y+0, 0 
	SUBLW       7
L__update_pacman161:
	BTFSC       STATUS+0, 0 
	GOTO        L_update_pacman109
	CLRF        _newPacman_y+0 
	CLRF        _newPacman_y+1 
L_update_pacman109:
;compy.c,391 :: 		if (QTD_FOOD == 0) {
	MOVLW       0
	XORWF       _QTD_FOOD+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman162
	MOVLW       0
	XORWF       _QTD_FOOD+0, 0 
L__update_pacman162:
	BTFSS       STATUS+0, 2 
	GOTO        L_update_pacman110
;compy.c,392 :: 		IS_FINISH = 1;
	MOVLW       1
	MOVWF       _IS_FINISH+0 
	MOVLW       0
	MOVWF       _IS_FINISH+1 
;compy.c,393 :: 		IS_GAME_OVER = 0;
	CLRF        _IS_GAME_OVER+0 
	CLRF        _IS_GAME_OVER+1 
;compy.c,394 :: 		}
L_update_pacman110:
;compy.c,396 :: 		if (world[newPacman_x][newPacman_y] != barrier_orientation) {
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
	GOTO        L__update_pacman163
	MOVF        _barrier_orientation+0, 0 
	XORWF       R1, 0 
L__update_pacman163:
	BTFSC       STATUS+0, 2 
	GOTO        L_update_pacman111
;compy.c,397 :: 		if (world[newPacman_x][newPacman_y] == food_orientation) {
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
	GOTO        L__update_pacman164
	MOVF        _food_orientation+0, 0 
	XORWF       R1, 0 
L__update_pacman164:
	BTFSS       STATUS+0, 2 
	GOTO        L_update_pacman112
;compy.c,398 :: 		QTD_FOOD--;
	MOVLW       1
	SUBWF       _QTD_FOOD+0, 1 
	MOVLW       0
	SUBWFB      _QTD_FOOD+1, 1 
;compy.c,399 :: 		}
L_update_pacman112:
;compy.c,401 :: 		pacman_orientation = newPacmanOrientation;
	MOVF        _newPacmanOrientation+0, 0 
	MOVWF       _pacman_orientation+0 
;compy.c,403 :: 		world[pacman_x][pacman_y] = ' ';
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
;compy.c,404 :: 		printCoordinate(pacman_x, pacman_y);
	MOVF        _pacman_x+0, 0 
	MOVWF       FARG_printCoordinate_x+0 
	MOVF        _pacman_x+1, 0 
	MOVWF       FARG_printCoordinate_x+1 
	MOVF        _pacman_y+0, 0 
	MOVWF       FARG_printCoordinate_y+0 
	MOVF        _pacman_y+1, 0 
	MOVWF       FARG_printCoordinate_y+1 
	CALL        _printCoordinate+0, 0
;compy.c,406 :: 		world[newPacman_x][newPacman_y] = pacman_orientation;
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
;compy.c,407 :: 		printCoordinate(newPacman_x, newPacman_y);
	MOVF        _newPacman_x+0, 0 
	MOVWF       FARG_printCoordinate_x+0 
	MOVF        _newPacman_x+1, 0 
	MOVWF       FARG_printCoordinate_x+1 
	MOVF        _newPacman_y+0, 0 
	MOVWF       FARG_printCoordinate_y+0 
	MOVF        _newPacman_y+1, 0 
	MOVWF       FARG_printCoordinate_y+1 
	CALL        _printCoordinate+0, 0
;compy.c,409 :: 		pacman_x = newPacman_x;
	MOVF        _newPacman_x+0, 0 
	MOVWF       _pacman_x+0 
	MOVF        _newPacman_x+1, 0 
	MOVWF       _pacman_x+1 
;compy.c,410 :: 		pacman_y = newPacman_y;
	MOVF        _newPacman_y+0, 0 
	MOVWF       _pacman_y+0 
	MOVF        _newPacman_y+1, 0 
	MOVWF       _pacman_y+1 
;compy.c,411 :: 		}
L_update_pacman111:
;compy.c,412 :: 		}
	RETURN      0
; end of _update_pacman

_Write_EEPROM:

;compy.c,414 :: 		void Write_EEPROM(int END, int DADO)
;compy.c,416 :: 		I2C1_Start();           // issue I2C start signal
	CALL        _I2C1_Start+0, 0
;compy.c,417 :: 		I2C1_Wr(0xA0);          // send byte via I2C  (device address + W)
	MOVLW       160
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;compy.c,418 :: 		I2C1_Wr(END);             // send byte (address of EEPROM location)
	MOVF        FARG_Write_EEPROM_END+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;compy.c,419 :: 		I2C1_Wr(DADO);          // send data (data to be written)
	MOVF        FARG_Write_EEPROM_DADO+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;compy.c,420 :: 		I2C1_Stop();            // issue I2C stop signal
	CALL        _I2C1_Stop+0, 0
;compy.c,421 :: 		delay_ms(10);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_Write_EEPROM113:
	DECFSZ      R13, 1, 0
	BRA         L_Write_EEPROM113
	DECFSZ      R12, 1, 0
	BRA         L_Write_EEPROM113
	NOP
;compy.c,422 :: 		}
	RETURN      0
; end of _Write_EEPROM

_Write_EEPROM_Int:

;compy.c,424 :: 		void Write_EEPROM_Int(int END, int dado) {
;compy.c,425 :: 		Write_EEPROM(END, dado / 256);
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
;compy.c,426 :: 		Write_EEPROM(END + 1, dado % 256);
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
;compy.c,427 :: 		}
	RETURN      0
; end of _Write_EEPROM_Int

_Read_EEPROM:

;compy.c,429 :: 		int Read_EEPROM(int END)
;compy.c,432 :: 		I2C1_Start();           // issue I2C start signal
	CALL        _I2C1_Start+0, 0
;compy.c,433 :: 		I2C1_Wr(0xA0);          // send byte via I2C  (device address + W)
	MOVLW       160
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;compy.c,434 :: 		I2C1_Wr(END);             // send byte (data address)
	MOVF        FARG_Read_EEPROM_END+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;compy.c,435 :: 		I2C1_Repeated_Start();  // issue I2C signal repeated start
	CALL        _I2C1_Repeated_Start+0, 0
;compy.c,436 :: 		I2C1_Wr(0xA1);          // send byte (device address + R)
	MOVLW       161
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;compy.c,437 :: 		Dado = I2C1_Rd(0u);    // Read the data (NO acknowledge)
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       Read_EEPROM_Dado_L0+0 
	MOVLW       0
	MOVWF       Read_EEPROM_Dado_L0+1 
;compy.c,438 :: 		I2C1_Stop();            // issue I2C stop signal
	CALL        _I2C1_Stop+0, 0
;compy.c,439 :: 		return(Dado);
	MOVF        Read_EEPROM_Dado_L0+0, 0 
	MOVWF       R0 
	MOVF        Read_EEPROM_Dado_L0+1, 0 
	MOVWF       R1 
;compy.c,440 :: 		}
	RETURN      0
; end of _Read_EEPROM

_Read_EEPROM_Int:

;compy.c,444 :: 		int Read_EEPROM_Int(int END) {
;compy.c,445 :: 		byte_1 = Read_EEPROM(END);
	MOVF        FARG_Read_EEPROM_Int_END+0, 0 
	MOVWF       FARG_Read_EEPROM_END+0 
	MOVF        FARG_Read_EEPROM_Int_END+1, 0 
	MOVWF       FARG_Read_EEPROM_END+1 
	CALL        _Read_EEPROM+0, 0
	MOVF        R0, 0 
	MOVWF       _byte_1+0 
;compy.c,446 :: 		byte_2 = Read_EEPROM(END + 1);
	MOVLW       1
	ADDWF       FARG_Read_EEPROM_Int_END+0, 0 
	MOVWF       FARG_Read_EEPROM_END+0 
	MOVLW       0
	ADDWFC      FARG_Read_EEPROM_Int_END+1, 0 
	MOVWF       FARG_Read_EEPROM_END+1 
	CALL        _Read_EEPROM+0, 0
	MOVF        R0, 0 
	MOVWF       _byte_2+0 
;compy.c,448 :: 		return (byte_1 * 256) + byte_2;
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
;compy.c,449 :: 		}
	RETURN      0
; end of _Read_EEPROM_Int

_Transform_Time:

;compy.c,453 :: 		void Transform_Time(char *sec, char *min, char *hr) {
;compy.c,454 :: 		*sec = ((*sec & 0xF0) >> 4)*10 + (*sec & 0x0F);
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
;compy.c,455 :: 		*min = ((*min & 0xF0) >> 4)*10 + (*min & 0x0F);
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
;compy.c,456 :: 		*hr = ((*hr & 0xF0) >> 4)*10 + (*hr & 0x0F);
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
;compy.c,457 :: 		}
	RETURN      0
; end of _Transform_Time

_Start_Screen:

;compy.c,463 :: 		void Start_Screen() {
;compy.c,464 :: 		print_text(1, 6, "PAC MAN");
	MOVLW       1
	MOVWF       FARG_print_text_column+0 
	MOVLW       6
	MOVWF       FARG_print_text_line+0 
	MOVLW       ?lstr1_compy+0
	MOVWF       FARG_print_text_text+0 
	MOVLW       hi_addr(?lstr1_compy+0)
	MOVWF       FARG_print_text_text+1 
	CALL        _print_text+0, 0
;compy.c,465 :: 		print_text(3, 1, "PRESSIONE UMA TECLA!");
	MOVLW       3
	MOVWF       FARG_print_text_column+0 
	MOVLW       1
	MOVWF       FARG_print_text_line+0 
	MOVLW       ?lstr2_compy+0
	MOVWF       FARG_print_text_text+0 
	MOVLW       hi_addr(?lstr2_compy+0)
	MOVWF       FARG_print_text_text+1 
	CALL        _print_text+0, 0
;compy.c,467 :: 		while (Le_Teclado() == 255);
L_Start_Screen114:
	CALL        _Le_Teclado+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_Start_Screen115
	GOTO        L_Start_Screen114
L_Start_Screen115:
;compy.c,468 :: 		}
	RETURN      0
; end of _Start_Screen

_Finish:

;compy.c,470 :: 		void Finish() {
;compy.c,471 :: 		for(i = 0; i < 15; ++i) {
	CLRF        _i+0 
	CLRF        _i+1 
L_Finish116:
	MOVLW       128
	XORWF       _i+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Finish165
	MOVLW       15
	SUBWF       _i+0, 0 
L__Finish165:
	BTFSC       STATUS+0, 0 
	GOTO        L_Finish117
;compy.c,472 :: 		for(j = 0; j < 8; ++j) {
	CLRF        _j+0 
	CLRF        _j+1 
L_Finish119:
	MOVLW       128
	XORWF       _j+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Finish166
	MOVLW       8
	SUBWF       _j+0, 0 
L__Finish166:
	BTFSC       STATUS+0, 0 
	GOTO        L_Finish120
;compy.c,473 :: 		world[i][j] = ' ';
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
;compy.c,472 :: 		for(j = 0; j < 8; ++j) {
	INFSNZ      _j+0, 1 
	INCF        _j+1, 1 
;compy.c,474 :: 		}
	GOTO        L_Finish119
L_Finish120:
;compy.c,471 :: 		for(i = 0; i < 15; ++i) {
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;compy.c,475 :: 		}
	GOTO        L_Finish116
L_Finish117:
;compy.c,476 :: 		Print_World();
	CALL        _Print_World+0, 0
;compy.c,477 :: 		if (IS_GAME_OVER) {
	MOVF        _IS_GAME_OVER+0, 0 
	IORWF       _IS_GAME_OVER+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Finish122
;compy.c,478 :: 		print_text(2, 1, "Game over");
	MOVLW       2
	MOVWF       FARG_print_text_column+0 
	MOVLW       1
	MOVWF       FARG_print_text_line+0 
	MOVLW       ?lstr3_compy+0
	MOVWF       FARG_print_text_text+0 
	MOVLW       hi_addr(?lstr3_compy+0)
	MOVWF       FARG_print_text_text+1 
	CALL        _print_text+0, 0
;compy.c,479 :: 		} else {
	GOTO        L_Finish123
L_Finish122:
;compy.c,480 :: 		print_text(2, 1, "Win");
	MOVLW       2
	MOVWF       FARG_print_text_column+0 
	MOVLW       1
	MOVWF       FARG_print_text_line+0 
	MOVLW       ?lstr4_compy+0
	MOVWF       FARG_print_text_text+0 
	MOVLW       hi_addr(?lstr4_compy+0)
	MOVWF       FARG_print_text_text+1 
	CALL        _print_text+0, 0
;compy.c,481 :: 		}
L_Finish123:
;compy.c,482 :: 		}
	RETURN      0
; end of _Finish

_main:

;compy.c,493 :: 		void main() {           // General purpose register
;compy.c,494 :: 		UART1_Init(19200);
	MOVLW       25
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;compy.c,495 :: 		I2C1_Init(100000);
	MOVLW       20
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;compy.c,496 :: 		ADCON1 = 0B00001110;
	MOVLW       14
	MOVWF       ADCON1+0 
;compy.c,497 :: 		TRISB = 0B00001111;
	MOVLW       15
	MOVWF       TRISB+0 
;compy.c,498 :: 		TRISA = 0B00100001;
	MOVLW       33
	MOVWF       TRISA+0 
;compy.c,501 :: 		TRISA3_bit = 1;               // Set RA3 as input
	BSF         TRISA3_bit+0, 3 
;compy.c,502 :: 		TRISA4_bit = 1;               // Set RA4 as input
	BSF         TRISA4_bit+0, 4 
;compy.c,506 :: 		T6963C_init(240, 128, 8);
	MOVLW       240
	MOVWF       FARG_T6963C_init_width+0 
	MOVLW       0
	MOVWF       FARG_T6963C_init_width+1 
	MOVLW       128
	MOVWF       FARG_T6963C_init_height+0 
	MOVLW       8
	MOVWF       FARG_T6963C_init_fntW+0 
	CALL        _T6963C_init+0, 0
;compy.c,511 :: 		T6963C_graphics(1);
	BSF         _T6963C_display+0, 3 
	MOVF        _T6963C_display+0, 0 
	MOVWF       FARG_T6963C_writeCommand_mydata+0 
	CALL        _T6963C_writeCommand+0, 0
;compy.c,512 :: 		T6963C_text(1);
	BSF         _T6963C_display+0, 2 
	MOVF        _T6963C_display+0, 0 
	MOVWF       FARG_T6963C_writeCommand_mydata+0 
	CALL        _T6963C_writeCommand+0, 0
;compy.c,514 :: 		InitTimer2();
	CALL        _InitTimer2+0, 0
;compy.c,517 :: 		Create_World();
	CALL        _Create_World+0, 0
;compy.c,519 :: 		while (1) {
L_main124:
;compy.c,520 :: 		if (IS_FINISH) {
	MOVF        _IS_FINISH+0, 0 
	IORWF       _IS_FINISH+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main126
;compy.c,521 :: 		break;
	GOTO        L_main125
;compy.c,522 :: 		}
L_main126:
;compy.c,524 :: 		if (pacman_x == ghost_x && pacman_y == ghost_y) {
	MOVF        _pacman_x+1, 0 
	XORWF       _ghost_x+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main167
	MOVF        _ghost_x+0, 0 
	XORWF       _pacman_x+0, 0 
L__main167:
	BTFSS       STATUS+0, 2 
	GOTO        L_main129
	MOVF        _pacman_y+1, 0 
	XORWF       _ghost_y+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main168
	MOVF        _ghost_y+0, 0 
	XORWF       _pacman_y+0, 0 
L__main168:
	BTFSS       STATUS+0, 2 
	GOTO        L_main129
L__main138:
;compy.c,525 :: 		IS_FINISH = 1;
	MOVLW       1
	MOVWF       _IS_FINISH+0 
	MOVLW       0
	MOVWF       _IS_FINISH+1 
;compy.c,526 :: 		IS_GAME_OVER = 1;
	MOVLW       1
	MOVWF       _IS_GAME_OVER+0 
	MOVLW       0
	MOVWF       _IS_GAME_OVER+1 
;compy.c,527 :: 		}
L_main129:
;compy.c,529 :: 		command = Le_Teclado();
	CALL        _Le_Teclado+0, 0
	MOVF        R0, 0 
	MOVWF       _command+0 
;compy.c,530 :: 		if (command == '8') {
	MOVF        R0, 0 
	XORLW       56
	BTFSS       STATUS+0, 2 
	GOTO        L_main130
;compy.c,531 :: 		update_pacman(0);
	CLRF        FARG_update_pacman_direction+0 
	CALL        _update_pacman+0, 0
;compy.c,532 :: 		} else if (command == '6') {
	GOTO        L_main131
L_main130:
	MOVF        _command+0, 0 
	XORLW       54
	BTFSS       STATUS+0, 2 
	GOTO        L_main132
;compy.c,533 :: 		update_pacman(1);
	MOVLW       1
	MOVWF       FARG_update_pacman_direction+0 
	CALL        _update_pacman+0, 0
;compy.c,534 :: 		} else if (command == '2') {
	GOTO        L_main133
L_main132:
	MOVF        _command+0, 0 
	XORLW       50
	BTFSS       STATUS+0, 2 
	GOTO        L_main134
;compy.c,535 :: 		update_pacman(2);
	MOVLW       2
	MOVWF       FARG_update_pacman_direction+0 
	CALL        _update_pacman+0, 0
;compy.c,536 :: 		} else if (command == '4') {
	GOTO        L_main135
L_main134:
	MOVF        _command+0, 0 
	XORLW       52
	BTFSS       STATUS+0, 2 
	GOTO        L_main136
;compy.c,537 :: 		update_pacman(3);
	MOVLW       3
	MOVWF       FARG_update_pacman_direction+0 
	CALL        _update_pacman+0, 0
;compy.c,538 :: 		}
L_main136:
L_main135:
L_main133:
L_main131:
;compy.c,540 :: 		if (move_ghost_bool) {
	MOVF        _move_ghost_bool+0, 0 
	IORWF       _move_ghost_bool+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main137
;compy.c,541 :: 		move_ghost_bool = 0;
	CLRF        _move_ghost_bool+0 
	CLRF        _move_ghost_bool+1 
;compy.c,542 :: 		UART1_Write_Text("UART");
	MOVLW       ?lstr5_compy+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr5_compy+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;compy.c,543 :: 		move_ghost();
	CALL        _move_ghost+0, 0
;compy.c,544 :: 		}
L_main137:
;compy.c,545 :: 		}
	GOTO        L_main124
L_main125:
;compy.c,546 :: 		Finish();
	CALL        _Finish+0, 0
;compy.c,548 :: 		}
	GOTO        $+0
; end of _main
