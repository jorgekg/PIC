
_main:

;grafico.c,280 :: 		void main() {
;grafico.c,281 :: 		char txt1[] = " EINSTEIN WOULD HAVE LIKED mE";
	MOVLW       ?ICSmain_txt1_L0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICSmain_txt1_L0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICSmain_txt1_L0+0)
	MOVWF       TBLPTRU 
	MOVLW       main_txt1_L0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(main_txt1_L0+0)
	MOVWF       FSR1H 
	MOVLW       30
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
;grafico.c,282 :: 		char txt[] =  " GLCD LIBRARY DEMO, WELCOME !";
	MOVLW       ?ICSmain_txt_L0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICSmain_txt_L0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICSmain_txt_L0+0)
	MOVWF       TBLPTRU 
	MOVLW       main_txt_L0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FSR1H 
	MOVLW       30
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
;grafico.c,287 :: 		ADCON1=0x0E;
	MOVLW       14
	MOVWF       ADCON1+0 
;grafico.c,289 :: 		TRISA3_bit = 1;               // Set RA3 as input
	BSF         TRISA3_bit+0, 3 
;grafico.c,290 :: 		TRISA4_bit = 1;               // Set RA4 as input
	BSF         TRISA4_bit+0, 4 
;grafico.c,293 :: 		T6963C_init(240, 128, 8);
	MOVLW       240
	MOVWF       FARG_T6963C_init_width+0 
	MOVLW       0
	MOVWF       FARG_T6963C_init_width+1 
	MOVLW       128
	MOVWF       FARG_T6963C_init_height+0 
	MOVLW       8
	MOVWF       FARG_T6963C_init_fntW+0 
	CALL        _T6963C_init+0, 0
;grafico.c,298 :: 		T6963C_graphics(1);
	BSF         _T6963C_display+0, 3 
	MOVF        _T6963C_display+0, 0 
	MOVWF       FARG_T6963C_writeCommand_mydata+0 
	CALL        _T6963C_writeCommand+0, 0
;grafico.c,299 :: 		T6963C_text(1);
	BSF         _T6963C_display+0, 2 
	MOVF        _T6963C_display+0, 0 
	MOVWF       FARG_T6963C_writeCommand_mydata+0 
	CALL        _T6963C_writeCommand+0, 0
;grafico.c,301 :: 		T6963C_sprite(10,10,icone_16_16_pixel,16,16);
	MOVLW       10
	MOVWF       FARG_T6963C_sprite_px+0 
	MOVLW       10
	MOVWF       FARG_T6963C_sprite_py+0 
	MOVLW       _icone_16_16_pixel+0
	MOVWF       FARG_T6963C_sprite_pic+0 
	MOVLW       hi_addr(_icone_16_16_pixel+0)
	MOVWF       FARG_T6963C_sprite_pic+1 
	MOVLW       higher_addr(_icone_16_16_pixel+0)
	MOVWF       FARG_T6963C_sprite_pic+2 
	MOVLW       16
	MOVWF       FARG_T6963C_sprite_sx+0 
	MOVLW       16
	MOVWF       FARG_T6963C_sprite_sy+0 
	CALL        _T6963C_sprite+0, 0
;grafico.c,304 :: 		delay_ms(10000);
	MOVLW       102
	MOVWF       R11, 0
	MOVLW       118
	MOVWF       R12, 0
	MOVLW       193
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 0
	BRA         L_main0
	DECFSZ      R12, 1, 0
	BRA         L_main0
	DECFSZ      R11, 1, 0
	BRA         L_main0
;grafico.c,306 :: 		T6963C_image(IMG_0046_bmp);
	MOVLW       _IMG_0046_bmp+0
	MOVWF       FARG_T6963C_image_pic+0 
	MOVLW       hi_addr(_IMG_0046_bmp+0)
	MOVWF       FARG_T6963C_image_pic+1 
	MOVLW       higher_addr(_IMG_0046_bmp+0)
	MOVWF       FARG_T6963C_image_pic+2 
	CALL        _T6963C_image+0, 0
;grafico.c,308 :: 		delay_ms(3000);
	MOVLW       31
	MOVWF       R11, 0
	MOVLW       113
	MOVWF       R12, 0
	MOVLW       30
	MOVWF       R13, 0
L_main1:
	DECFSZ      R13, 1, 0
	BRA         L_main1
	DECFSZ      R12, 1, 0
	BRA         L_main1
	DECFSZ      R11, 1, 0
	BRA         L_main1
	NOP
;grafico.c,310 :: 		panel = 0;
	CLRF        main_panel_L0+0 
;grafico.c,315 :: 		T6963C_write_text(txt, 0, 0, T6963C_ROM_MODE_XOR);
	MOVLW       main_txt_L0+0
	MOVWF       FARG_T6963C_write_text_str+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_T6963C_write_text_str+1 
	CLRF        FARG_T6963C_write_text_x+0 
	CLRF        FARG_T6963C_write_text_y+0 
	MOVLW       129
	MOVWF       FARG_T6963C_write_text_mode+0 
	CALL        _T6963C_write_text+0, 0
;grafico.c,316 :: 		T6963C_write_text(txt1, 0, 15, T6963C_ROM_MODE_XOR);
	MOVLW       main_txt1_L0+0
	MOVWF       FARG_T6963C_write_text_str+0 
	MOVLW       hi_addr(main_txt1_L0+0)
	MOVWF       FARG_T6963C_write_text_str+1 
	CLRF        FARG_T6963C_write_text_x+0 
	MOVLW       15
	MOVWF       FARG_T6963C_write_text_y+0 
	MOVLW       129
	MOVWF       FARG_T6963C_write_text_mode+0 
	CALL        _T6963C_write_text+0, 0
;grafico.c,321 :: 		T6963C_cursor_height(8);       // 8 pixel height
	MOVLW       167
	MOVWF       FARG_T6963C_writeCommand_mydata+0 
	CALL        _T6963C_writeCommand+0, 0
;grafico.c,322 :: 		T6963C_set_cursor(0, 0);       // Move cursor to top left
	CLRF        FARG_T6963C_set_cursor_x+0 
	CLRF        FARG_T6963C_set_cursor_y+0 
	CALL        _T6963C_set_cursor+0, 0
;grafico.c,323 :: 		T6963C_cursor(0);              // Cursor off
	BCF         _T6963C_display+0, 1 
	MOVF        _T6963C_display+0, 0 
	MOVWF       FARG_T6963C_writeCommand_mydata+0 
	CALL        _T6963C_writeCommand+0, 0
;grafico.c,328 :: 		T6963C_rectangle(0, 0, 239, 127, T6963C_WHITE);
	CLRF        FARG_T6963C_rectangle_x0+0 
	CLRF        FARG_T6963C_rectangle_x0+1 
	CLRF        FARG_T6963C_rectangle_y0+0 
	CLRF        FARG_T6963C_rectangle_y0+1 
	MOVLW       239
	MOVWF       FARG_T6963C_rectangle_x1+0 
	MOVLW       0
	MOVWF       FARG_T6963C_rectangle_x1+1 
	MOVLW       127
	MOVWF       FARG_T6963C_rectangle_y1+0 
	MOVLW       0
	MOVWF       FARG_T6963C_rectangle_y1+1 
	MOVLW       8
	MOVWF       FARG_T6963C_rectangle_pcolor+0 
	CALL        _T6963C_rectangle+0, 0
;grafico.c,329 :: 		T6963C_rectangle(20, 20, 219, 107, T6963C_WHITE);
	MOVLW       20
	MOVWF       FARG_T6963C_rectangle_x0+0 
	MOVLW       0
	MOVWF       FARG_T6963C_rectangle_x0+1 
	MOVLW       20
	MOVWF       FARG_T6963C_rectangle_y0+0 
	MOVLW       0
	MOVWF       FARG_T6963C_rectangle_y0+1 
	MOVLW       219
	MOVWF       FARG_T6963C_rectangle_x1+0 
	MOVLW       0
	MOVWF       FARG_T6963C_rectangle_x1+1 
	MOVLW       107
	MOVWF       FARG_T6963C_rectangle_y1+0 
	MOVLW       0
	MOVWF       FARG_T6963C_rectangle_y1+1 
	MOVLW       8
	MOVWF       FARG_T6963C_rectangle_pcolor+0 
	CALL        _T6963C_rectangle+0, 0
;grafico.c,330 :: 		T6963C_rectangle(40, 40, 199, 87, T6963C_WHITE);
	MOVLW       40
	MOVWF       FARG_T6963C_rectangle_x0+0 
	MOVLW       0
	MOVWF       FARG_T6963C_rectangle_x0+1 
	MOVLW       40
	MOVWF       FARG_T6963C_rectangle_y0+0 
	MOVLW       0
	MOVWF       FARG_T6963C_rectangle_y0+1 
	MOVLW       199
	MOVWF       FARG_T6963C_rectangle_x1+0 
	MOVLW       0
	MOVWF       FARG_T6963C_rectangle_x1+1 
	MOVLW       87
	MOVWF       FARG_T6963C_rectangle_y1+0 
	MOVLW       0
	MOVWF       FARG_T6963C_rectangle_y1+1 
	MOVLW       8
	MOVWF       FARG_T6963C_rectangle_pcolor+0 
	CALL        _T6963C_rectangle+0, 0
;grafico.c,331 :: 		T6963C_rectangle(60, 60, 179, 67, T6963C_WHITE);
	MOVLW       60
	MOVWF       FARG_T6963C_rectangle_x0+0 
	MOVLW       0
	MOVWF       FARG_T6963C_rectangle_x0+1 
	MOVLW       60
	MOVWF       FARG_T6963C_rectangle_y0+0 
	MOVLW       0
	MOVWF       FARG_T6963C_rectangle_y0+1 
	MOVLW       179
	MOVWF       FARG_T6963C_rectangle_x1+0 
	MOVLW       0
	MOVWF       FARG_T6963C_rectangle_x1+1 
	MOVLW       67
	MOVWF       FARG_T6963C_rectangle_y1+0 
	MOVLW       0
	MOVWF       FARG_T6963C_rectangle_y1+1 
	MOVLW       8
	MOVWF       FARG_T6963C_rectangle_pcolor+0 
	CALL        _T6963C_rectangle+0, 0
;grafico.c,336 :: 		T6963C_line(0, 0, 239, 127, T6963C_WHITE);
	CLRF        FARG_T6963C_line_x0+0 
	CLRF        FARG_T6963C_line_x0+1 
	CLRF        FARG_T6963C_line_y0+0 
	CLRF        FARG_T6963C_line_y0+1 
	MOVLW       239
	MOVWF       FARG_T6963C_line_x1+0 
	MOVLW       0
	MOVWF       FARG_T6963C_line_x1+1 
	MOVLW       127
	MOVWF       FARG_T6963C_line_y1+0 
	MOVLW       0
	MOVWF       FARG_T6963C_line_y1+1 
	MOVLW       8
	MOVWF       FARG_T6963C_line_pcolor+0 
	CALL        _T6963C_line+0, 0
;grafico.c,337 :: 		T6963C_line(0, 127, 239, 0, T6963C_WHITE);
	CLRF        FARG_T6963C_line_x0+0 
	CLRF        FARG_T6963C_line_x0+1 
	MOVLW       127
	MOVWF       FARG_T6963C_line_y0+0 
	MOVLW       0
	MOVWF       FARG_T6963C_line_y0+1 
	MOVLW       239
	MOVWF       FARG_T6963C_line_x1+0 
	MOVLW       0
	MOVWF       FARG_T6963C_line_x1+1 
	CLRF        FARG_T6963C_line_y1+0 
	CLRF        FARG_T6963C_line_y1+1 
	MOVLW       8
	MOVWF       FARG_T6963C_line_pcolor+0 
	CALL        _T6963C_line+0, 0
;grafico.c,341 :: 		T6963C_box(0, 0, 239, 8, T6963C_WHITE);
	CLRF        FARG_T6963C_box_x0+0 
	CLRF        FARG_T6963C_box_x0+1 
	CLRF        FARG_T6963C_box_y0+0 
	CLRF        FARG_T6963C_box_y0+1 
	MOVLW       239
	MOVWF       FARG_T6963C_box_x1+0 
	MOVLW       0
	MOVWF       FARG_T6963C_box_x1+1 
	MOVLW       8
	MOVWF       FARG_T6963C_box_y1+0 
	MOVLW       0
	MOVWF       FARG_T6963C_box_y1+1 
	MOVLW       8
	MOVWF       FARG_T6963C_box_pcolor+0 
	CALL        _T6963C_box+0, 0
;grafico.c,342 :: 		T6963C_box(0, 119, 239, 127, T6963C_WHITE);
	CLRF        FARG_T6963C_box_x0+0 
	CLRF        FARG_T6963C_box_x0+1 
	MOVLW       119
	MOVWF       FARG_T6963C_box_y0+0 
	MOVLW       0
	MOVWF       FARG_T6963C_box_y0+1 
	MOVLW       239
	MOVWF       FARG_T6963C_box_x1+0 
	MOVLW       0
	MOVWF       FARG_T6963C_box_x1+1 
	MOVLW       127
	MOVWF       FARG_T6963C_box_y1+0 
	MOVLW       0
	MOVWF       FARG_T6963C_box_y1+1 
	MOVLW       8
	MOVWF       FARG_T6963C_box_pcolor+0 
	CALL        _T6963C_box+0, 0
;grafico.c,347 :: 		T6963C_circle(120, 64, 10, T6963C_WHITE);
	MOVLW       120
	MOVWF       FARG_T6963C_circle_x+0 
	MOVLW       0
	MOVWF       FARG_T6963C_circle_x+1 
	MOVLW       64
	MOVWF       FARG_T6963C_circle_y+0 
	MOVLW       0
	MOVWF       FARG_T6963C_circle_y+1 
	MOVLW       10
	MOVWF       FARG_T6963C_circle_r+0 
	MOVLW       0
	MOVWF       FARG_T6963C_circle_r+1 
	MOVWF       FARG_T6963C_circle_r+2 
	MOVWF       FARG_T6963C_circle_r+3 
	MOVLW       8
	MOVWF       FARG_T6963C_circle_pcolor+0 
	CALL        _T6963C_circle+0, 0
;grafico.c,348 :: 		T6963C_circle(120, 64, 30, T6963C_WHITE);
	MOVLW       120
	MOVWF       FARG_T6963C_circle_x+0 
	MOVLW       0
	MOVWF       FARG_T6963C_circle_x+1 
	MOVLW       64
	MOVWF       FARG_T6963C_circle_y+0 
	MOVLW       0
	MOVWF       FARG_T6963C_circle_y+1 
	MOVLW       30
	MOVWF       FARG_T6963C_circle_r+0 
	MOVLW       0
	MOVWF       FARG_T6963C_circle_r+1 
	MOVWF       FARG_T6963C_circle_r+2 
	MOVWF       FARG_T6963C_circle_r+3 
	MOVLW       8
	MOVWF       FARG_T6963C_circle_pcolor+0 
	CALL        _T6963C_circle+0, 0
;grafico.c,349 :: 		T6963C_circle(120, 64, 50, T6963C_WHITE);
	MOVLW       120
	MOVWF       FARG_T6963C_circle_x+0 
	MOVLW       0
	MOVWF       FARG_T6963C_circle_x+1 
	MOVLW       64
	MOVWF       FARG_T6963C_circle_y+0 
	MOVLW       0
	MOVWF       FARG_T6963C_circle_y+1 
	MOVLW       50
	MOVWF       FARG_T6963C_circle_r+0 
	MOVLW       0
	MOVWF       FARG_T6963C_circle_r+1 
	MOVWF       FARG_T6963C_circle_r+2 
	MOVWF       FARG_T6963C_circle_r+3 
	MOVLW       8
	MOVWF       FARG_T6963C_circle_pcolor+0 
	CALL        _T6963C_circle+0, 0
;grafico.c,350 :: 		T6963C_circle(120, 64, 70, T6963C_WHITE);
	MOVLW       120
	MOVWF       FARG_T6963C_circle_x+0 
	MOVLW       0
	MOVWF       FARG_T6963C_circle_x+1 
	MOVLW       64
	MOVWF       FARG_T6963C_circle_y+0 
	MOVLW       0
	MOVWF       FARG_T6963C_circle_y+1 
	MOVLW       70
	MOVWF       FARG_T6963C_circle_r+0 
	MOVLW       0
	MOVWF       FARG_T6963C_circle_r+1 
	MOVWF       FARG_T6963C_circle_r+2 
	MOVWF       FARG_T6963C_circle_r+3 
	MOVLW       8
	MOVWF       FARG_T6963C_circle_pcolor+0 
	CALL        _T6963C_circle+0, 0
;grafico.c,351 :: 		T6963C_circle(120, 64, 90, T6963C_WHITE);
	MOVLW       120
	MOVWF       FARG_T6963C_circle_x+0 
	MOVLW       0
	MOVWF       FARG_T6963C_circle_x+1 
	MOVLW       64
	MOVWF       FARG_T6963C_circle_y+0 
	MOVLW       0
	MOVWF       FARG_T6963C_circle_y+1 
	MOVLW       90
	MOVWF       FARG_T6963C_circle_r+0 
	MOVLW       0
	MOVWF       FARG_T6963C_circle_r+1 
	MOVWF       FARG_T6963C_circle_r+2 
	MOVWF       FARG_T6963C_circle_r+3 
	MOVLW       8
	MOVWF       FARG_T6963C_circle_pcolor+0 
	CALL        _T6963C_circle+0, 0
;grafico.c,352 :: 		T6963C_circle(120, 64, 110, T6963C_WHITE);
	MOVLW       120
	MOVWF       FARG_T6963C_circle_x+0 
	MOVLW       0
	MOVWF       FARG_T6963C_circle_x+1 
	MOVLW       64
	MOVWF       FARG_T6963C_circle_y+0 
	MOVLW       0
	MOVWF       FARG_T6963C_circle_y+1 
	MOVLW       110
	MOVWF       FARG_T6963C_circle_r+0 
	MOVLW       0
	MOVWF       FARG_T6963C_circle_r+1 
	MOVWF       FARG_T6963C_circle_r+2 
	MOVWF       FARG_T6963C_circle_r+3 
	MOVLW       8
	MOVWF       FARG_T6963C_circle_pcolor+0 
	CALL        _T6963C_circle+0, 0
;grafico.c,353 :: 		T6963C_circle(120, 64, 130, T6963C_WHITE);
	MOVLW       120
	MOVWF       FARG_T6963C_circle_x+0 
	MOVLW       0
	MOVWF       FARG_T6963C_circle_x+1 
	MOVLW       64
	MOVWF       FARG_T6963C_circle_y+0 
	MOVLW       0
	MOVWF       FARG_T6963C_circle_y+1 
	MOVLW       130
	MOVWF       FARG_T6963C_circle_r+0 
	MOVLW       0
	MOVWF       FARG_T6963C_circle_r+1 
	MOVWF       FARG_T6963C_circle_r+2 
	MOVWF       FARG_T6963C_circle_r+3 
	MOVLW       8
	MOVWF       FARG_T6963C_circle_pcolor+0 
	CALL        _T6963C_circle+0, 0
;grafico.c,357 :: 		T6963C_setGrPanel(1);                            // Select other graphic panel
	MOVF        _T6963C_txtMemSize+0, 0 
	ADDWF       _T6963C_grMemSize+0, 0 
	MOVWF       _T6963C_grHomeAddr+0 
	MOVF        _T6963C_txtMemSize+1, 0 
	ADDWFC      _T6963C_grMemSize+1, 0 
	MOVWF       _T6963C_grHomeAddr+1 
;grafico.c,359 :: 		for(;;) {                                        // Endless loop
L_main2:
;grafico.c,361 :: 		Opcao = RA3_bit * 2 + RA4_bit;
	CLRF        R3 
	BTFSC       RA3_bit+0, 3 
	INCF        R3, 1 
	MOVF        R3, 0 
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	RLCF        R1, 1 
	RLCF        R2, 1 
	BCF         R1, 0 
	CLRF        R0 
	BTFSC       RA4_bit+0, 4 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       R1, 1 
	MOVLW       0
	ADDWFC      R2, 1 
	MOVF        R1, 0 
	MOVWF       _Opcao+0 
	MOVF        R2, 0 
	MOVWF       _Opcao+1 
;grafico.c,363 :: 		if(Opcao==0) {
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main17
	MOVLW       0
	XORWF       R1, 0 
L__main17:
	BTFSS       STATUS+0, 2 
	GOTO        L_main5
;grafico.c,364 :: 		T6963C_graphics(1);
	BSF         _T6963C_display+0, 3 
	MOVF        _T6963C_display+0, 0 
	MOVWF       FARG_T6963C_writeCommand_mydata+0 
	CALL        _T6963C_writeCommand+0, 0
;grafico.c,365 :: 		T6963C_text(0);
	BCF         _T6963C_display+0, 2 
	MOVF        _T6963C_display+0, 0 
	MOVWF       FARG_T6963C_writeCommand_mydata+0 
	CALL        _T6963C_writeCommand+0, 0
;grafico.c,366 :: 		Delay_ms(300);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       12
	MOVWF       R12, 0
	MOVLW       51
	MOVWF       R13, 0
L_main6:
	DECFSZ      R13, 1, 0
	BRA         L_main6
	DECFSZ      R12, 1, 0
	BRA         L_main6
	DECFSZ      R11, 1, 0
	BRA         L_main6
	NOP
	NOP
;grafico.c,367 :: 		}
	GOTO        L_main7
L_main5:
;grafico.c,368 :: 		else if(Opcao==1) {
	MOVLW       0
	XORWF       _Opcao+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main18
	MOVLW       1
	XORWF       _Opcao+0, 0 
L__main18:
	BTFSS       STATUS+0, 2 
	GOTO        L_main8
;grafico.c,369 :: 		panel++;
	INCF        main_panel_L0+0, 1 
;grafico.c,370 :: 		panel &= 1;
	MOVLW       1
	ANDWF       main_panel_L0+0, 0 
	MOVWF       R4 
	MOVF        R4, 0 
	MOVWF       main_panel_L0+0 
;grafico.c,371 :: 		T6963C_displayGrPanel(panel);
	MOVF        _T6963C_txtMemSize+0, 0 
	ADDWF       _T6963C_grMemSize+0, 0 
	MOVWF       R0 
	MOVF        _T6963C_txtMemSize+1, 0 
	ADDWFC      _T6963C_grMemSize+1, 0 
	MOVWF       R1 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_T6963C_setPtr_p+0 
	MOVF        R1, 0 
	MOVWF       FARG_T6963C_setPtr_p+1 
	MOVLW       66
	MOVWF       FARG_T6963C_setPtr_c+0 
	CALL        _T6963C_setPtr+0, 0
;grafico.c,372 :: 		Delay_ms(300);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       12
	MOVWF       R12, 0
	MOVLW       51
	MOVWF       R13, 0
L_main9:
	DECFSZ      R13, 1, 0
	BRA         L_main9
	DECFSZ      R12, 1, 0
	BRA         L_main9
	DECFSZ      R11, 1, 0
	BRA         L_main9
	NOP
	NOP
;grafico.c,373 :: 		}
	GOTO        L_main10
L_main8:
;grafico.c,374 :: 		else if(Opcao==2) {
	MOVLW       0
	XORWF       _Opcao+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main19
	MOVLW       2
	XORWF       _Opcao+0, 0 
L__main19:
	BTFSS       STATUS+0, 2 
	GOTO        L_main11
;grafico.c,375 :: 		T6963C_graphics(0);
	BCF         _T6963C_display+0, 3 
	MOVF        _T6963C_display+0, 0 
	MOVWF       FARG_T6963C_writeCommand_mydata+0 
	CALL        _T6963C_writeCommand+0, 0
;grafico.c,376 :: 		T6963C_text(1);
	BSF         _T6963C_display+0, 2 
	MOVF        _T6963C_display+0, 0 
	MOVWF       FARG_T6963C_writeCommand_mydata+0 
	CALL        _T6963C_writeCommand+0, 0
;grafico.c,377 :: 		Delay_ms(300);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       12
	MOVWF       R12, 0
	MOVLW       51
	MOVWF       R13, 0
L_main12:
	DECFSZ      R13, 1, 0
	BRA         L_main12
	DECFSZ      R12, 1, 0
	BRA         L_main12
	DECFSZ      R11, 1, 0
	BRA         L_main12
	NOP
	NOP
;grafico.c,378 :: 		}
	GOTO        L_main13
L_main11:
;grafico.c,379 :: 		else if(Opcao==3) {
	MOVLW       0
	XORWF       _Opcao+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main20
	MOVLW       3
	XORWF       _Opcao+0, 0 
L__main20:
	BTFSS       STATUS+0, 2 
	GOTO        L_main14
;grafico.c,380 :: 		T6963C_graphics(1);
	BSF         _T6963C_display+0, 3 
	MOVF        _T6963C_display+0, 0 
	MOVWF       FARG_T6963C_writeCommand_mydata+0 
	CALL        _T6963C_writeCommand+0, 0
;grafico.c,381 :: 		T6963C_text(1);
	BSF         _T6963C_display+0, 2 
	MOVF        _T6963C_display+0, 0 
	MOVWF       FARG_T6963C_writeCommand_mydata+0 
	CALL        _T6963C_writeCommand+0, 0
;grafico.c,382 :: 		Delay_ms(300);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       12
	MOVWF       R12, 0
	MOVLW       51
	MOVWF       R13, 0
L_main15:
	DECFSZ      R13, 1, 0
	BRA         L_main15
	DECFSZ      R12, 1, 0
	BRA         L_main15
	DECFSZ      R11, 1, 0
	BRA         L_main15
	NOP
	NOP
;grafico.c,383 :: 		}
L_main14:
L_main13:
L_main10:
L_main7:
;grafico.c,384 :: 		delay_ms(2000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main16:
	DECFSZ      R13, 1, 0
	BRA         L_main16
	DECFSZ      R12, 1, 0
	BRA         L_main16
	DECFSZ      R11, 1, 0
	BRA         L_main16
	NOP
;grafico.c,385 :: 		}
	GOTO        L_main2
;grafico.c,386 :: 		}
	GOTO        $+0
; end of _main
