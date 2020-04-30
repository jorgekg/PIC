
_Pula_Linha:

;keyboard-micro.c,50 :: 		void Pula_Linha(void)
;keyboard-micro.c,52 :: 		UART1_WRITE(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;keyboard-micro.c,53 :: 		UART1_WRITE(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;keyboard-micro.c,54 :: 		}
	RETURN      0
; end of _Pula_Linha

_Move_Delay:

;keyboard-micro.c,58 :: 		void Move_Delay() {                  // Function used for text moving
;keyboard-micro.c,59 :: 		Delay_ms(100);                     // You can change the moving speed here
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_Move_Delay0:
	DECFSZ      R13, 1, 0
	BRA         L_Move_Delay0
	DECFSZ      R12, 1, 0
	BRA         L_Move_Delay0
	DECFSZ      R11, 1, 0
	BRA         L_Move_Delay0
	NOP
;keyboard-micro.c,60 :: 		}
	RETURN      0
; end of _Move_Delay

_CustomChar:

;keyboard-micro.c,69 :: 		void CustomChar() {
;keyboard-micro.c,71 :: 		LCD_Cmd(64); //entra na CGRAM
	MOVLW       64
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;keyboard-micro.c,72 :: 		for (i = 0; i<=7; i++) LCD_Chr_Cp(character_0[i]); //grava 8 bytes na cgram ENDER 0 a 7  cgram
	CLRF        CustomChar_i_L0+0 
L_CustomChar1:
	MOVF        CustomChar_i_L0+0, 0 
	SUBLW       7
	BTFSS       STATUS+0, 0 
	GOTO        L_CustomChar2
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
	GOTO        L_CustomChar1
L_CustomChar2:
;keyboard-micro.c,73 :: 		for (i = 0; i<=7; i++) LCD_Chr_Cp(character_1[i]); //grava 8 bytes na cgram ENDER 8 a 15 cgram
	CLRF        CustomChar_i_L0+0 
L_CustomChar4:
	MOVF        CustomChar_i_L0+0, 0 
	SUBLW       7
	BTFSS       STATUS+0, 0 
	GOTO        L_CustomChar5
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
	GOTO        L_CustomChar4
L_CustomChar5:
;keyboard-micro.c,74 :: 		LCD_Cmd(_LCD_RETURN_HOME); //sai da cgram
	MOVLW       2
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;keyboard-micro.c,75 :: 		}
	RETURN      0
; end of _CustomChar

_Alert:

;keyboard-micro.c,79 :: 		void Alert()
;keyboard-micro.c,85 :: 		for(i=0; i<1; i++) {               // Move text to the right 4 times
	CLRF        Alert_i_L0+0 
	CLRF        Alert_i_L0+1 
L_Alert7:
	MOVLW       128
	XORWF       Alert_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Alert92
	MOVLW       1
	SUBWF       Alert_i_L0+0, 0 
L__Alert92:
	BTFSC       STATUS+0, 0 
	GOTO        L_Alert8
;keyboard-micro.c,86 :: 		Lcd_Cmd(_LCD_SHIFT_RIGHT);
	MOVLW       28
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;keyboard-micro.c,87 :: 		Move_Delay();
	CALL        _Move_Delay+0, 0
;keyboard-micro.c,85 :: 		for(i=0; i<1; i++) {               // Move text to the right 4 times
	INFSNZ      Alert_i_L0+0, 1 
	INCF        Alert_i_L0+1, 1 
;keyboard-micro.c,88 :: 		}
	GOTO        L_Alert7
L_Alert8:
;keyboard-micro.c,89 :: 		for(i=0; i<1; i++) {               // Move text to the left 4 times
	CLRF        Alert_i_L0+0 
	CLRF        Alert_i_L0+1 
L_Alert10:
	MOVLW       128
	XORWF       Alert_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Alert93
	MOVLW       1
	SUBWF       Alert_i_L0+0, 0 
L__Alert93:
	BTFSC       STATUS+0, 0 
	GOTO        L_Alert11
;keyboard-micro.c,90 :: 		Lcd_Cmd(_LCD_SHIFT_LEFT);
	MOVLW       24
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;keyboard-micro.c,91 :: 		Move_Delay();
	CALL        _Move_Delay+0, 0
;keyboard-micro.c,89 :: 		for(i=0; i<1; i++) {               // Move text to the left 4 times
	INFSNZ      Alert_i_L0+0, 1 
	INCF        Alert_i_L0+1, 1 
;keyboard-micro.c,92 :: 		}
	GOTO        L_Alert10
L_Alert11:
;keyboard-micro.c,96 :: 		}
	RETURN      0
; end of _Alert

_Write_RTC:

;keyboard-micro.c,100 :: 		void Write_RTC(int END, int DADO)
;keyboard-micro.c,102 :: 		I2C1_Start();           // issue I2C start signal
	CALL        _I2C1_Start+0, 0
;keyboard-micro.c,103 :: 		I2C1_Wr(0xD0);          // send byte via I2C  (device address + W)
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;keyboard-micro.c,104 :: 		I2C1_Wr(END);             // send byte (address of EEPROM location)
	MOVF        FARG_Write_RTC_END+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;keyboard-micro.c,105 :: 		I2C1_Wr(DADO);          // send data (data to be written)
	MOVF        FARG_Write_RTC_DADO+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;keyboard-micro.c,106 :: 		I2C1_Stop();            // issue I2C stop signal
	CALL        _I2C1_Stop+0, 0
;keyboard-micro.c,107 :: 		}
	RETURN      0
; end of _Write_RTC

_Read_RTC:

;keyboard-micro.c,111 :: 		int Read_RTC(int END)
;keyboard-micro.c,117 :: 		I2C1_Start();           // issue I2C start signal
	CALL        _I2C1_Start+0, 0
;keyboard-micro.c,118 :: 		I2C1_Wr(0xD0);          // send byte via I2C  (device address + W)
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;keyboard-micro.c,119 :: 		I2C1_Wr(END);             // send byte (data address)
	MOVF        FARG_Read_RTC_END+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;keyboard-micro.c,120 :: 		I2C1_Repeated_Start();  // issue I2C signal repeated start
	CALL        _I2C1_Repeated_Start+0, 0
;keyboard-micro.c,121 :: 		I2C1_Wr(0xD1);          // send byte (device address + R)
	MOVLW       209
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;keyboard-micro.c,122 :: 		Dado = I2C1_Rd(0u);    // Read the data (NO acknowledge)
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       Read_RTC_Dado_L0+0 
	MOVLW       0
	MOVWF       Read_RTC_Dado_L0+1 
;keyboard-micro.c,123 :: 		I2C1_Stop();            // issue I2C stop signal
	CALL        _I2C1_Stop+0, 0
;keyboard-micro.c,124 :: 		return(Dado);
	MOVF        Read_RTC_Dado_L0+0, 0 
	MOVWF       R0 
	MOVF        Read_RTC_Dado_L0+1, 0 
	MOVWF       R1 
;keyboard-micro.c,125 :: 		}
	RETURN      0
; end of _Read_RTC

_Transform_Time:

;keyboard-micro.c,127 :: 		void Transform_Time(char *sec, char *min, char *hr) {
;keyboard-micro.c,128 :: 		*sec = ((*sec & 0xF0) >> 4)*10 + (*sec & 0x0F);
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
;keyboard-micro.c,129 :: 		*min = ((*min & 0xF0) >> 4)*10 + (*min & 0x0F);
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
;keyboard-micro.c,130 :: 		*hr = ((*hr & 0xF0) >> 4)*10 + (*hr & 0x0F);
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
;keyboard-micro.c,131 :: 		}
	RETURN      0
; end of _Transform_Time

_Write_EEPROM:

;keyboard-micro.c,133 :: 		void Write_EEPROM(int END, int DADO)
;keyboard-micro.c,135 :: 		I2C1_Start();           // issue I2C start signal
	CALL        _I2C1_Start+0, 0
;keyboard-micro.c,136 :: 		I2C1_Wr(0xA0);          // send byte via I2C  (device address + W)
	MOVLW       160
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;keyboard-micro.c,137 :: 		I2C1_Wr(END);             // send byte (address of EEPROM location)
	MOVF        FARG_Write_EEPROM_END+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;keyboard-micro.c,138 :: 		I2C1_Wr(DADO);          // send data (data to be written)
	MOVF        FARG_Write_EEPROM_DADO+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;keyboard-micro.c,139 :: 		I2C1_Stop();            // issue I2C stop signal
	CALL        _I2C1_Stop+0, 0
;keyboard-micro.c,140 :: 		delay_ms(10);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_Write_EEPROM13:
	DECFSZ      R13, 1, 0
	BRA         L_Write_EEPROM13
	DECFSZ      R12, 1, 0
	BRA         L_Write_EEPROM13
	NOP
;keyboard-micro.c,141 :: 		}
	RETURN      0
; end of _Write_EEPROM

_Read_EEPROM:

;keyboard-micro.c,143 :: 		int Read_EEPROM(int END)
;keyboard-micro.c,146 :: 		I2C1_Start();           // issue I2C start signal
	CALL        _I2C1_Start+0, 0
;keyboard-micro.c,147 :: 		I2C1_Wr(0xA0);          // send byte via I2C  (device address + W)
	MOVLW       160
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;keyboard-micro.c,148 :: 		I2C1_Wr(END);             // send byte (data address)
	MOVF        FARG_Read_EEPROM_END+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;keyboard-micro.c,149 :: 		I2C1_Repeated_Start();  // issue I2C signal repeated start
	CALL        _I2C1_Repeated_Start+0, 0
;keyboard-micro.c,150 :: 		I2C1_Wr(0xA1);          // send byte (device address + R)
	MOVLW       161
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;keyboard-micro.c,151 :: 		Dado = I2C1_Rd(0u);    // Read the data (NO acknowledge)
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       Read_EEPROM_Dado_L0+0 
	MOVLW       0
	MOVWF       Read_EEPROM_Dado_L0+1 
;keyboard-micro.c,152 :: 		I2C1_Stop();            // issue I2C stop signal
	CALL        _I2C1_Stop+0, 0
;keyboard-micro.c,153 :: 		return(Dado);
	MOVF        Read_EEPROM_Dado_L0+0, 0 
	MOVWF       R0 
	MOVF        Read_EEPROM_Dado_L0+1, 0 
	MOVWF       R1 
;keyboard-micro.c,154 :: 		}
	RETURN      0
; end of _Read_EEPROM

_Le_Teclado:

;keyboard-micro.c,158 :: 		short Le_Teclado()
;keyboard-micro.c,160 :: 		PORTD = 0B00010000; // VOCÊ SELECIONOU LA
	MOVLW       16
	MOVWF       PORTD+0 
;keyboard-micro.c,161 :: 		if (PORTB.RB0 == 1) {while(PORTB.RB0==1); return '7';};
	BTFSS       PORTB+0, 0 
	GOTO        L_Le_Teclado14
L_Le_Teclado15:
	BTFSS       PORTB+0, 0 
	GOTO        L_Le_Teclado16
	GOTO        L_Le_Teclado15
L_Le_Teclado16:
	MOVLW       55
	MOVWF       R0 
	RETURN      0
L_Le_Teclado14:
;keyboard-micro.c,162 :: 		if (PORTB.RB1 == 1) {while(PORTB.RB1==1); return '8';};
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado17
L_Le_Teclado18:
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado19
	GOTO        L_Le_Teclado18
L_Le_Teclado19:
	MOVLW       56
	MOVWF       R0 
	RETURN      0
L_Le_Teclado17:
;keyboard-micro.c,163 :: 		if (PORTB.RB2 == 1) {while(PORTB.RB2==1); return '9';};
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado20
L_Le_Teclado21:
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado22
	GOTO        L_Le_Teclado21
L_Le_Teclado22:
	MOVLW       57
	MOVWF       R0 
	RETURN      0
L_Le_Teclado20:
;keyboard-micro.c,164 :: 		if (PORTB.RB3 == 1) {while(PORTB.RB3==1); return '%';};
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado23
L_Le_Teclado24:
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado25
	GOTO        L_Le_Teclado24
L_Le_Teclado25:
	MOVLW       37
	MOVWF       R0 
	RETURN      0
L_Le_Teclado23:
;keyboard-micro.c,168 :: 		PORTD = 0B00100000; // VOCÊ SELECIONOU LB
	MOVLW       32
	MOVWF       PORTD+0 
;keyboard-micro.c,169 :: 		if (PORTB.RB0 == 1) {while(PORTB.RB0==1);return '4';};
	BTFSS       PORTB+0, 0 
	GOTO        L_Le_Teclado26
L_Le_Teclado27:
	BTFSS       PORTB+0, 0 
	GOTO        L_Le_Teclado28
	GOTO        L_Le_Teclado27
L_Le_Teclado28:
	MOVLW       52
	MOVWF       R0 
	RETURN      0
L_Le_Teclado26:
;keyboard-micro.c,170 :: 		if (PORTB.RB1 == 1) {while(PORTB.RB1==1);return '5';};
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado29
L_Le_Teclado30:
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado31
	GOTO        L_Le_Teclado30
L_Le_Teclado31:
	MOVLW       53
	MOVWF       R0 
	RETURN      0
L_Le_Teclado29:
;keyboard-micro.c,171 :: 		if (PORTB.RB2 == 1) {while(PORTB.RB2==1);return '6';};
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado32
L_Le_Teclado33:
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado34
	GOTO        L_Le_Teclado33
L_Le_Teclado34:
	MOVLW       54
	MOVWF       R0 
	RETURN      0
L_Le_Teclado32:
;keyboard-micro.c,172 :: 		if (PORTB.RB3 == 1) {while(PORTB.RB3==1);return '*';};
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado35
L_Le_Teclado36:
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado37
	GOTO        L_Le_Teclado36
L_Le_Teclado37:
	MOVLW       42
	MOVWF       R0 
	RETURN      0
L_Le_Teclado35:
;keyboard-micro.c,176 :: 		PORTD = 0B01000000; // VOCÊ SELECIONOU LC
	MOVLW       64
	MOVWF       PORTD+0 
;keyboard-micro.c,177 :: 		if (PORTB.RB0 == 1) {while(PORTB.RB0==1);return '1';};
	BTFSS       PORTB+0, 0 
	GOTO        L_Le_Teclado38
L_Le_Teclado39:
	BTFSS       PORTB+0, 0 
	GOTO        L_Le_Teclado40
	GOTO        L_Le_Teclado39
L_Le_Teclado40:
	MOVLW       49
	MOVWF       R0 
	RETURN      0
L_Le_Teclado38:
;keyboard-micro.c,178 :: 		if (PORTB.RB1 == 1) {while(PORTB.RB1==1);return '2';};
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado41
L_Le_Teclado42:
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado43
	GOTO        L_Le_Teclado42
L_Le_Teclado43:
	MOVLW       50
	MOVWF       R0 
	RETURN      0
L_Le_Teclado41:
;keyboard-micro.c,179 :: 		if (PORTB.RB2 == 1) {while(PORTB.RB2==1);return '3';};
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado44
L_Le_Teclado45:
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado46
	GOTO        L_Le_Teclado45
L_Le_Teclado46:
	MOVLW       51
	MOVWF       R0 
	RETURN      0
L_Le_Teclado44:
;keyboard-micro.c,180 :: 		if (PORTB.RB3 == 1) {while(PORTB.RB3==1);return '-';};
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado47
L_Le_Teclado48:
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado49
	GOTO        L_Le_Teclado48
L_Le_Teclado49:
	MOVLW       45
	MOVWF       R0 
	RETURN      0
L_Le_Teclado47:
;keyboard-micro.c,184 :: 		PORTD = 0B10000000; // VOCÊ SELECIONOU LD
	MOVLW       128
	MOVWF       PORTD+0 
;keyboard-micro.c,185 :: 		if (PORTB.RB0 == 1) {while(PORTB.RB0==1);return 'C';};
	BTFSS       PORTB+0, 0 
	GOTO        L_Le_Teclado50
L_Le_Teclado51:
	BTFSS       PORTB+0, 0 
	GOTO        L_Le_Teclado52
	GOTO        L_Le_Teclado51
L_Le_Teclado52:
	MOVLW       67
	MOVWF       R0 
	RETURN      0
L_Le_Teclado50:
;keyboard-micro.c,186 :: 		if (PORTB.RB1 == 1) {while(PORTB.RB1==1);return '0';};
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado53
L_Le_Teclado54:
	BTFSS       PORTB+0, 1 
	GOTO        L_Le_Teclado55
	GOTO        L_Le_Teclado54
L_Le_Teclado55:
	MOVLW       48
	MOVWF       R0 
	RETURN      0
L_Le_Teclado53:
;keyboard-micro.c,187 :: 		if (PORTB.RB2 == 1) {while(PORTB.RB2==1);return '=';};
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado56
L_Le_Teclado57:
	BTFSS       PORTB+0, 2 
	GOTO        L_Le_Teclado58
	GOTO        L_Le_Teclado57
L_Le_Teclado58:
	MOVLW       61
	MOVWF       R0 
	RETURN      0
L_Le_Teclado56:
;keyboard-micro.c,188 :: 		if (PORTB.RB3 == 1) {while(PORTB.RB3==1);return '+';};
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado59
L_Le_Teclado60:
	BTFSS       PORTB+0, 3 
	GOTO        L_Le_Teclado61
	GOTO        L_Le_Teclado60
L_Le_Teclado61:
	MOVLW       43
	MOVWF       R0 
	RETURN      0
L_Le_Teclado59:
;keyboard-micro.c,192 :: 		return 255;
	MOVLW       255
	MOVWF       R0 
;keyboard-micro.c,193 :: 		}
	RETURN      0
; end of _Le_Teclado

_main:

;keyboard-micro.c,207 :: 		void main()
;keyboard-micro.c,209 :: 		UART1_Init(19200);
	MOVLW       25
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;keyboard-micro.c,211 :: 		I2C1_Init(100000);// i2c para acessar ID = D0h  = RTC
	MOVLW       20
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;keyboard-micro.c,213 :: 		ADCON1=0B00001110;
	MOVLW       14
	MOVWF       ADCON1+0 
;keyboard-micro.c,214 :: 		TRISB = 0B00001111;
	MOVLW       15
	MOVWF       TRISB+0 
;keyboard-micro.c,215 :: 		PORTB = 0B00000000;
	CLRF        PORTB+0 
;keyboard-micro.c,216 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;keyboard-micro.c,217 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;keyboard-micro.c,218 :: 		CustomChar();
	CALL        _CustomChar+0, 0
;keyboard-micro.c,219 :: 		Lcd_Out(1, 2, "Digite a senha");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_keyboard_45micro+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_keyboard_45micro+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;keyboard-micro.c,220 :: 		while(1)
L_main62:
;keyboard-micro.c,222 :: 		Tecla2 = Le_Teclado() ;
	CALL        _Le_Teclado+0, 0
	MOVF        R0, 0 
	MOVWF       _Tecla2+0 
;keyboard-micro.c,223 :: 		if(!(Tecla2==255)) {
	MOVF        R0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_main64
;keyboard-micro.c,224 :: 		pass = Tecla2;
	MOVF        _Tecla2+0, 0 
	MOVWF       _pass+0 
;keyboard-micro.c,225 :: 		break;
	GOTO        L_main63
;keyboard-micro.c,226 :: 		}
L_main64:
;keyboard-micro.c,227 :: 		}
	GOTO        L_main62
L_main63:
;keyboard-micro.c,228 :: 		if (pass == '0') {
	MOVLW       0
	BTFSC       _pass+0, 7 
	MOVLW       255
	MOVWF       R0 
	MOVLW       0
	XORWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main94
	MOVLW       48
	XORWF       _pass+0, 0 
L__main94:
	BTFSS       STATUS+0, 2 
	GOTO        L_main65
;keyboard-micro.c,229 :: 		Write_EEPROM(0, 0xFF);
	CLRF        FARG_Write_EEPROM_END+0 
	CLRF        FARG_Write_EEPROM_END+1 
	MOVLW       255
	MOVWF       FARG_Write_EEPROM_DADO+0 
	MOVLW       0
	MOVWF       FARG_Write_EEPROM_DADO+1 
	CALL        _Write_EEPROM+0, 0
;keyboard-micro.c,230 :: 		Write_EEPROM(1, 0xFF);
	MOVLW       1
	MOVWF       FARG_Write_EEPROM_END+0 
	MOVLW       0
	MOVWF       FARG_Write_EEPROM_END+1 
	MOVLW       255
	MOVWF       FARG_Write_EEPROM_DADO+0 
	MOVLW       0
	MOVWF       FARG_Write_EEPROM_DADO+1 
	CALL        _Write_EEPROM+0, 0
;keyboard-micro.c,231 :: 		Write_EEPROM(2, 0xFF);
	MOVLW       2
	MOVWF       FARG_Write_EEPROM_END+0 
	MOVLW       0
	MOVWF       FARG_Write_EEPROM_END+1 
	MOVLW       255
	MOVWF       FARG_Write_EEPROM_DADO+0 
	MOVLW       0
	MOVWF       FARG_Write_EEPROM_DADO+1 
	CALL        _Write_EEPROM+0, 0
;keyboard-micro.c,232 :: 		}
L_main65:
;keyboard-micro.c,234 :: 		if (Read_EEPROM(1) == 0xFF) {
	MOVLW       1
	MOVWF       FARG_Read_EEPROM_END+0 
	MOVLW       0
	MOVWF       FARG_Read_EEPROM_END+1 
	CALL        _Read_EEPROM+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main95
	MOVLW       255
	XORWF       R0, 0 
L__main95:
	BTFSS       STATUS+0, 2 
	GOTO        L_main66
;keyboard-micro.c,235 :: 		Lcd_Out(1, 2, "HORARIO MONITORAR");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_keyboard_45micro+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_keyboard_45micro+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;keyboard-micro.c,236 :: 		while(1)
L_main67:
;keyboard-micro.c,238 :: 		Tecla = Le_Teclado() ;
	CALL        _Le_Teclado+0, 0
	MOVF        R0, 0 
	MOVWF       _Tecla+0 
;keyboard-micro.c,239 :: 		if (Tecla == '=') {
	MOVF        R0, 0 
	XORLW       61
	BTFSS       STATUS+0, 2 
	GOTO        L_main69
;keyboard-micro.c,240 :: 		break;
	GOTO        L_main68
;keyboard-micro.c,241 :: 		}
L_main69:
;keyboard-micro.c,242 :: 		if (Tecla == '-') {
	MOVF        _Tecla+0, 0 
	XORLW       45
	BTFSS       STATUS+0, 2 
	GOTO        L_main70
;keyboard-micro.c,243 :: 		tempHoras[iteracao] = ':';
	MOVLW       _tempHoras+0
	ADDWF       _iteracao+0, 0 
	MOVWF       FSR1L 
	MOVLW       hi_addr(_tempHoras+0)
	ADDWFC      _iteracao+1, 0 
	MOVWF       FSR1H 
	MOVLW       58
	MOVWF       POSTINC1+0 
;keyboard-micro.c,244 :: 		iteracao = iteracao + 1;
	INFSNZ      _iteracao+0, 1 
	INCF        _iteracao+1, 1 
;keyboard-micro.c,245 :: 		lcd_Out(2, 5, tempTeclas);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _tempTeclas+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_tempTeclas+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;keyboard-micro.c,246 :: 		continue;
	GOTO        L_main67
;keyboard-micro.c,247 :: 		}
L_main70:
;keyboard-micro.c,248 :: 		if (Tecla == '*') {
	MOVF        _Tecla+0, 0 
	XORLW       42
	BTFSS       STATUS+0, 2 
	GOTO        L_main71
;keyboard-micro.c,249 :: 		tempHoras[iteracao] = ' ';
	MOVLW       _tempHoras+0
	ADDWF       _iteracao+0, 0 
	MOVWF       FSR1L 
	MOVLW       hi_addr(_tempHoras+0)
	ADDWFC      _iteracao+1, 0 
	MOVWF       FSR1H 
	MOVLW       32
	MOVWF       POSTINC1+0 
;keyboard-micro.c,250 :: 		iteracao = iteracao - 1;
	MOVLW       1
	SUBWF       _iteracao+0, 1 
	MOVLW       0
	SUBWFB      _iteracao+1, 1 
;keyboard-micro.c,251 :: 		lcd_Out(2, 5, tempHoras);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _tempHoras+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_tempHoras+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;keyboard-micro.c,252 :: 		continue;
	GOTO        L_main67
;keyboard-micro.c,253 :: 		}
L_main71:
;keyboard-micro.c,254 :: 		if(!(Tecla==255)) {
	MOVF        _Tecla+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_main72
;keyboard-micro.c,255 :: 		tempHoras[iteracao] = Tecla;
	MOVLW       _tempHoras+0
	ADDWF       _iteracao+0, 0 
	MOVWF       FSR1L 
	MOVLW       hi_addr(_tempHoras+0)
	ADDWFC      _iteracao+1, 0 
	MOVWF       FSR1H 
	MOVF        _Tecla+0, 0 
	MOVWF       POSTINC1+0 
;keyboard-micro.c,256 :: 		iteracao = iteracao + 1;
	INFSNZ      _iteracao+0, 1 
	INCF        _iteracao+1, 1 
;keyboard-micro.c,257 :: 		}
L_main72:
;keyboard-micro.c,258 :: 		lcd_Out(2, 5, tempHoras);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _tempHoras+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_tempHoras+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;keyboard-micro.c,259 :: 		}
	GOTO        L_main67
L_main68:
;keyboard-micro.c,261 :: 		TIME[0] = tempHoras[0];
	MOVF        _tempHoras+0, 0 
	MOVWF       _TIME+0 
;keyboard-micro.c,262 :: 		TIME[1] = tempHoras[1];
	MOVF        _tempHoras+1, 0 
	MOVWF       _TIME+1 
;keyboard-micro.c,263 :: 		TIME[2] = tempHoras[2];
	MOVF        _tempHoras+2, 0 
	MOVWF       _TIME+2 
;keyboard-micro.c,264 :: 		TIME[3] = tempHoras[3];
	MOVF        _tempHoras+3, 0 
	MOVWF       _TIME+3 
;keyboard-micro.c,265 :: 		TIME[4] = tempHoras[4];
	MOVF        _tempHoras+4, 0 
	MOVWF       _TIME+4 
;keyboard-micro.c,266 :: 		t3[0] = tempHoras[0];
	MOVF        _tempHoras+0, 0 
	MOVWF       _t3+0 
;keyboard-micro.c,267 :: 		t[0] = t3[0];
	MOVF        _tempHoras+0, 0 
	MOVWF       _t+0 
;keyboard-micro.c,268 :: 		t3[0] = tempHoras[1];
	MOVF        _tempHoras+1, 0 
	MOVWF       _t3+0 
;keyboard-micro.c,269 :: 		t[1] = t3[0];
	MOVF        _tempHoras+1, 0 
	MOVWF       _t+1 
;keyboard-micro.c,270 :: 		hhht=atoi(t);
	MOVLW       _t+0
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(_t+0)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _hhht+0 
	MOVF        R1, 0 
	MOVWF       _hhht+1 
;keyboard-micro.c,271 :: 		Write_EEPROM(1, hhht);
	MOVLW       1
	MOVWF       FARG_Write_EEPROM_END+0 
	MOVLW       0
	MOVWF       FARG_Write_EEPROM_END+1 
	MOVF        R0, 0 
	MOVWF       FARG_Write_EEPROM_DADO+0 
	MOVF        R1, 0 
	MOVWF       FARG_Write_EEPROM_DADO+1 
	CALL        _Write_EEPROM+0, 0
;keyboard-micro.c,272 :: 		t2[0] = TIME[3];
	MOVF        _TIME+3, 0 
	MOVWF       _t2+0 
;keyboard-micro.c,273 :: 		t2[1] = TIME[4];
	MOVF        _TIME+4, 0 
	MOVWF       _t2+1 
;keyboard-micro.c,274 :: 		mmmt2=atoi(t2);
	MOVLW       _t2+0
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(_t2+0)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _mmmt2+0 
	MOVF        R1, 0 
	MOVWF       _mmmt2+1 
;keyboard-micro.c,275 :: 		Write_EEPROM(2,mmmt2);
	MOVLW       2
	MOVWF       FARG_Write_EEPROM_END+0 
	MOVLW       0
	MOVWF       FARG_Write_EEPROM_END+1 
	MOVF        R0, 0 
	MOVWF       FARG_Write_EEPROM_DADO+0 
	MOVF        R1, 0 
	MOVWF       FARG_Write_EEPROM_DADO+1 
	CALL        _Write_EEPROM+0, 0
;keyboard-micro.c,276 :: 		} else {
	GOTO        L_main73
L_main66:
;keyboard-micro.c,277 :: 		hhht = Read_EEPROM(1);
	MOVLW       1
	MOVWF       FARG_Read_EEPROM_END+0 
	MOVLW       0
	MOVWF       FARG_Read_EEPROM_END+1 
	CALL        _Read_EEPROM+0, 0
	MOVF        R0, 0 
	MOVWF       _hhht+0 
	MOVF        R1, 0 
	MOVWF       _hhht+1 
;keyboard-micro.c,278 :: 		IntToStr(hhht, tzao);
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _tzao+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_tzao+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;keyboard-micro.c,279 :: 		TIME[0] = tzao[4];
	MOVF        _tzao+4, 0 
	MOVWF       _TIME+0 
;keyboard-micro.c,280 :: 		TIME[1] = tzao[5];
	MOVF        _tzao+5, 0 
	MOVWF       _TIME+1 
;keyboard-micro.c,281 :: 		TIME[2] = ':';
	MOVLW       58
	MOVWF       _TIME+2 
;keyboard-micro.c,282 :: 		mmmt2 = Read_EEPROM(2);
	MOVLW       2
	MOVWF       FARG_Read_EEPROM_END+0 
	MOVLW       0
	MOVWF       FARG_Read_EEPROM_END+1 
	CALL        _Read_EEPROM+0, 0
	MOVF        R0, 0 
	MOVWF       _mmmt2+0 
	MOVF        R1, 0 
	MOVWF       _mmmt2+1 
;keyboard-micro.c,283 :: 		if (mmmt < 10) {
	MOVLW       128
	XORWF       _mmmt+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main96
	MOVLW       10
	SUBWF       _mmmt+0, 0 
L__main96:
	BTFSC       STATUS+0, 0 
	GOTO        L_main74
;keyboard-micro.c,284 :: 		TIME[3] = '0';
	MOVLW       48
	MOVWF       _TIME+3 
;keyboard-micro.c,285 :: 		TIME[4] = tzao[4];
	MOVF        _tzao+4, 0 
	MOVWF       _TIME+4 
;keyboard-micro.c,286 :: 		} else {
	GOTO        L_main75
L_main74:
;keyboard-micro.c,287 :: 		TIME[3] = tzao[4];
	MOVF        _tzao+4, 0 
	MOVWF       _TIME+3 
;keyboard-micro.c,288 :: 		TIME[4] = tzao[5];
	MOVF        _tzao+5, 0 
	MOVWF       _TIME+4 
;keyboard-micro.c,289 :: 		}
L_main75:
;keyboard-micro.c,290 :: 		}
L_main73:
;keyboard-micro.c,291 :: 		if (Read_EEPROM(0) == 0xFF) {
	CLRF        FARG_Read_EEPROM_END+0 
	CLRF        FARG_Read_EEPROM_END+1 
	CALL        _Read_EEPROM+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main97
	MOVLW       255
	XORWF       R0, 0 
L__main97:
	BTFSS       STATUS+0, 2 
	GOTO        L_main76
;keyboard-micro.c,292 :: 		iteracao = 0;
	CLRF        _iteracao+0 
	CLRF        _iteracao+1 
;keyboard-micro.c,293 :: 		tempTeclas[0] = ' ';
	MOVLW       32
	MOVWF       _tempTeclas+0 
;keyboard-micro.c,294 :: 		tempTeclas[1] = ' ';
	MOVLW       32
	MOVWF       _tempTeclas+1 
;keyboard-micro.c,295 :: 		tempTeclas[2] = ' ';
	MOVLW       32
	MOVWF       _tempTeclas+2 
;keyboard-micro.c,296 :: 		tempTeclas[3] = ' ';
	MOVLW       32
	MOVWF       _tempTeclas+3 
;keyboard-micro.c,297 :: 		tempTeclas[4] = ' ';
	MOVLW       32
	MOVWF       _tempTeclas+4 
;keyboard-micro.c,298 :: 		lcd_Out(2, 5, tempTeclas);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _tempTeclas+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_tempTeclas+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;keyboard-micro.c,299 :: 		Lcd_Out(1, 2, "TEMPERATURA MAXIMA");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_keyboard_45micro+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_keyboard_45micro+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;keyboard-micro.c,300 :: 		while(1)
L_main77:
;keyboard-micro.c,302 :: 		Tecla = Le_Teclado() ;
	CALL        _Le_Teclado+0, 0
	MOVF        R0, 0 
	MOVWF       _Tecla+0 
;keyboard-micro.c,303 :: 		if (Tecla == '=') {
	MOVF        R0, 0 
	XORLW       61
	BTFSS       STATUS+0, 2 
	GOTO        L_main79
;keyboard-micro.c,304 :: 		break;
	GOTO        L_main78
;keyboard-micro.c,305 :: 		}
L_main79:
;keyboard-micro.c,306 :: 		if (Tecla == '*') {
	MOVF        _Tecla+0, 0 
	XORLW       42
	BTFSS       STATUS+0, 2 
	GOTO        L_main80
;keyboard-micro.c,307 :: 		tempTeclas[iteracao] = ' ';
	MOVLW       _tempTeclas+0
	ADDWF       _iteracao+0, 0 
	MOVWF       FSR1L 
	MOVLW       hi_addr(_tempTeclas+0)
	ADDWFC      _iteracao+1, 0 
	MOVWF       FSR1H 
	MOVLW       32
	MOVWF       POSTINC1+0 
;keyboard-micro.c,308 :: 		iteracao = iteracao - 1;
	MOVLW       1
	SUBWF       _iteracao+0, 1 
	MOVLW       0
	SUBWFB      _iteracao+1, 1 
;keyboard-micro.c,309 :: 		lcd_Out(2, 5, tempTeclas);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _tempTeclas+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_tempTeclas+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;keyboard-micro.c,310 :: 		continue;
	GOTO        L_main77
;keyboard-micro.c,311 :: 		}
L_main80:
;keyboard-micro.c,312 :: 		if(!(Tecla==255)) {
	MOVF        _Tecla+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_main81
;keyboard-micro.c,313 :: 		tempTeclas[iteracao] = Tecla;
	MOVLW       _tempTeclas+0
	ADDWF       _iteracao+0, 0 
	MOVWF       FSR1L 
	MOVLW       hi_addr(_tempTeclas+0)
	ADDWFC      _iteracao+1, 0 
	MOVWF       FSR1H 
	MOVF        _Tecla+0, 0 
	MOVWF       POSTINC1+0 
;keyboard-micro.c,314 :: 		iteracao = iteracao + 1;
	INFSNZ      _iteracao+0, 1 
	INCF        _iteracao+1, 1 
;keyboard-micro.c,315 :: 		}
L_main81:
;keyboard-micro.c,316 :: 		lcd_Out(2, 5, tempTeclas);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _tempTeclas+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_tempTeclas+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;keyboard-micro.c,317 :: 		}
	GOTO        L_main77
L_main78:
;keyboard-micro.c,318 :: 		temAtual=atoi(tempTeclas);
	MOVLW       _tempTeclas+0
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(_tempTeclas+0)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _temAtual+0 
	MOVF        R1, 0 
	MOVWF       _temAtual+1 
;keyboard-micro.c,319 :: 		tempTeclas[0] = ' ';
	MOVLW       32
	MOVWF       _tempTeclas+0 
;keyboard-micro.c,320 :: 		tempTeclas[1] = ' ';
	MOVLW       32
	MOVWF       _tempTeclas+1 
;keyboard-micro.c,321 :: 		tempTeclas[2] = ' ';
	MOVLW       32
	MOVWF       _tempTeclas+2 
;keyboard-micro.c,322 :: 		tempTeclas[3] = ' ';
	MOVLW       32
	MOVWF       _tempTeclas+3 
;keyboard-micro.c,323 :: 		tempTeclas[4] = ' ';
	MOVLW       32
	MOVWF       _tempTeclas+4 
;keyboard-micro.c,324 :: 		lcd_Out(2, 5, tempTeclas);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _tempTeclas+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_tempTeclas+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;keyboard-micro.c,325 :: 		Write_EEPROM(0, temAtual);
	CLRF        FARG_Write_EEPROM_END+0 
	CLRF        FARG_Write_EEPROM_END+1 
	MOVF        _temAtual+0, 0 
	MOVWF       FARG_Write_EEPROM_DADO+0 
	MOVF        _temAtual+1, 0 
	MOVWF       FARG_Write_EEPROM_DADO+1 
	CALL        _Write_EEPROM+0, 0
;keyboard-micro.c,326 :: 		} else {
	GOTO        L_main82
L_main76:
;keyboard-micro.c,327 :: 		temAtual = Read_EEPROM(0);
	CLRF        FARG_Read_EEPROM_END+0 
	CLRF        FARG_Read_EEPROM_END+1 
	CALL        _Read_EEPROM+0, 0
	MOVF        R0, 0 
	MOVWF       _temAtual+0 
	MOVF        R1, 0 
	MOVWF       _temAtual+1 
;keyboard-micro.c,328 :: 		}
L_main82:
;keyboard-micro.c,330 :: 		Lcd_Out(1, 2, "TEMPERATURA ATUAL");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_keyboard_45micro+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_keyboard_45micro+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;keyboard-micro.c,331 :: 		Lcd_Out(3, 2, "TEMPERATURA MAXIMA");
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr5_keyboard_45micro+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr5_keyboard_45micro+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;keyboard-micro.c,332 :: 		inttostr(temAtual, TXT);
	MOVF        _temAtual+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _temAtual+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _TXT+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_TXT+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;keyboard-micro.c,333 :: 		lcd_Out(4, 12, TXT);
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       12
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _TXT+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_TXT+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;keyboard-micro.c,334 :: 		lcd_chr_cp(0);
	CLRF        FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;keyboard-micro.c,335 :: 		lcd_chr_cp('C');
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;keyboard-micro.c,336 :: 		while(1)
L_main83:
;keyboard-micro.c,338 :: 		IntToStr(mmmt2, tzao);
	MOVF        _mmmt2+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _mmmt2+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _tzao+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_tzao+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;keyboard-micro.c,339 :: 		UART1_Write_Text(tzao);
	MOVLW       _tzao+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_tzao+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;keyboard-micro.c,341 :: 		sss= Read_RTC(0); //le segundos
	CLRF        FARG_Read_RTC_END+0 
	CLRF        FARG_Read_RTC_END+1 
	CALL        _Read_RTC+0, 0
	MOVF        R0, 0 
	MOVWF       _sss+0 
	MOVF        R1, 0 
	MOVWF       _sss+1 
;keyboard-micro.c,342 :: 		mmm= Read_RTC(1); //le minutos
	MOVLW       1
	MOVWF       FARG_Read_RTC_END+0 
	MOVLW       0
	MOVWF       FARG_Read_RTC_END+1 
	CALL        _Read_RTC+0, 0
	MOVF        R0, 0 
	MOVWF       _mmm+0 
	MOVF        R1, 0 
	MOVWF       _mmm+1 
;keyboard-micro.c,343 :: 		hhh= Read_RTC(2); //le horas
	MOVLW       2
	MOVWF       FARG_Read_RTC_END+0 
	MOVLW       0
	MOVWF       FARG_Read_RTC_END+1 
	CALL        _Read_RTC+0, 0
	MOVF        R0, 0 
	MOVWF       _hhh+0 
	MOVF        R1, 0 
	MOVWF       _hhh+1 
;keyboard-micro.c,346 :: 		Transform_Time(&sss,&mmm,&hhh);
	MOVLW       _sss+0
	MOVWF       FARG_Transform_Time_sec+0 
	MOVLW       hi_addr(_sss+0)
	MOVWF       FARG_Transform_Time_sec+1 
	MOVLW       _mmm+0
	MOVWF       FARG_Transform_Time_min+0 
	MOVLW       hi_addr(_mmm+0)
	MOVWF       FARG_Transform_Time_min+1 
	MOVLW       _hhh+0
	MOVWF       FARG_Transform_Time_hr+0 
	MOVLW       hi_addr(_hhh+0)
	MOVWF       FARG_Transform_Time_hr+1 
	CALL        _Transform_Time+0, 0
;keyboard-micro.c,349 :: 		sprintf(HORA_TXT, "%02d:%02d:%02d",hhh,mmm,sss);
	MOVLW       _HORA_TXT+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_HORA_TXT+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_6_keyboard_45micro+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_6_keyboard_45micro+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_6_keyboard_45micro+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _hhh+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _hhh+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	MOVF        _mmm+0, 0 
	MOVWF       FARG_sprintf_wh+7 
	MOVF        _mmm+1, 0 
	MOVWF       FARG_sprintf_wh+8 
	MOVF        _sss+0, 0 
	MOVWF       FARG_sprintf_wh+9 
	MOVF        _sss+1, 0 
	MOVWF       FARG_sprintf_wh+10 
	CALL        _sprintf+0, 0
;keyboard-micro.c,350 :: 		lcd_Out(4,1,HORA_TXT);
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _HORA_TXT+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_HORA_TXT+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;keyboard-micro.c,353 :: 		AD = ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _AD+0 
	MOVF        R1, 0 
	MOVWF       _AD+1 
;keyboard-micro.c,354 :: 		Temperatura = ((float) AD * 5.0/1024.0) * 100.0;
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
;keyboard-micro.c,355 :: 		inttostr(Temperatura, TXT);
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _TXT+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_TXT+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;keyboard-micro.c,356 :: 		Lcd_Out(2, 1, TIME);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _TIME+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_TIME+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;keyboard-micro.c,357 :: 		Lcd_Out(2, 8, TXT);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _TXT+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_TXT+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;keyboard-micro.c,358 :: 		Lcd_Chr_Cp(0);
	CLRF        FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;keyboard-micro.c,359 :: 		Lcd_Chr_CP('C');
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;keyboard-micro.c,360 :: 		inttostr(mmmt2, TXT);
	MOVF        _mmmt2+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _mmmt2+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _TXT+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_TXT+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;keyboard-micro.c,361 :: 		UART1_Write_Text(TXT);
	MOVLW       _TXT+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_TXT+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;keyboard-micro.c,366 :: 		if((Temperatura >= temAtual) && (mmmt2 == mmm && hhh == hhht)) {
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _temAtual+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main98
	MOVF        _temAtual+0, 0 
	SUBWF       _Temperatura+0, 0 
L__main98:
	BTFSS       STATUS+0, 0 
	GOTO        L_main89
	MOVF        _mmmt2+1, 0 
	XORWF       _mmm+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main99
	MOVF        _mmm+0, 0 
	XORWF       _mmmt2+0, 0 
L__main99:
	BTFSS       STATUS+0, 2 
	GOTO        L_main89
	MOVF        _hhh+1, 0 
	XORWF       _hhht+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main100
	MOVF        _hhht+0, 0 
	XORWF       _hhh+0, 0 
L__main100:
	BTFSS       STATUS+0, 2 
	GOTO        L_main89
L__main91:
L__main90:
;keyboard-micro.c,367 :: 		Alert();
	CALL        _Alert+0, 0
;keyboard-micro.c,368 :: 		}
L_main89:
;keyboard-micro.c,370 :: 		}
	GOTO        L_main83
;keyboard-micro.c,371 :: 		}
	GOTO        $+0
; end of _main
