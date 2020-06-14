
_print:

;compy.c,66 :: 		void print(unsigned char column, unsigned char line, code const unsigned char* sprite) {
;compy.c,67 :: 		T6963C_graphics(1);
	BSF         _T6963C_display+0, 3 
	MOVF        _T6963C_display+0, 0 
	MOVWF       FARG_T6963C_writeCommand_mydata+0 
	CALL        _T6963C_writeCommand+0, 0
;compy.c,68 :: 		T6963C_text(0);
	BCF         _T6963C_display+0, 2 
	MOVF        _T6963C_display+0, 0 
	MOVWF       FARG_T6963C_writeCommand_mydata+0 
	CALL        _T6963C_writeCommand+0, 0
;compy.c,69 :: 		T6963C_sprite(column * 16, line * 16, sprite, 16, 16);
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
;compy.c,70 :: 		}
	RETURN      0
; end of _print

_print_text:

;compy.c,72 :: 		void print_text(unsigned char column, unsigned char line, unsigned char* text) {
;compy.c,73 :: 		T6963C_graphics(0);
	BCF         _T6963C_display+0, 3 
	MOVF        _T6963C_display+0, 0 
	MOVWF       FARG_T6963C_writeCommand_mydata+0 
	CALL        _T6963C_writeCommand+0, 0
;compy.c,74 :: 		T6963C_text(1);
	BSF         _T6963C_display+0, 2 
	MOVF        _T6963C_display+0, 0 
	MOVWF       FARG_T6963C_writeCommand_mydata+0 
	CALL        _T6963C_writeCommand+0, 0
;compy.c,75 :: 		T6963C_write_text(text, line - 1, column - 1, T6963C_ROM_MODE_XOR);
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
;compy.c,76 :: 		}
	RETURN      0
; end of _print_text

_getSprite:

;compy.c,96 :: 		const unsigned char* getSprite(char charactereValue) {
;compy.c,97 :: 		if (charactereValue == 0) {
	MOVF        FARG_getSprite_charactereValue+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_getSprite0
;compy.c,98 :: 		return pacman_up;
	MOVLW       _pacman_up+0
	MOVWF       R0 
	MOVLW       hi_addr(_pacman_up+0)
	MOVWF       R1 
	MOVLW       higher_addr(_pacman_up+0)
	MOVWF       R2 
	RETURN      0
;compy.c,99 :: 		} else if (charactereValue == 1) {
L_getSprite0:
	MOVF        FARG_getSprite_charactereValue+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_getSprite2
;compy.c,100 :: 		return pacman_right;
	MOVLW       _pacman_right+0
	MOVWF       R0 
	MOVLW       hi_addr(_pacman_right+0)
	MOVWF       R1 
	MOVLW       higher_addr(_pacman_right+0)
	MOVWF       R2 
	RETURN      0
;compy.c,101 :: 		} else if (charactereValue == 2) {
L_getSprite2:
	MOVF        FARG_getSprite_charactereValue+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_getSprite4
;compy.c,102 :: 		return pacman_down;
	MOVLW       _pacman_down+0
	MOVWF       R0 
	MOVLW       hi_addr(_pacman_down+0)
	MOVWF       R1 
	MOVLW       higher_addr(_pacman_down+0)
	MOVWF       R2 
	RETURN      0
;compy.c,103 :: 		} else if (charactereValue == 3) {
L_getSprite4:
	MOVF        FARG_getSprite_charactereValue+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_getSprite6
;compy.c,104 :: 		return pacman_left;
	MOVLW       _pacman_left+0
	MOVWF       R0 
	MOVLW       hi_addr(_pacman_left+0)
	MOVWF       R1 
	MOVLW       higher_addr(_pacman_left+0)
	MOVWF       R2 
	RETURN      0
;compy.c,105 :: 		} else if (charactereValue == food_orientation) {
L_getSprite6:
	MOVF        FARG_getSprite_charactereValue+0, 0 
	XORWF       _food_orientation+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_getSprite8
;compy.c,106 :: 		return food;
	MOVLW       _food+0
	MOVWF       R0 
	MOVLW       hi_addr(_food+0)
	MOVWF       R1 
	MOVLW       higher_addr(_food+0)
	MOVWF       R2 
	RETURN      0
;compy.c,107 :: 		} else if (charactereValue == ghost_orientation) {
L_getSprite8:
	MOVF        FARG_getSprite_charactereValue+0, 0 
	XORWF       _ghost_orientation+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_getSprite10
;compy.c,108 :: 		return ghost;
	MOVLW       _ghost+0
	MOVWF       R0 
	MOVLW       hi_addr(_ghost+0)
	MOVWF       R1 
	MOVLW       higher_addr(_ghost+0)
	MOVWF       R2 
	RETURN      0
;compy.c,109 :: 		} else if (charactereValue == barrier_orientation) {
L_getSprite10:
	MOVF        FARG_getSprite_charactereValue+0, 0 
	XORWF       _barrier_orientation+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_getSprite12
;compy.c,110 :: 		return obstacle;
	MOVLW       _obstacle+0
	MOVWF       R0 
	MOVLW       hi_addr(_obstacle+0)
	MOVWF       R1 
	MOVLW       higher_addr(_obstacle+0)
	MOVWF       R2 
	RETURN      0
;compy.c,111 :: 		}
L_getSprite12:
;compy.c,112 :: 		return blank;
	MOVLW       _blank+0
	MOVWF       R0 
	MOVLW       hi_addr(_blank+0)
	MOVWF       R1 
	MOVLW       higher_addr(_blank+0)
	MOVWF       R2 
;compy.c,113 :: 		}
	RETURN      0
; end of _getSprite

_printCoordinate:

;compy.c,115 :: 		void printCoordinate(int x, int y) {
;compy.c,116 :: 		print(x, y, getSprite(world[x][y]));
	MOVF        FARG_printCoordinate_x+0, 0 
	MOVWF       R0 
	MOVF        FARG_printCoordinate_x+1, 0 
	MOVWF       R1 
	MOVLW       60
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
;compy.c,117 :: 		}
	RETURN      0
; end of _printCoordinate

_InitTimer2:

;compy.c,124 :: 		void InitTimer2(){
;compy.c,125 :: 		T2CON         = 0x3C;
	MOVLW       60
	MOVWF       T2CON+0 
;compy.c,126 :: 		TMR2IE_bit         = 1;
	BSF         TMR2IE_bit+0, 1 
;compy.c,127 :: 		PR2                 = 249;
	MOVLW       249
	MOVWF       PR2+0 
;compy.c,128 :: 		INTCON         = 0xD0;
	MOVLW       208
	MOVWF       INTCON+0 
;compy.c,129 :: 		}
	RETURN      0
; end of _InitTimer2

_move_ghost:

;compy.c,135 :: 		void move_ghost() {
;compy.c,136 :: 		new_ghost_x = ghost_x;
	MOVF        _ghost_x+0, 0 
	MOVWF       _new_ghost_x+0 
	MOVF        _ghost_x+1, 0 
	MOVWF       _new_ghost_x+1 
;compy.c,138 :: 		if (pacman_x > ghost_x) {
	MOVLW       128
	XORWF       _ghost_x+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _pacman_x+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ghost149
	MOVF        _pacman_x+0, 0 
	SUBWF       _ghost_x+0, 0 
L__move_ghost149:
	BTFSC       STATUS+0, 0 
	GOTO        L_move_ghost13
;compy.c,139 :: 		new_ghost_x = ghost_x + 1;
	MOVLW       1
	ADDWF       _ghost_x+0, 0 
	MOVWF       _new_ghost_x+0 
	MOVLW       0
	ADDWFC      _ghost_x+1, 0 
	MOVWF       _new_ghost_x+1 
;compy.c,140 :: 		} else if (pacman_x < ghost_x) {
	GOTO        L_move_ghost14
L_move_ghost13:
	MOVLW       128
	XORWF       _pacman_x+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _ghost_x+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ghost150
	MOVF        _ghost_x+0, 0 
	SUBWF       _pacman_x+0, 0 
L__move_ghost150:
	BTFSC       STATUS+0, 0 
	GOTO        L_move_ghost15
;compy.c,141 :: 		new_ghost_x = ghost_x - 1;
	MOVLW       1
	SUBWF       _ghost_x+0, 0 
	MOVWF       _new_ghost_x+0 
	MOVLW       0
	SUBWFB      _ghost_x+1, 0 
	MOVWF       _new_ghost_x+1 
;compy.c,142 :: 		}
L_move_ghost15:
L_move_ghost14:
;compy.c,144 :: 		if (world[new_ghost_x][ghost_y] == barrier_orientation) {
	MOVF        _new_ghost_x+0, 0 
	MOVWF       R0 
	MOVF        _new_ghost_x+1, 0 
	MOVWF       R1 
	MOVLW       60
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
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	XORWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ghost151
	MOVF        R0, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ghost151
	MOVF        R0, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ghost151
	MOVF        R1, 0 
	XORWF       _barrier_orientation+0, 0 
L__move_ghost151:
	BTFSS       STATUS+0, 2 
	GOTO        L_move_ghost16
;compy.c,145 :: 		new_ghost_x = ghost_x;
	MOVF        _ghost_x+0, 0 
	MOVWF       _new_ghost_x+0 
	MOVF        _ghost_x+1, 0 
	MOVWF       _new_ghost_x+1 
;compy.c,146 :: 		if (world[ghost_x][ghost_y + 1] != barrier_orientation) {
	MOVF        _ghost_x+0, 0 
	MOVWF       R0 
	MOVF        _ghost_x+1, 0 
	MOVWF       R1 
	MOVLW       60
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _world+0
	ADDWF       R0, 0 
	MOVWF       R5 
	MOVLW       hi_addr(_world+0)
	ADDWFC      R1, 0 
	MOVWF       R6 
	MOVLW       1
	ADDWF       _ghost_y+0, 0 
	MOVWF       R3 
	MOVLW       0
	ADDWFC      _ghost_y+1, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       R5, 0 
	MOVWF       FSR0L 
	MOVF        R1, 0 
	ADDWFC      R6, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	XORWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ghost152
	MOVF        R0, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ghost152
	MOVF        R0, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ghost152
	MOVF        R1, 0 
	XORWF       _barrier_orientation+0, 0 
L__move_ghost152:
	BTFSC       STATUS+0, 2 
	GOTO        L_move_ghost17
;compy.c,147 :: 		new_ghost_y = ghost_y + 1;
	MOVLW       1
	ADDWF       _ghost_y+0, 0 
	MOVWF       _new_ghost_y+0 
	MOVLW       0
	ADDWFC      _ghost_y+1, 0 
	MOVWF       _new_ghost_y+1 
;compy.c,148 :: 		} else if (world[ghost_x][ghost_y - 1] != barrier_orientation) {
	GOTO        L_move_ghost18
L_move_ghost17:
	MOVF        _ghost_x+0, 0 
	MOVWF       R0 
	MOVF        _ghost_x+1, 0 
	MOVWF       R1 
	MOVLW       60
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _world+0
	ADDWF       R0, 0 
	MOVWF       R5 
	MOVLW       hi_addr(_world+0)
	ADDWFC      R1, 0 
	MOVWF       R6 
	MOVLW       1
	SUBWF       _ghost_y+0, 0 
	MOVWF       R3 
	MOVLW       0
	SUBWFB      _ghost_y+1, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       R5, 0 
	MOVWF       FSR0L 
	MOVF        R1, 0 
	ADDWFC      R6, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	XORWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ghost153
	MOVF        R0, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ghost153
	MOVF        R0, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ghost153
	MOVF        R1, 0 
	XORWF       _barrier_orientation+0, 0 
L__move_ghost153:
	BTFSC       STATUS+0, 2 
	GOTO        L_move_ghost19
;compy.c,149 :: 		new_ghost_y = ghost_y - 1;
	MOVLW       1
	SUBWF       _ghost_y+0, 0 
	MOVWF       _new_ghost_y+0 
	MOVLW       0
	SUBWFB      _ghost_y+1, 0 
	MOVWF       _new_ghost_y+1 
;compy.c,150 :: 		}
L_move_ghost19:
L_move_ghost18:
;compy.c,151 :: 		} else if (new_ghost_x == ghost_x) {
	GOTO        L_move_ghost20
L_move_ghost16:
	MOVF        _new_ghost_x+1, 0 
	XORWF       _ghost_x+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ghost154
	MOVF        _ghost_x+0, 0 
	XORWF       _new_ghost_x+0, 0 
L__move_ghost154:
	BTFSS       STATUS+0, 2 
	GOTO        L_move_ghost21
;compy.c,152 :: 		if (pacman_y > ghost_y && world[ghost_x][ghost_y + 1] != barrier_orientation) {
	MOVLW       128
	XORWF       _ghost_y+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _pacman_y+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ghost155
	MOVF        _pacman_y+0, 0 
	SUBWF       _ghost_y+0, 0 
L__move_ghost155:
	BTFSC       STATUS+0, 0 
	GOTO        L_move_ghost24
	MOVF        _ghost_x+0, 0 
	MOVWF       R0 
	MOVF        _ghost_x+1, 0 
	MOVWF       R1 
	MOVLW       60
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _world+0
	ADDWF       R0, 0 
	MOVWF       R5 
	MOVLW       hi_addr(_world+0)
	ADDWFC      R1, 0 
	MOVWF       R6 
	MOVLW       1
	ADDWF       _ghost_y+0, 0 
	MOVWF       R3 
	MOVLW       0
	ADDWFC      _ghost_y+1, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       R5, 0 
	MOVWF       FSR0L 
	MOVF        R1, 0 
	ADDWFC      R6, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	XORWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ghost156
	MOVF        R0, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ghost156
	MOVF        R0, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ghost156
	MOVF        R1, 0 
	XORWF       _barrier_orientation+0, 0 
L__move_ghost156:
	BTFSC       STATUS+0, 2 
	GOTO        L_move_ghost24
L__move_ghost147:
;compy.c,153 :: 		new_ghost_y = ghost_y + 1;
	MOVLW       1
	ADDWF       _ghost_y+0, 0 
	MOVWF       _new_ghost_y+0 
	MOVLW       0
	ADDWFC      _ghost_y+1, 0 
	MOVWF       _new_ghost_y+1 
;compy.c,154 :: 		} else if (pacman_y < ghost_y && world[ghost_x][ghost_y - 1] != barrier_orientation) {
	GOTO        L_move_ghost25
L_move_ghost24:
	MOVLW       128
	XORWF       _pacman_y+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _ghost_y+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ghost157
	MOVF        _ghost_y+0, 0 
	SUBWF       _pacman_y+0, 0 
L__move_ghost157:
	BTFSC       STATUS+0, 0 
	GOTO        L_move_ghost28
	MOVF        _ghost_x+0, 0 
	MOVWF       R0 
	MOVF        _ghost_x+1, 0 
	MOVWF       R1 
	MOVLW       60
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _world+0
	ADDWF       R0, 0 
	MOVWF       R5 
	MOVLW       hi_addr(_world+0)
	ADDWFC      R1, 0 
	MOVWF       R6 
	MOVLW       1
	SUBWF       _ghost_y+0, 0 
	MOVWF       R3 
	MOVLW       0
	SUBWFB      _ghost_y+1, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       R5, 0 
	MOVWF       FSR0L 
	MOVF        R1, 0 
	ADDWFC      R6, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	XORWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ghost158
	MOVF        R0, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ghost158
	MOVF        R0, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__move_ghost158
	MOVF        R1, 0 
	XORWF       _barrier_orientation+0, 0 
L__move_ghost158:
	BTFSC       STATUS+0, 2 
	GOTO        L_move_ghost28
L__move_ghost146:
;compy.c,155 :: 		new_ghost_y = ghost_y - 1;
	MOVLW       1
	SUBWF       _ghost_y+0, 0 
	MOVWF       _new_ghost_y+0 
	MOVLW       0
	SUBWFB      _ghost_y+1, 0 
	MOVWF       _new_ghost_y+1 
;compy.c,156 :: 		}
L_move_ghost28:
L_move_ghost25:
;compy.c,157 :: 		}
L_move_ghost21:
L_move_ghost20:
;compy.c,159 :: 		world[ghost_x][ghost_y] = old_ghost_obj;
	MOVF        _ghost_x+0, 0 
	MOVWF       R0 
	MOVF        _ghost_x+1, 0 
	MOVWF       R1 
	MOVLW       60
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
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       R3, 0 
	MOVWF       FSR1L 
	MOVF        R1, 0 
	ADDWFC      R4, 0 
	MOVWF       FSR1H 
	MOVF        _old_ghost_obj+0, 0 
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
	MOVWF       POSTINC1+0 
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
;compy.c,162 :: 		old_ghost_obj = world[new_ghost_x][new_ghost_y];
	MOVF        _new_ghost_x+0, 0 
	MOVWF       R0 
	MOVF        _new_ghost_x+1, 0 
	MOVWF       R1 
	MOVLW       60
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
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R3, 0 
	ADDWF       R0, 1 
	MOVF        R4, 0 
	ADDWFC      R1, 1 
	MOVFF       R0, FSR0L
	MOVFF       R1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       _old_ghost_obj+0 
;compy.c,163 :: 		world[new_ghost_x][new_ghost_y] = ghost_orientation;
	MOVFF       R0, FSR1L
	MOVFF       R1, FSR1H
	MOVF        _ghost_orientation+0, 0 
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
	MOVWF       POSTINC1+0 
	MOVWF       POSTINC1+0 
;compy.c,164 :: 		printCoordinate(new_ghost_x, new_ghost_y);
	MOVF        _new_ghost_x+0, 0 
	MOVWF       FARG_printCoordinate_x+0 
	MOVF        _new_ghost_x+1, 0 
	MOVWF       FARG_printCoordinate_x+1 
	MOVF        _new_ghost_y+0, 0 
	MOVWF       FARG_printCoordinate_y+0 
	MOVF        _new_ghost_y+1, 0 
	MOVWF       FARG_printCoordinate_y+1 
	CALL        _printCoordinate+0, 0
;compy.c,166 :: 		ghost_y = new_ghost_y;
	MOVF        _new_ghost_y+0, 0 
	MOVWF       _ghost_y+0 
	MOVF        _new_ghost_y+1, 0 
	MOVWF       _ghost_y+1 
;compy.c,167 :: 		ghost_x = new_ghost_x;
	MOVF        _new_ghost_x+0, 0 
	MOVWF       _ghost_x+0 
	MOVF        _new_ghost_x+1, 0 
	MOVWF       _ghost_x+1 
;compy.c,168 :: 		}
	RETURN      0
; end of _move_ghost

_interrupt:

;compy.c,171 :: 		void interrupt() {
;compy.c,172 :: 		if(int0if_bit)
	BTFSS       INT0IF_bit+0, 1 
	GOTO        L_interrupt29
;compy.c,174 :: 		cnt2++;
	INFSNZ      _cnt2+0, 1 
	INCF        _cnt2+1, 1 
;compy.c,175 :: 		if (cnt2 > 180) {
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _cnt2+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt160
	MOVF        _cnt2+0, 0 
	SUBLW       180
L__interrupt160:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt30
;compy.c,176 :: 		IS_FINISH = 1;
	MOVLW       1
	MOVWF       _IS_FINISH+0 
	MOVLW       0
	MOVWF       _IS_FINISH+1 
;compy.c,177 :: 		IS_GAME_OVER = 1;
	MOVLW       1
	MOVWF       _IS_GAME_OVER+0 
	MOVLW       0
	MOVWF       _IS_GAME_OVER+1 
;compy.c,178 :: 		}
L_interrupt30:
;compy.c,179 :: 		int0if_bit = 0;   // clear int0if_bit
	BCF         INT0IF_bit+0, 1 
;compy.c,180 :: 		}
L_interrupt29:
;compy.c,182 :: 		if (TMR2IF_bit) {
	BTFSS       TMR2IF_bit+0, 1 
	GOTO        L_interrupt31
;compy.c,183 :: 		cnt++;
	INFSNZ      _cnt+0, 1 
	INCF        _cnt+1, 1 
;compy.c,184 :: 		if (cnt >= 10000) {
	MOVLW       128
	XORWF       _cnt+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       39
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt161
	MOVLW       16
	SUBWF       _cnt+0, 0 
L__interrupt161:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt32
;compy.c,185 :: 		cnt = 0;
	CLRF        _cnt+0 
	CLRF        _cnt+1 
;compy.c,186 :: 		}
L_interrupt32:
;compy.c,187 :: 		if (cnt % 5000 == 0) {
	MOVLW       136
	MOVWF       R4 
	MOVLW       19
	MOVWF       R5 
	MOVF        _cnt+0, 0 
	MOVWF       R0 
	MOVF        _cnt+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt162
	MOVLW       0
	XORWF       R0, 0 
L__interrupt162:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt33
;compy.c,188 :: 		if (isStarted) {
	MOVF        _isStarted+0, 0 
	IORWF       _isStarted+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt34
;compy.c,189 :: 		generate_food_bool = 1;
	MOVLW       1
	MOVWF       _generate_food_bool+0 
	MOVLW       0
	MOVWF       _generate_food_bool+1 
;compy.c,190 :: 		}
L_interrupt34:
;compy.c,191 :: 		}
L_interrupt33:
;compy.c,192 :: 		if (cnt % 1000 == 0) {
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        _cnt+0, 0 
	MOVWF       R0 
	MOVF        _cnt+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt163
	MOVLW       0
	XORWF       R0, 0 
L__interrupt163:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt35
;compy.c,193 :: 		if (isStarted) {
	MOVF        _isStarted+0, 0 
	IORWF       _isStarted+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt36
;compy.c,194 :: 		move_ghost_bool = 1;
	MOVLW       1
	MOVWF       _move_ghost_bool+0 
	MOVLW       0
	MOVWF       _move_ghost_bool+1 
;compy.c,195 :: 		}
L_interrupt36:
;compy.c,196 :: 		}
L_interrupt35:
;compy.c,197 :: 		TMR2IF_bit = 0;        // clear TMR2IF
	BCF         TMR2IF_bit+0, 1 
;compy.c,198 :: 		}
L_interrupt31:
;compy.c,199 :: 		}
L__interrupt159:
	RETFIE      1
; end of _interrupt

_Le_Teclado:

;compy.c,201 :: 		char Le_Teclado()
;compy.c,203 :: 		PORTD = 0B00010000; // VOCÊ SELECIONOU LA
	MOVLW       16
	MOVWF       PORTD+0 
;compy.c,204 :: 		if (PORTA.RA5 == 1) {
	BTFSS       PORTA+0, 5 
	GOTO        L_Le_Teclado37
;compy.c,205 :: 		while(PORTA.RA5 == 1);
L_Le_Teclado38:
	BTFSS       PORTA+0, 5 
	GOTO        L_Le_Teclado39
	GOTO        L_Le_Teclado38
L_Le_Teclado39:
;compy.c,206 :: 		return '7';
	MOVLW       55
	MOVWF       R0 
	RETURN      0
;compy.c,207 :: 		}
L_Le_Teclado37:
;compy.c,208 :: 		if (PORTB.RB1 == 1) {
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado40
;compy.c,209 :: 		while(PORTB.RB1 == 1);
L_Le_Teclado41:
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado42
	GOTO        L_Le_Teclado41
L_Le_Teclado42:
;compy.c,210 :: 		return '8';
	MOVLW       56
	MOVWF       R0 
	RETURN      0
;compy.c,211 :: 		}
L_Le_Teclado40:
;compy.c,212 :: 		if (PORTB.RB2 == 1) {
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado43
;compy.c,213 :: 		while(PORTB.RB2 == 1);
L_Le_Teclado44:
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado45
	GOTO        L_Le_Teclado44
L_Le_Teclado45:
;compy.c,214 :: 		return '9';
	MOVLW       57
	MOVWF       R0 
	RETURN      0
;compy.c,215 :: 		}
L_Le_Teclado43:
;compy.c,216 :: 		if (PORTB.RB3 == 1) {
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado46
;compy.c,217 :: 		while(PORTB.RB3 == 1);
L_Le_Teclado47:
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado48
	GOTO        L_Le_Teclado47
L_Le_Teclado48:
;compy.c,218 :: 		return '%';
	MOVLW       37
	MOVWF       R0 
	RETURN      0
;compy.c,219 :: 		}
L_Le_Teclado46:
;compy.c,221 :: 		PORTD = 0B00100000; // VOCÊ SELECIONOU LB
	MOVLW       32
	MOVWF       PORTD+0 
;compy.c,222 :: 		if (PORTA.RA5 == 1) {
	BTFSS       PORTA+0, 5 
	GOTO        L_Le_Teclado49
;compy.c,223 :: 		while(PORTA.RA5 == 1);
L_Le_Teclado50:
	BTFSS       PORTA+0, 5 
	GOTO        L_Le_Teclado51
	GOTO        L_Le_Teclado50
L_Le_Teclado51:
;compy.c,224 :: 		return '4';
	MOVLW       52
	MOVWF       R0 
	RETURN      0
;compy.c,225 :: 		}
L_Le_Teclado49:
;compy.c,226 :: 		if (PORTB.RB1 == 1) {
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado52
;compy.c,227 :: 		while(PORTB.RB1 == 1);
L_Le_Teclado53:
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado54
	GOTO        L_Le_Teclado53
L_Le_Teclado54:
;compy.c,228 :: 		return '5';
	MOVLW       53
	MOVWF       R0 
	RETURN      0
;compy.c,229 :: 		}
L_Le_Teclado52:
;compy.c,230 :: 		if (PORTB.RB2 == 1) {
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado55
;compy.c,231 :: 		while(PORTB.RB2 == 1);
L_Le_Teclado56:
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado57
	GOTO        L_Le_Teclado56
L_Le_Teclado57:
;compy.c,232 :: 		return '6';
	MOVLW       54
	MOVWF       R0 
	RETURN      0
;compy.c,233 :: 		}
L_Le_Teclado55:
;compy.c,234 :: 		if (PORTB.RB3 == 1) {
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado58
;compy.c,235 :: 		while(PORTB.RB3 == 1);
L_Le_Teclado59:
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado60
	GOTO        L_Le_Teclado59
L_Le_Teclado60:
;compy.c,236 :: 		return '*';
	MOVLW       42
	MOVWF       R0 
	RETURN      0
;compy.c,237 :: 		}
L_Le_Teclado58:
;compy.c,239 :: 		PORTD = 0B01000000; // VOCÊ SELECIONOU LC
	MOVLW       64
	MOVWF       PORTD+0 
;compy.c,240 :: 		if (PORTA.RA5 == 1) {
	BTFSS       PORTA+0, 5 
	GOTO        L_Le_Teclado61
;compy.c,241 :: 		while(PORTA.RA5 == 1);
L_Le_Teclado62:
	BTFSS       PORTA+0, 5 
	GOTO        L_Le_Teclado63
	GOTO        L_Le_Teclado62
L_Le_Teclado63:
;compy.c,242 :: 		return '1';
	MOVLW       49
	MOVWF       R0 
	RETURN      0
;compy.c,243 :: 		}
L_Le_Teclado61:
;compy.c,244 :: 		if (PORTB.RB1 == 1) {
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado64
;compy.c,245 :: 		while(PORTB.RB1 == 1);
L_Le_Teclado65:
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado66
	GOTO        L_Le_Teclado65
L_Le_Teclado66:
;compy.c,246 :: 		return '2';
	MOVLW       50
	MOVWF       R0 
	RETURN      0
;compy.c,247 :: 		}
L_Le_Teclado64:
;compy.c,248 :: 		if (PORTB.RB2 == 1) {
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado67
;compy.c,249 :: 		while(PORTB.RB2 == 1);
L_Le_Teclado68:
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado69
	GOTO        L_Le_Teclado68
L_Le_Teclado69:
;compy.c,250 :: 		return '3';
	MOVLW       51
	MOVWF       R0 
	RETURN      0
;compy.c,251 :: 		}
L_Le_Teclado67:
;compy.c,252 :: 		if (PORTB.RB3 == 1) {
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado70
;compy.c,253 :: 		while(PORTB.RB3 == 1);
L_Le_Teclado71:
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado72
	GOTO        L_Le_Teclado71
L_Le_Teclado72:
;compy.c,254 :: 		return '-';
	MOVLW       45
	MOVWF       R0 
	RETURN      0
;compy.c,255 :: 		}
L_Le_Teclado70:
;compy.c,257 :: 		PORTD = 0B10000000; // VOCÊ SELECIONOU LD
	MOVLW       128
	MOVWF       PORTD+0 
;compy.c,258 :: 		if (PORTA.RA5 == 1) {
	BTFSS       PORTA+0, 5 
	GOTO        L_Le_Teclado73
;compy.c,259 :: 		while(PORTA.RA5 == 1);
L_Le_Teclado74:
	BTFSS       PORTA+0, 5 
	GOTO        L_Le_Teclado75
	GOTO        L_Le_Teclado74
L_Le_Teclado75:
;compy.c,260 :: 		return 'C';
	MOVLW       67
	MOVWF       R0 
	RETURN      0
;compy.c,261 :: 		}
L_Le_Teclado73:
;compy.c,262 :: 		if (PORTB.RB1 == 1) {
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado76
;compy.c,263 :: 		while(PORTB.RB1 == 1);
L_Le_Teclado77:
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado78
	GOTO        L_Le_Teclado77
L_Le_Teclado78:
;compy.c,264 :: 		return '0';
	MOVLW       48
	MOVWF       R0 
	RETURN      0
;compy.c,265 :: 		}
L_Le_Teclado76:
;compy.c,266 :: 		if (PORTB.RB2 == 1) {
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado79
;compy.c,267 :: 		while(PORTB.RB2 == 1);
L_Le_Teclado80:
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado81
	GOTO        L_Le_Teclado80
L_Le_Teclado81:
;compy.c,268 :: 		return '=';
	MOVLW       61
	MOVWF       R0 
	RETURN      0
;compy.c,269 :: 		}
L_Le_Teclado79:
;compy.c,270 :: 		if (PORTB.RB3 == 1) {
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado82
;compy.c,271 :: 		while(PORTB.RB3 == 1);
L_Le_Teclado83:
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado84
	GOTO        L_Le_Teclado83
L_Le_Teclado84:
;compy.c,272 :: 		return '+';
	MOVLW       43
	MOVWF       R0 
	RETURN      0
;compy.c,273 :: 		}
L_Le_Teclado82:
;compy.c,275 :: 		return (char) 255;
	MOVLW       255
	MOVWF       R0 
;compy.c,276 :: 		}
	RETURN      0
; end of _Le_Teclado

_Print_World:

;compy.c,278 :: 		void Print_World() {
;compy.c,279 :: 		for(i = 0; i < 15; ++i) {
	CLRF        _i+0 
	CLRF        _i+1 
L_Print_World85:
	MOVLW       128
	XORWF       _i+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Print_World164
	MOVLW       15
	SUBWF       _i+0, 0 
L__Print_World164:
	BTFSC       STATUS+0, 0 
	GOTO        L_Print_World86
;compy.c,280 :: 		for(j = 0; j < 8; ++j)
	CLRF        _j+0 
	CLRF        _j+1 
L_Print_World88:
	MOVLW       128
	XORWF       _j+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Print_World165
	MOVLW       8
	SUBWF       _j+0, 0 
L__Print_World165:
	BTFSC       STATUS+0, 0 
	GOTO        L_Print_World89
;compy.c,282 :: 		printCoordinate(i, j);
	MOVF        _i+0, 0 
	MOVWF       FARG_printCoordinate_x+0 
	MOVF        _i+1, 0 
	MOVWF       FARG_printCoordinate_x+1 
	MOVF        _j+0, 0 
	MOVWF       FARG_printCoordinate_y+0 
	MOVF        _j+1, 0 
	MOVWF       FARG_printCoordinate_y+1 
	CALL        _printCoordinate+0, 0
;compy.c,280 :: 		for(j = 0; j < 8; ++j)
	INFSNZ      _j+0, 1 
	INCF        _j+1, 1 
;compy.c,283 :: 		}
	GOTO        L_Print_World88
L_Print_World89:
;compy.c,279 :: 		for(i = 0; i < 15; ++i) {
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;compy.c,284 :: 		}
	GOTO        L_Print_World85
L_Print_World86:
;compy.c,285 :: 		}
	RETURN      0
; end of _Print_World

_Create_World:

;compy.c,287 :: 		void Create_World() {
;compy.c,288 :: 		for(i = 0; i < 15; ++i) {
	CLRF        _i+0 
	CLRF        _i+1 
L_Create_World91:
	MOVLW       128
	XORWF       _i+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Create_World166
	MOVLW       15
	SUBWF       _i+0, 0 
L__Create_World166:
	BTFSC       STATUS+0, 0 
	GOTO        L_Create_World92
;compy.c,289 :: 		for(j = 0; j < 8 ; ++j)
	CLRF        _j+0 
	CLRF        _j+1 
L_Create_World94:
	MOVLW       128
	XORWF       _j+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Create_World167
	MOVLW       8
	SUBWF       _j+0, 0 
L__Create_World167:
	BTFSC       STATUS+0, 0 
	GOTO        L_Create_World95
;compy.c,291 :: 		world[i][j] = ' ';
	MOVF        _i+0, 0 
	MOVWF       R0 
	MOVF        _i+1, 0 
	MOVWF       R1 
	MOVLW       60
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
	MOVWF       POSTINC1+0 
	MOVWF       POSTINC1+0 
;compy.c,289 :: 		for(j = 0; j < 8 ; ++j)
	INFSNZ      _j+0, 1 
	INCF        _j+1, 1 
;compy.c,292 :: 		}
	GOTO        L_Create_World94
L_Create_World95:
;compy.c,288 :: 		for(i = 0; i < 15; ++i) {
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;compy.c,293 :: 		}
	GOTO        L_Create_World91
L_Create_World92:
;compy.c,294 :: 		world[5][0] = barrier_orientation;
	MOVF        _barrier_orientation+0, 0 
	MOVWF       _world+300 
	MOVLW       0
	MOVWF       _world+301 
	MOVWF       _world+302 
	MOVWF       _world+303 
;compy.c,295 :: 		world[5][1] = barrier_orientation;
	MOVF        _barrier_orientation+0, 0 
	MOVWF       _world+304 
	MOVLW       0
	MOVWF       _world+305 
	MOVWF       _world+306 
	MOVWF       _world+307 
;compy.c,296 :: 		world[2][5] = barrier_orientation;
	MOVF        _barrier_orientation+0, 0 
	MOVWF       _world+140 
	MOVLW       0
	MOVWF       _world+141 
	MOVWF       _world+142 
	MOVWF       _world+143 
;compy.c,297 :: 		world[11][5] = barrier_orientation;
	MOVF        _barrier_orientation+0, 0 
	MOVWF       _world+680 
	MOVLW       0
	MOVWF       _world+681 
	MOVWF       _world+682 
	MOVWF       _world+683 
;compy.c,298 :: 		world[10][6] = barrier_orientation;
	MOVF        _barrier_orientation+0, 0 
	MOVWF       _world+624 
	MOVLW       0
	MOVWF       _world+625 
	MOVWF       _world+626 
	MOVWF       _world+627 
;compy.c,299 :: 		world[3][5] = barrier_orientation;
	MOVF        _barrier_orientation+0, 0 
	MOVWF       _world+200 
	MOVLW       0
	MOVWF       _world+201 
	MOVWF       _world+202 
	MOVWF       _world+203 
;compy.c,300 :: 		world[4][5] = barrier_orientation;
	MOVF        _barrier_orientation+0, 0 
	MOVWF       _world+260 
	MOVLW       0
	MOVWF       _world+261 
	MOVWF       _world+262 
	MOVWF       _world+263 
;compy.c,301 :: 		world[11][5] = barrier_orientation;
	MOVF        _barrier_orientation+0, 0 
	MOVWF       _world+680 
	MOVLW       0
	MOVWF       _world+681 
	MOVWF       _world+682 
	MOVWF       _world+683 
;compy.c,302 :: 		world[14][5] = barrier_orientation;
	MOVF        _barrier_orientation+0, 0 
	MOVWF       _world+860 
	MOVLW       0
	MOVWF       _world+861 
	MOVWF       _world+862 
	MOVWF       _world+863 
;compy.c,303 :: 		world[12][6] = barrier_orientation;
	MOVF        _barrier_orientation+0, 0 
	MOVWF       _world+744 
	MOVLW       0
	MOVWF       _world+745 
	MOVWF       _world+746 
	MOVWF       _world+747 
;compy.c,304 :: 		world[13][7] = barrier_orientation;
	MOVF        _barrier_orientation+0, 0 
	MOVWF       _world+808 
	MOVLW       0
	MOVWF       _world+809 
	MOVWF       _world+810 
	MOVWF       _world+811 
;compy.c,305 :: 		world[3][2] = barrier_orientation;
	MOVF        _barrier_orientation+0, 0 
	MOVWF       _world+188 
	MOVLW       0
	MOVWF       _world+189 
	MOVWF       _world+190 
	MOVWF       _world+191 
;compy.c,306 :: 		world[8][3] = barrier_orientation;
	MOVF        _barrier_orientation+0, 0 
	MOVWF       _world+492 
	MOVLW       0
	MOVWF       _world+493 
	MOVWF       _world+494 
	MOVWF       _world+495 
;compy.c,307 :: 		world[4][1] = barrier_orientation;
	MOVF        _barrier_orientation+0, 0 
	MOVWF       _world+244 
	MOVLW       0
	MOVWF       _world+245 
	MOVWF       _world+246 
	MOVWF       _world+247 
;compy.c,309 :: 		world[11][5] = food_orientation;
	MOVF        _food_orientation+0, 0 
	MOVWF       _world+680 
	MOVLW       0
	MOVWF       _world+681 
	MOVWF       _world+682 
	MOVWF       _world+683 
;compy.c,310 :: 		world[5][3] = food_orientation;
	MOVF        _food_orientation+0, 0 
	MOVWF       _world+312 
	MOVLW       0
	MOVWF       _world+313 
	MOVWF       _world+314 
	MOVWF       _world+315 
;compy.c,311 :: 		world[8][2] = food_orientation;
	MOVF        _food_orientation+0, 0 
	MOVWF       _world+488 
	MOVLW       0
	MOVWF       _world+489 
	MOVWF       _world+490 
	MOVWF       _world+491 
;compy.c,312 :: 		world[7][7] = food_orientation;
	MOVF        _food_orientation+0, 0 
	MOVWF       _world+448 
	MOVLW       0
	MOVWF       _world+449 
	MOVWF       _world+450 
	MOVWF       _world+451 
;compy.c,314 :: 		world[ghost_x][ghost_y] = ghost_orientation;
	MOVF        _ghost_x+0, 0 
	MOVWF       R0 
	MOVF        _ghost_x+1, 0 
	MOVWF       R1 
	MOVLW       60
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
	MOVWF       POSTINC1+0 
	MOVWF       POSTINC1+0 
;compy.c,315 :: 		world[pacman_x][pacman_y] = pacman_orientation;
	MOVF        _pacman_x+0, 0 
	MOVWF       R0 
	MOVF        _pacman_x+1, 0 
	MOVWF       R1 
	MOVLW       60
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
	MOVWF       POSTINC1+0 
	MOVWF       POSTINC1+0 
;compy.c,317 :: 		Print_World();
	CALL        _Print_World+0, 0
;compy.c,318 :: 		}
	RETURN      0
; end of _Create_World

_generate_food:

;compy.c,322 :: 		void generate_food() {
;compy.c,323 :: 		food_x = rand() % 15;
	CALL        _rand+0, 0
	MOVLW       15
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _food_x+0 
	MOVF        R1, 0 
	MOVWF       _food_x+1 
;compy.c,324 :: 		food_y = rand() % 8;
	CALL        _rand+0, 0
	MOVLW       8
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _food_y+0 
	MOVF        R1, 0 
	MOVWF       _food_y+1 
;compy.c,325 :: 		if (world[food_x][food_y] == ' ') {
	MOVF        _food_x+0, 0 
	MOVWF       R0 
	MOVF        _food_x+1, 0 
	MOVWF       R1 
	MOVLW       60
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
	MOVF        _food_y+0, 0 
	MOVWF       R0 
	MOVF        _food_y+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
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
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	XORWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__generate_food168
	MOVF        R0, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__generate_food168
	MOVF        R0, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__generate_food168
	MOVF        R1, 0 
	XORLW       32
L__generate_food168:
	BTFSS       STATUS+0, 2 
	GOTO        L_generate_food97
;compy.c,326 :: 		world[food_x][food_y] = food_orientation;
	MOVF        _food_x+0, 0 
	MOVWF       R0 
	MOVF        _food_x+1, 0 
	MOVWF       R1 
	MOVLW       60
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
	MOVF        _food_y+0, 0 
	MOVWF       R0 
	MOVF        _food_y+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       R3, 0 
	MOVWF       FSR1L 
	MOVF        R1, 0 
	ADDWFC      R4, 0 
	MOVWF       FSR1H 
	MOVF        _food_orientation+0, 0 
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
	MOVWF       POSTINC1+0 
	MOVWF       POSTINC1+0 
;compy.c,327 :: 		printCoordinate(food_x, food_y);
	MOVF        _food_x+0, 0 
	MOVWF       FARG_printCoordinate_x+0 
	MOVF        _food_x+1, 0 
	MOVWF       FARG_printCoordinate_x+1 
	MOVF        _food_y+0, 0 
	MOVWF       FARG_printCoordinate_y+0 
	MOVF        _food_y+1, 0 
	MOVWF       FARG_printCoordinate_y+1 
	CALL        _printCoordinate+0, 0
;compy.c,328 :: 		QTD_FOOD++;
	INFSNZ      _QTD_FOOD+0, 1 
	INCF        _QTD_FOOD+1, 1 
;compy.c,329 :: 		}
L_generate_food97:
;compy.c,330 :: 		}
	RETURN      0
; end of _generate_food

_update_pacman_orientation:

;compy.c,332 :: 		char update_pacman_orientation(int newX, int newY) {
;compy.c,333 :: 		if (newX > pacman_x) {
	MOVLW       128
	XORWF       _pacman_x+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_update_pacman_orientation_newX+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman_orientation169
	MOVF        FARG_update_pacman_orientation_newX+0, 0 
	SUBWF       _pacman_x+0, 0 
L__update_pacman_orientation169:
	BTFSC       STATUS+0, 0 
	GOTO        L_update_pacman_orientation98
;compy.c,334 :: 		return (char) 1;
	MOVLW       1
	MOVWF       R0 
	RETURN      0
;compy.c,335 :: 		} else if (newX < pacman_x) {
L_update_pacman_orientation98:
	MOVLW       128
	XORWF       FARG_update_pacman_orientation_newX+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _pacman_x+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman_orientation170
	MOVF        _pacman_x+0, 0 
	SUBWF       FARG_update_pacman_orientation_newX+0, 0 
L__update_pacman_orientation170:
	BTFSC       STATUS+0, 0 
	GOTO        L_update_pacman_orientation100
;compy.c,336 :: 		return (char) 3;
	MOVLW       3
	MOVWF       R0 
	RETURN      0
;compy.c,337 :: 		} else if (newY > pacman_y) {
L_update_pacman_orientation100:
	MOVLW       128
	XORWF       _pacman_y+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_update_pacman_orientation_newY+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman_orientation171
	MOVF        FARG_update_pacman_orientation_newY+0, 0 
	SUBWF       _pacman_y+0, 0 
L__update_pacman_orientation171:
	BTFSC       STATUS+0, 0 
	GOTO        L_update_pacman_orientation102
;compy.c,338 :: 		return (char) 2;
	MOVLW       2
	MOVWF       R0 
	RETURN      0
;compy.c,339 :: 		} else if (newY < pacman_y) {
L_update_pacman_orientation102:
	MOVLW       128
	XORWF       FARG_update_pacman_orientation_newY+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _pacman_y+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman_orientation172
	MOVF        _pacman_y+0, 0 
	SUBWF       FARG_update_pacman_orientation_newY+0, 0 
L__update_pacman_orientation172:
	BTFSC       STATUS+0, 0 
	GOTO        L_update_pacman_orientation104
;compy.c,340 :: 		return 0;
	CLRF        R0 
	RETURN      0
;compy.c,341 :: 		}
L_update_pacman_orientation104:
;compy.c,342 :: 		return pacman_orientation;
	MOVF        _pacman_orientation+0, 0 
	MOVWF       R0 
;compy.c,343 :: 		}
	RETURN      0
; end of _update_pacman_orientation

_update_pacman:

;compy.c,348 :: 		void update_pacman(short direction) {
;compy.c,349 :: 		if (direction == 0) {
	MOVF        FARG_update_pacman_direction+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_update_pacman105
;compy.c,350 :: 		newPacman_x = pacman_x;
	MOVF        _pacman_x+0, 0 
	MOVWF       _newPacman_x+0 
	MOVF        _pacman_x+1, 0 
	MOVWF       _newPacman_x+1 
;compy.c,351 :: 		newPacman_y = pacman_y - 1;
	MOVLW       1
	SUBWF       _pacman_y+0, 0 
	MOVWF       _newPacman_y+0 
	MOVLW       0
	SUBWFB      _pacman_y+1, 0 
	MOVWF       _newPacman_y+1 
;compy.c,352 :: 		} else if (direction == 1) {
	GOTO        L_update_pacman106
L_update_pacman105:
	MOVF        FARG_update_pacman_direction+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_update_pacman107
;compy.c,353 :: 		newPacman_x = pacman_x + 1;
	MOVLW       1
	ADDWF       _pacman_x+0, 0 
	MOVWF       _newPacman_x+0 
	MOVLW       0
	ADDWFC      _pacman_x+1, 0 
	MOVWF       _newPacman_x+1 
;compy.c,354 :: 		newPacman_y = pacman_y;
	MOVF        _pacman_y+0, 0 
	MOVWF       _newPacman_y+0 
	MOVF        _pacman_y+1, 0 
	MOVWF       _newPacman_y+1 
;compy.c,355 :: 		} else if (direction == 2) {
	GOTO        L_update_pacman108
L_update_pacman107:
	MOVF        FARG_update_pacman_direction+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_update_pacman109
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
;compy.c,358 :: 		} else if (direction == 3) {
	GOTO        L_update_pacman110
L_update_pacman109:
	MOVF        FARG_update_pacman_direction+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_update_pacman111
;compy.c,359 :: 		newPacman_x = pacman_x - 1;
	MOVLW       1
	SUBWF       _pacman_x+0, 0 
	MOVWF       _newPacman_x+0 
	MOVLW       0
	SUBWFB      _pacman_x+1, 0 
	MOVWF       _newPacman_x+1 
;compy.c,360 :: 		newPacman_y = pacman_y;
	MOVF        _pacman_y+0, 0 
	MOVWF       _newPacman_y+0 
	MOVF        _pacman_y+1, 0 
	MOVWF       _newPacman_y+1 
;compy.c,361 :: 		}
L_update_pacman111:
L_update_pacman110:
L_update_pacman108:
L_update_pacman106:
;compy.c,363 :: 		newPacmanOrientation = update_pacman_orientation(newPacman_x, newPacman_y);
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
;compy.c,365 :: 		if (newPacman_x < 0) newPacman_x = 14;
	MOVLW       128
	XORWF       _newPacman_x+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman173
	MOVLW       0
	SUBWF       _newPacman_x+0, 0 
L__update_pacman173:
	BTFSC       STATUS+0, 0 
	GOTO        L_update_pacman112
	MOVLW       14
	MOVWF       _newPacman_x+0 
	MOVLW       0
	MOVWF       _newPacman_x+1 
L_update_pacman112:
;compy.c,366 :: 		if (newPacman_x > 14) newPacman_x = 0;
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _newPacman_x+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman174
	MOVF        _newPacman_x+0, 0 
	SUBLW       14
L__update_pacman174:
	BTFSC       STATUS+0, 0 
	GOTO        L_update_pacman113
	CLRF        _newPacman_x+0 
	CLRF        _newPacman_x+1 
L_update_pacman113:
;compy.c,368 :: 		if (newPacman_y < 0) newPacman_y = 7;
	MOVLW       128
	XORWF       _newPacman_y+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman175
	MOVLW       0
	SUBWF       _newPacman_y+0, 0 
L__update_pacman175:
	BTFSC       STATUS+0, 0 
	GOTO        L_update_pacman114
	MOVLW       7
	MOVWF       _newPacman_y+0 
	MOVLW       0
	MOVWF       _newPacman_y+1 
L_update_pacman114:
;compy.c,369 :: 		if (newPacman_y > 7) newPacman_y = 0;
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _newPacman_y+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman176
	MOVF        _newPacman_y+0, 0 
	SUBLW       7
L__update_pacman176:
	BTFSC       STATUS+0, 0 
	GOTO        L_update_pacman115
	CLRF        _newPacman_y+0 
	CLRF        _newPacman_y+1 
L_update_pacman115:
;compy.c,371 :: 		if (world[newPacman_x][newPacman_y] != barrier_orientation) {
	MOVF        _newPacman_x+0, 0 
	MOVWF       R0 
	MOVF        _newPacman_x+1, 0 
	MOVWF       R1 
	MOVLW       60
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
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	XORWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman177
	MOVF        R0, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman177
	MOVF        R0, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman177
	MOVF        R1, 0 
	XORWF       _barrier_orientation+0, 0 
L__update_pacman177:
	BTFSC       STATUS+0, 2 
	GOTO        L_update_pacman116
;compy.c,372 :: 		if (world[newPacman_x][newPacman_y] == food_orientation) {
	MOVF        _newPacman_x+0, 0 
	MOVWF       R0 
	MOVF        _newPacman_x+1, 0 
	MOVWF       R1 
	MOVLW       60
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
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R0 
	XORWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman178
	MOVF        R0, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman178
	MOVF        R0, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman178
	MOVF        R1, 0 
	XORWF       _food_orientation+0, 0 
L__update_pacman178:
	BTFSS       STATUS+0, 2 
	GOTO        L_update_pacman117
;compy.c,373 :: 		QTD_FOOD--;
	MOVLW       1
	SUBWF       _QTD_FOOD+0, 1 
	MOVLW       0
	SUBWFB      _QTD_FOOD+1, 1 
;compy.c,374 :: 		}
L_update_pacman117:
;compy.c,375 :: 		if (QTD_FOOD == 0) {
	MOVLW       0
	XORWF       _QTD_FOOD+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__update_pacman179
	MOVLW       0
	XORWF       _QTD_FOOD+0, 0 
L__update_pacman179:
	BTFSS       STATUS+0, 2 
	GOTO        L_update_pacman118
;compy.c,376 :: 		IS_FINISH = 1;
	MOVLW       1
	MOVWF       _IS_FINISH+0 
	MOVLW       0
	MOVWF       _IS_FINISH+1 
;compy.c,377 :: 		IS_GAME_OVER = 0;
	CLRF        _IS_GAME_OVER+0 
	CLRF        _IS_GAME_OVER+1 
;compy.c,378 :: 		}
L_update_pacman118:
;compy.c,380 :: 		pacman_orientation = newPacmanOrientation;
	MOVF        _newPacmanOrientation+0, 0 
	MOVWF       _pacman_orientation+0 
;compy.c,382 :: 		world[pacman_x][pacman_y] = ' ';
	MOVF        _pacman_x+0, 0 
	MOVWF       R0 
	MOVF        _pacman_x+1, 0 
	MOVWF       R1 
	MOVLW       60
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
	MOVWF       POSTINC1+0 
	MOVWF       POSTINC1+0 
;compy.c,383 :: 		printCoordinate(pacman_x, pacman_y);
	MOVF        _pacman_x+0, 0 
	MOVWF       FARG_printCoordinate_x+0 
	MOVF        _pacman_x+1, 0 
	MOVWF       FARG_printCoordinate_x+1 
	MOVF        _pacman_y+0, 0 
	MOVWF       FARG_printCoordinate_y+0 
	MOVF        _pacman_y+1, 0 
	MOVWF       FARG_printCoordinate_y+1 
	CALL        _printCoordinate+0, 0
;compy.c,385 :: 		world[newPacman_x][newPacman_y] = pacman_orientation;
	MOVF        _newPacman_x+0, 0 
	MOVWF       R0 
	MOVF        _newPacman_x+1, 0 
	MOVWF       R1 
	MOVLW       60
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
	MOVWF       POSTINC1+0 
	MOVWF       POSTINC1+0 
;compy.c,386 :: 		printCoordinate(newPacman_x, newPacman_y);
	MOVF        _newPacman_x+0, 0 
	MOVWF       FARG_printCoordinate_x+0 
	MOVF        _newPacman_x+1, 0 
	MOVWF       FARG_printCoordinate_x+1 
	MOVF        _newPacman_y+0, 0 
	MOVWF       FARG_printCoordinate_y+0 
	MOVF        _newPacman_y+1, 0 
	MOVWF       FARG_printCoordinate_y+1 
	CALL        _printCoordinate+0, 0
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
L_update_pacman116:
;compy.c,391 :: 		}
	RETURN      0
; end of _update_pacman

_Start_Screen:

;compy.c,395 :: 		void Start_Screen() {
;compy.c,396 :: 		print_text(1, 6, "PAC MAN");
	MOVLW       1
	MOVWF       FARG_print_text_column+0 
	MOVLW       6
	MOVWF       FARG_print_text_line+0 
	MOVLW       ?lstr1_compy+0
	MOVWF       FARG_print_text_text+0 
	MOVLW       hi_addr(?lstr1_compy+0)
	MOVWF       FARG_print_text_text+1 
	CALL        _print_text+0, 0
;compy.c,397 :: 		print_text(3, 1, "PRESSIONE UMA TECLA!");
	MOVLW       3
	MOVWF       FARG_print_text_column+0 
	MOVLW       1
	MOVWF       FARG_print_text_line+0 
	MOVLW       ?lstr2_compy+0
	MOVWF       FARG_print_text_text+0 
	MOVLW       hi_addr(?lstr2_compy+0)
	MOVWF       FARG_print_text_text+1 
	CALL        _print_text+0, 0
;compy.c,399 :: 		while (Le_Teclado() == 255);
L_Start_Screen119:
	CALL        _Le_Teclado+0, 0
	MOVF        R0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_Start_Screen120
	GOTO        L_Start_Screen119
L_Start_Screen120:
;compy.c,400 :: 		}
	RETURN      0
; end of _Start_Screen

_Finish:

;compy.c,402 :: 		void Finish() {
;compy.c,403 :: 		for(i = 0; i < 15; ++i) {
	CLRF        _i+0 
	CLRF        _i+1 
L_Finish121:
	MOVLW       128
	XORWF       _i+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Finish180
	MOVLW       15
	SUBWF       _i+0, 0 
L__Finish180:
	BTFSC       STATUS+0, 0 
	GOTO        L_Finish122
;compy.c,404 :: 		for(j = 0; j < 8; ++j) {
	CLRF        _j+0 
	CLRF        _j+1 
L_Finish124:
	MOVLW       128
	XORWF       _j+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Finish181
	MOVLW       8
	SUBWF       _j+0, 0 
L__Finish181:
	BTFSC       STATUS+0, 0 
	GOTO        L_Finish125
;compy.c,405 :: 		world[i][j] = ' ';
	MOVF        _i+0, 0 
	MOVWF       R0 
	MOVF        _i+1, 0 
	MOVWF       R1 
	MOVLW       60
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
	MOVWF       POSTINC1+0 
	MOVWF       POSTINC1+0 
;compy.c,404 :: 		for(j = 0; j < 8; ++j) {
	INFSNZ      _j+0, 1 
	INCF        _j+1, 1 
;compy.c,406 :: 		}
	GOTO        L_Finish124
L_Finish125:
;compy.c,403 :: 		for(i = 0; i < 15; ++i) {
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;compy.c,407 :: 		}
	GOTO        L_Finish121
L_Finish122:
;compy.c,408 :: 		Print_World();
	CALL        _Print_World+0, 0
;compy.c,409 :: 		if (IS_GAME_OVER) {
	MOVF        _IS_GAME_OVER+0, 0 
	IORWF       _IS_GAME_OVER+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Finish127
;compy.c,410 :: 		print_text(2, 1, "Game over");
	MOVLW       2
	MOVWF       FARG_print_text_column+0 
	MOVLW       1
	MOVWF       FARG_print_text_line+0 
	MOVLW       ?lstr3_compy+0
	MOVWF       FARG_print_text_text+0 
	MOVLW       hi_addr(?lstr3_compy+0)
	MOVWF       FARG_print_text_text+1 
	CALL        _print_text+0, 0
;compy.c,411 :: 		} else {
	GOTO        L_Finish128
L_Finish127:
;compy.c,412 :: 		print_text(2, 1, "Win");
	MOVLW       2
	MOVWF       FARG_print_text_column+0 
	MOVLW       1
	MOVWF       FARG_print_text_line+0 
	MOVLW       ?lstr4_compy+0
	MOVWF       FARG_print_text_text+0 
	MOVLW       hi_addr(?lstr4_compy+0)
	MOVWF       FARG_print_text_text+1 
	CALL        _print_text+0, 0
;compy.c,413 :: 		}
L_Finish128:
;compy.c,414 :: 		}
	RETURN      0
; end of _Finish

_Start_Screen_1:

;compy.c,416 :: 		void Start_Screen_1() {
;compy.c,417 :: 		Sound_Play(DO1, 200);
	MOVLW       65
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       200
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;compy.c,418 :: 		Sound_Play(DO1, 200);
	MOVLW       65
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       200
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;compy.c,419 :: 		Sound_Play(RE1, 200);
	MOVLW       1
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       200
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;compy.c,420 :: 		Sound_Play(DO1, 200);
	MOVLW       65
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       200
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;compy.c,421 :: 		Sound_Play(FA1, 1000);
	MOVLW       87
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       232
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       3
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;compy.c,422 :: 		Delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_Start_Screen_1129:
	DECFSZ      R13, 1, 0
	BRA         L_Start_Screen_1129
	DECFSZ      R12, 1, 0
	BRA         L_Start_Screen_1129
	DECFSZ      R11, 1, 0
	BRA         L_Start_Screen_1129
	NOP
	NOP
;compy.c,423 :: 		Sound_Play(DO2, 100);
	MOVLW       131
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       100
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;compy.c,424 :: 		Sound_Play(SI1, 100);
	MOVLW       123
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       100
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;compy.c,425 :: 		Sound_Play(LA1, 100);
	MOVLW       110
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       100
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;compy.c,426 :: 		Sound_Play(SOL1, 100);
	MOVLW       98
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       100
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;compy.c,427 :: 		Sound_Play(DO1, 100);
	MOVLW       65
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       100
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;compy.c,428 :: 		}
	RETURN      0
; end of _Start_Screen_1

_main:

;compy.c,430 :: 		void main() {           // General purpose register
;compy.c,431 :: 		UART1_Init(19200);
	MOVLW       25
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;compy.c,432 :: 		I2C1_Init(100000);
	MOVLW       20
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;compy.c,433 :: 		ADCON1 = 0B00001110;
	MOVLW       14
	MOVWF       ADCON1+0 
;compy.c,434 :: 		TRISB = 0B00001111;
	MOVLW       15
	MOVWF       TRISB+0 
;compy.c,435 :: 		TRISA = 0B00100001;
	MOVLW       33
	MOVWF       TRISA+0 
;compy.c,437 :: 		TRISA3_bit = 1;               // Set RA3 as input
	BSF         TRISA3_bit+0, 3 
;compy.c,438 :: 		TRISA4_bit = 1;               // Set RA4 as input
	BSF         TRISA4_bit+0, 4 
;compy.c,440 :: 		Sound_Init(&PORTC, 5);
	MOVLW       PORTC+0
	MOVWF       FARG_Sound_Init_snd_port+0 
	MOVLW       hi_addr(PORTC+0)
	MOVWF       FARG_Sound_Init_snd_port+1 
	MOVLW       5
	MOVWF       FARG_Sound_Init_snd_pin+0 
	CALL        _Sound_Init+0, 0
;compy.c,441 :: 		Start_Screen_1();
	CALL        _Start_Screen_1+0, 0
;compy.c,444 :: 		T6963C_init(240, 128, 8);
	MOVLW       240
	MOVWF       FARG_T6963C_init_width+0 
	MOVLW       0
	MOVWF       FARG_T6963C_init_width+1 
	MOVLW       128
	MOVWF       FARG_T6963C_init_height+0 
	MOVLW       8
	MOVWF       FARG_T6963C_init_fntW+0 
	CALL        _T6963C_init+0, 0
;compy.c,449 :: 		T6963C_graphics(1);
	BSF         _T6963C_display+0, 3 
	MOVF        _T6963C_display+0, 0 
	MOVWF       FARG_T6963C_writeCommand_mydata+0 
	CALL        _T6963C_writeCommand+0, 0
;compy.c,450 :: 		T6963C_text(1);
	BSF         _T6963C_display+0, 2 
	MOVF        _T6963C_display+0, 0 
	MOVWF       FARG_T6963C_writeCommand_mydata+0 
	CALL        _T6963C_writeCommand+0, 0
;compy.c,452 :: 		InitTimer2();
	CALL        _InitTimer2+0, 0
;compy.c,455 :: 		Create_World();
	CALL        _Create_World+0, 0
;compy.c,456 :: 		isStarted = 1;
	MOVLW       1
	MOVWF       _isStarted+0 
	MOVLW       0
	MOVWF       _isStarted+1 
;compy.c,458 :: 		while (1) {
L_main130:
;compy.c,459 :: 		if (IS_FINISH) {
	MOVF        _IS_FINISH+0, 0 
	IORWF       _IS_FINISH+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main132
;compy.c,460 :: 		break;
	GOTO        L_main131
;compy.c,461 :: 		}
L_main132:
;compy.c,463 :: 		if (pacman_x == ghost_x && pacman_y == ghost_y) {
	MOVF        _pacman_x+1, 0 
	XORWF       _ghost_x+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main182
	MOVF        _ghost_x+0, 0 
	XORWF       _pacman_x+0, 0 
L__main182:
	BTFSS       STATUS+0, 2 
	GOTO        L_main135
	MOVF        _pacman_y+1, 0 
	XORWF       _ghost_y+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main183
	MOVF        _ghost_y+0, 0 
	XORWF       _pacman_y+0, 0 
L__main183:
	BTFSS       STATUS+0, 2 
	GOTO        L_main135
L__main148:
;compy.c,464 :: 		IS_FINISH = 1;
	MOVLW       1
	MOVWF       _IS_FINISH+0 
	MOVLW       0
	MOVWF       _IS_FINISH+1 
;compy.c,465 :: 		IS_GAME_OVER = 1;
	MOVLW       1
	MOVWF       _IS_GAME_OVER+0 
	MOVLW       0
	MOVWF       _IS_GAME_OVER+1 
;compy.c,466 :: 		}
L_main135:
;compy.c,468 :: 		command = Le_Teclado();
	CALL        _Le_Teclado+0, 0
	MOVF        R0, 0 
	MOVWF       _command+0 
;compy.c,469 :: 		if (command == '8') {
	MOVF        R0, 0 
	XORLW       56
	BTFSS       STATUS+0, 2 
	GOTO        L_main136
;compy.c,470 :: 		update_pacman(0);
	CLRF        FARG_update_pacman_direction+0 
	CALL        _update_pacman+0, 0
;compy.c,471 :: 		} else if (command == '6') {
	GOTO        L_main137
L_main136:
	MOVF        _command+0, 0 
	XORLW       54
	BTFSS       STATUS+0, 2 
	GOTO        L_main138
;compy.c,472 :: 		update_pacman(1);
	MOVLW       1
	MOVWF       FARG_update_pacman_direction+0 
	CALL        _update_pacman+0, 0
;compy.c,473 :: 		} else if (command == '2') {
	GOTO        L_main139
L_main138:
	MOVF        _command+0, 0 
	XORLW       50
	BTFSS       STATUS+0, 2 
	GOTO        L_main140
;compy.c,474 :: 		update_pacman(2);
	MOVLW       2
	MOVWF       FARG_update_pacman_direction+0 
	CALL        _update_pacman+0, 0
;compy.c,475 :: 		} else if (command == '4') {
	GOTO        L_main141
L_main140:
	MOVF        _command+0, 0 
	XORLW       52
	BTFSS       STATUS+0, 2 
	GOTO        L_main142
;compy.c,476 :: 		update_pacman(3);
	MOVLW       3
	MOVWF       FARG_update_pacman_direction+0 
	CALL        _update_pacman+0, 0
;compy.c,477 :: 		}
L_main142:
L_main141:
L_main139:
L_main137:
;compy.c,479 :: 		if (move_ghost_bool) {
	MOVF        _move_ghost_bool+0, 0 
	IORWF       _move_ghost_bool+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main143
;compy.c,480 :: 		move_ghost_bool = 0;
	CLRF        _move_ghost_bool+0 
	CLRF        _move_ghost_bool+1 
;compy.c,481 :: 		UART1_Write_Text("X");
	MOVLW       ?lstr5_compy+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr5_compy+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;compy.c,482 :: 		move_ghost();
	CALL        _move_ghost+0, 0
;compy.c,483 :: 		}
L_main143:
;compy.c,484 :: 		if (generate_food_bool) {
	MOVF        _generate_food_bool+0, 0 
	IORWF       _generate_food_bool+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main144
;compy.c,485 :: 		generate_food_bool = 0;
	CLRF        _generate_food_bool+0 
	CLRF        _generate_food_bool+1 
;compy.c,486 :: 		UART1_Write_Text("Y");
	MOVLW       ?lstr6_compy+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr6_compy+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;compy.c,487 :: 		generate_food();
	CALL        _generate_food+0, 0
;compy.c,488 :: 		}
L_main144:
;compy.c,489 :: 		if (QTD_FOOD < 1) {
	MOVLW       0
	SUBWF       _QTD_FOOD+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main184
	MOVLW       1
	SUBWF       _QTD_FOOD+0, 0 
L__main184:
	BTFSC       STATUS+0, 0 
	GOTO        L_main145
;compy.c,490 :: 		IS_FINISH = 1;
	MOVLW       1
	MOVWF       _IS_FINISH+0 
	MOVLW       0
	MOVWF       _IS_FINISH+1 
;compy.c,491 :: 		IS_GAME_OVER = 0;
	CLRF        _IS_GAME_OVER+0 
	CLRF        _IS_GAME_OVER+1 
;compy.c,492 :: 		}
L_main145:
;compy.c,493 :: 		}
	GOTO        L_main130
L_main131:
;compy.c,494 :: 		Finish();
	CALL        _Finish+0, 0
;compy.c,496 :: 		}
	GOTO        $+0
; end of _main
