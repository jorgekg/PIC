
_Pula_Linha:

;aula 3.c,50 :: 		void Pula_Linha(void)
;aula 3.c,52 :: 		UART1_WRITE(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;aula 3.c,53 :: 		UART1_WRITE(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;aula 3.c,54 :: 		}
	RETURN      0
; end of _Pula_Linha

_Move_Delay:

;aula 3.c,58 :: 		void Move_Delay() {                  // Function used for text moving
;aula 3.c,59 :: 		Delay_ms(100);                     // You can change the moving speed here
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
;aula 3.c,60 :: 		}
	RETURN      0
; end of _Move_Delay

_CustomChar:

;aula 3.c,69 :: 		void CustomChar() {
;aula 3.c,71 :: 		LCD_Cmd(64); //entra na CGRAM
	MOVLW       64
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;aula 3.c,72 :: 		for (i = 0; i<=7; i++) LCD_Chr_Cp(character_0[i]); //grava 8 bytes na cgram ENDER 0 a 7  cgram
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
;aula 3.c,73 :: 		for (i = 0; i<=7; i++) LCD_Chr_Cp(character_1[i]); //grava 8 bytes na cgram ENDER 8 a 15 cgram
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
;aula 3.c,74 :: 		LCD_Cmd(_LCD_RETURN_HOME); //sai da cgram
	MOVLW       2
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;aula 3.c,75 :: 		}
	RETURN      0
; end of _CustomChar

_Alert:

;aula 3.c,79 :: 		void Alert()
;aula 3.c,85 :: 		for(i=0; i<1; i++) {               // Move text to the right 4 times
	CLRF        Alert_i_L0+0 
	CLRF        Alert_i_L0+1 
L_Alert7:
	MOVLW       128
	XORWF       Alert_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Alert31
	MOVLW       1
	SUBWF       Alert_i_L0+0, 0 
L__Alert31:
	BTFSC       STATUS+0, 0 
	GOTO        L_Alert8
;aula 3.c,86 :: 		Lcd_Cmd(_LCD_SHIFT_RIGHT);
	MOVLW       28
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;aula 3.c,87 :: 		Move_Delay();
	CALL        _Move_Delay+0, 0
;aula 3.c,85 :: 		for(i=0; i<1; i++) {               // Move text to the right 4 times
	INFSNZ      Alert_i_L0+0, 1 
	INCF        Alert_i_L0+1, 1 
;aula 3.c,88 :: 		}
	GOTO        L_Alert7
L_Alert8:
;aula 3.c,89 :: 		for(i=0; i<1; i++) {               // Move text to the left 4 times
	CLRF        Alert_i_L0+0 
	CLRF        Alert_i_L0+1 
L_Alert10:
	MOVLW       128
	XORWF       Alert_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Alert32
	MOVLW       1
	SUBWF       Alert_i_L0+0, 0 
L__Alert32:
	BTFSC       STATUS+0, 0 
	GOTO        L_Alert11
;aula 3.c,90 :: 		Lcd_Cmd(_LCD_SHIFT_LEFT);
	MOVLW       24
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;aula 3.c,91 :: 		Move_Delay();
	CALL        _Move_Delay+0, 0
;aula 3.c,89 :: 		for(i=0; i<1; i++) {               // Move text to the left 4 times
	INFSNZ      Alert_i_L0+0, 1 
	INCF        Alert_i_L0+1, 1 
;aula 3.c,92 :: 		}
	GOTO        L_Alert10
L_Alert11:
;aula 3.c,96 :: 		}
	RETURN      0
; end of _Alert

_Write_RTC:

;aula 3.c,100 :: 		void Write_RTC(int END, int DADO)
;aula 3.c,102 :: 		I2C1_Start();           // issue I2C start signal
	CALL        _I2C1_Start+0, 0
;aula 3.c,103 :: 		I2C1_Wr(0xD0);          // send byte via I2C  (device address + W)
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;aula 3.c,104 :: 		I2C1_Wr(END);             // send byte (address of EEPROM location)
	MOVF        FARG_Write_RTC_END+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;aula 3.c,105 :: 		I2C1_Wr(DADO);          // send data (data to be written)
	MOVF        FARG_Write_RTC_DADO+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;aula 3.c,106 :: 		I2C1_Stop();            // issue I2C stop signal
	CALL        _I2C1_Stop+0, 0
;aula 3.c,107 :: 		}
	RETURN      0
; end of _Write_RTC

_Read_RTC:

;aula 3.c,111 :: 		int Read_RTC(int END)
;aula 3.c,117 :: 		I2C1_Start();           // issue I2C start signal
	CALL        _I2C1_Start+0, 0
;aula 3.c,118 :: 		I2C1_Wr(0xD0);          // send byte via I2C  (device address + W)
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;aula 3.c,119 :: 		I2C1_Wr(END);             // send byte (data address)
	MOVF        FARG_Read_RTC_END+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;aula 3.c,120 :: 		I2C1_Repeated_Start();  // issue I2C signal repeated start
	CALL        _I2C1_Repeated_Start+0, 0
;aula 3.c,121 :: 		I2C1_Wr(0xD1);          // send byte (device address + R)
	MOVLW       209
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;aula 3.c,122 :: 		Dado = I2C1_Rd(0u);    // Read the data (NO acknowledge)
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       Read_RTC_Dado_L0+0 
	MOVLW       0
	MOVWF       Read_RTC_Dado_L0+1 
;aula 3.c,123 :: 		I2C1_Stop();            // issue I2C stop signal
	CALL        _I2C1_Stop+0, 0
;aula 3.c,124 :: 		return(Dado);
	MOVF        Read_RTC_Dado_L0+0, 0 
	MOVWF       R0 
	MOVF        Read_RTC_Dado_L0+1, 0 
	MOVWF       R1 
;aula 3.c,125 :: 		}
	RETURN      0
; end of _Read_RTC

_Transform_Time:

;aula 3.c,127 :: 		void Transform_Time(char *sec, char *min, char *hr) {
;aula 3.c,128 :: 		*sec = ((*sec & 0xF0) >> 4)*10 + (*sec & 0x0F);
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
;aula 3.c,129 :: 		*min = ((*min & 0xF0) >> 4)*10 + (*min & 0x0F);
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
;aula 3.c,130 :: 		*hr = ((*hr & 0xF0) >> 4)*10 + (*hr & 0x0F);
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
;aula 3.c,131 :: 		}
	RETURN      0
; end of _Transform_Time

_Write_EEPROM:

;aula 3.c,133 :: 		void Write_EEPROM(int END, int DADO)
;aula 3.c,135 :: 		I2C1_Start();           // issue I2C start signal
	CALL        _I2C1_Start+0, 0
;aula 3.c,136 :: 		I2C1_Wr(0xA0);          // send byte via I2C  (device address + W)
	MOVLW       160
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;aula 3.c,137 :: 		I2C1_Wr(END);             // send byte (address of EEPROM location)
	MOVF        FARG_Write_EEPROM_END+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;aula 3.c,138 :: 		I2C1_Wr(DADO);          // send data (data to be written)
	MOVF        FARG_Write_EEPROM_DADO+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;aula 3.c,139 :: 		I2C1_Stop();            // issue I2C stop signal
	CALL        _I2C1_Stop+0, 0
;aula 3.c,140 :: 		delay_ms(10);
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
;aula 3.c,141 :: 		}
	RETURN      0
; end of _Write_EEPROM

_Read_EEPROM:

;aula 3.c,143 :: 		int Read_EEPROM(int END)
;aula 3.c,146 :: 		I2C1_Start();           // issue I2C start signal
	CALL        _I2C1_Start+0, 0
;aula 3.c,147 :: 		I2C1_Wr(0xA0);          // send byte via I2C  (device address + W)
	MOVLW       160
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;aula 3.c,148 :: 		I2C1_Wr(END);             // send byte (data address)
	MOVF        FARG_Read_EEPROM_END+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;aula 3.c,149 :: 		I2C1_Repeated_Start();  // issue I2C signal repeated start
	CALL        _I2C1_Repeated_Start+0, 0
;aula 3.c,150 :: 		I2C1_Wr(0xA1);          // send byte (device address + R)
	MOVLW       161
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;aula 3.c,151 :: 		Dado = I2C1_Rd(0u);    // Read the data (NO acknowledge)
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       Read_EEPROM_Dado_L0+0 
	MOVLW       0
	MOVWF       Read_EEPROM_Dado_L0+1 
;aula 3.c,152 :: 		I2C1_Stop();            // issue I2C stop signal
	CALL        _I2C1_Stop+0, 0
;aula 3.c,153 :: 		return(Dado);
	MOVF        Read_EEPROM_Dado_L0+0, 0 
	MOVWF       R0 
	MOVF        Read_EEPROM_Dado_L0+1, 0 
	MOVWF       R1 
;aula 3.c,154 :: 		}
	RETURN      0
; end of _Read_EEPROM

_main:

;aula 3.c,162 :: 		void main()
;aula 3.c,164 :: 		UART1_Init(19200);
	MOVLW       25
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;aula 3.c,166 :: 		I2C1_Init(100000);// i2c para acessar ID = D0h  = RTC
	MOVLW       20
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;aula 3.c,168 :: 		if (PORTB.F6 == 1) {
	BTFSS       PORTB+0, 6 
	GOTO        L_main14
;aula 3.c,169 :: 		Write_EEPROM(0, 0xFF);
	CLRF        FARG_Write_EEPROM_END+0 
	CLRF        FARG_Write_EEPROM_END+1 
	MOVLW       255
	MOVWF       FARG_Write_EEPROM_DADO+0 
	MOVLW       0
	MOVWF       FARG_Write_EEPROM_DADO+1 
	CALL        _Write_EEPROM+0, 0
;aula 3.c,170 :: 		Write_EEPROM(1, 0xFF);
	MOVLW       1
	MOVWF       FARG_Write_EEPROM_END+0 
	MOVLW       0
	MOVWF       FARG_Write_EEPROM_END+1 
	MOVLW       255
	MOVWF       FARG_Write_EEPROM_DADO+0 
	MOVLW       0
	MOVWF       FARG_Write_EEPROM_DADO+1 
	CALL        _Write_EEPROM+0, 0
;aula 3.c,171 :: 		Write_EEPROM(2, 0xFF);
	MOVLW       2
	MOVWF       FARG_Write_EEPROM_END+0 
	MOVLW       0
	MOVWF       FARG_Write_EEPROM_END+1 
	MOVLW       255
	MOVWF       FARG_Write_EEPROM_DADO+0 
	MOVLW       0
	MOVWF       FARG_Write_EEPROM_DADO+1 
	CALL        _Write_EEPROM+0, 0
;aula 3.c,172 :: 		}
L_main14:
;aula 3.c,175 :: 		if (Read_EEPROM(1) == 0xFF) {
	MOVLW       1
	MOVWF       FARG_Read_EEPROM_END+0 
	MOVLW       0
	MOVWF       FARG_Read_EEPROM_END+1 
	CALL        _Read_EEPROM+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main33
	MOVLW       255
	XORWF       R0, 0 
L__main33:
	BTFSS       STATUS+0, 2 
	GOTO        L_main15
;aula 3.c,176 :: 		UART1_Write_Text("\r QUAL HORARIO MONITORAR\r");
	MOVLW       ?lstr1_aula_323+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_aula_323+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;aula 3.c,177 :: 		while(!(UART1_Data_Ready() == 1));         //AGUARDA CHEGAR ALGO NA SERIAL VINDO DO TERMINAL BURRO
L_main16:
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main17
	GOTO        L_main16
L_main17:
;aula 3.c,178 :: 		UART1_Read_Text(TIME, ENTER, 37);
	MOVLW       _TIME+0
	MOVWF       FARG_UART1_Read_Text_Output+0 
	MOVLW       hi_addr(_TIME+0)
	MOVWF       FARG_UART1_Read_Text_Output+1 
	MOVLW       _ENTER+0
	MOVWF       FARG_UART1_Read_Text_Delimiter+0 
	MOVLW       hi_addr(_ENTER+0)
	MOVWF       FARG_UART1_Read_Text_Delimiter+1 
	MOVLW       37
	MOVWF       FARG_UART1_Read_Text_Attempts+0 
	CALL        _UART1_Read_Text+0, 0
;aula 3.c,179 :: 		UART1_Write_Text(TIME);
	MOVLW       _TIME+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_TIME+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;aula 3.c,180 :: 		t[0] = TIME[0];
	MOVF        _TIME+0, 0 
	MOVWF       _t+0 
;aula 3.c,181 :: 		t[1] = TIME[1];
	MOVF        _TIME+1, 0 
	MOVWF       _t+1 
;aula 3.c,182 :: 		hhht=atoi(t);
	MOVLW       _t+0
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(_t+0)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _hhht+0 
	MOVF        R1, 0 
	MOVWF       _hhht+1 
;aula 3.c,183 :: 		Write_EEPROM(1, hhht);
	MOVLW       1
	MOVWF       FARG_Write_EEPROM_END+0 
	MOVLW       0
	MOVWF       FARG_Write_EEPROM_END+1 
	MOVF        R0, 0 
	MOVWF       FARG_Write_EEPROM_DADO+0 
	MOVF        R1, 0 
	MOVWF       FARG_Write_EEPROM_DADO+1 
	CALL        _Write_EEPROM+0, 0
;aula 3.c,184 :: 		t[0] = TIME[3];
	MOVF        _TIME+3, 0 
	MOVWF       _t+0 
;aula 3.c,185 :: 		t[1] = TIME[4];
	MOVF        _TIME+4, 0 
	MOVWF       _t+1 
;aula 3.c,186 :: 		mmmt=atoi(t);
	MOVLW       _t+0
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(_t+0)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _mmmt+0 
	MOVF        R1, 0 
	MOVWF       _mmmt+1 
;aula 3.c,187 :: 		Write_EEPROM(2,mmmt);
	MOVLW       2
	MOVWF       FARG_Write_EEPROM_END+0 
	MOVLW       0
	MOVWF       FARG_Write_EEPROM_END+1 
	MOVF        R0, 0 
	MOVWF       FARG_Write_EEPROM_DADO+0 
	MOVF        R1, 0 
	MOVWF       FARG_Write_EEPROM_DADO+1 
	CALL        _Write_EEPROM+0, 0
;aula 3.c,188 :: 		} else {
	GOTO        L_main18
L_main15:
;aula 3.c,189 :: 		hhht = Read_EEPROM(1);
	MOVLW       1
	MOVWF       FARG_Read_EEPROM_END+0 
	MOVLW       0
	MOVWF       FARG_Read_EEPROM_END+1 
	CALL        _Read_EEPROM+0, 0
	MOVF        R0, 0 
	MOVWF       _hhht+0 
	MOVF        R1, 0 
	MOVWF       _hhht+1 
;aula 3.c,190 :: 		IntToStr(hhht, tzao);
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _tzao+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_tzao+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;aula 3.c,191 :: 		TIME[0] = tzao[4];
	MOVF        _tzao+4, 0 
	MOVWF       _TIME+0 
;aula 3.c,192 :: 		TIME[1] = tzao[5];
	MOVF        _tzao+5, 0 
	MOVWF       _TIME+1 
;aula 3.c,193 :: 		TIME[2] = ':';
	MOVLW       58
	MOVWF       _TIME+2 
;aula 3.c,194 :: 		mmmt = Read_EEPROM(2);
	MOVLW       2
	MOVWF       FARG_Read_EEPROM_END+0 
	MOVLW       0
	MOVWF       FARG_Read_EEPROM_END+1 
	CALL        _Read_EEPROM+0, 0
	MOVF        R0, 0 
	MOVWF       _mmmt+0 
	MOVF        R1, 0 
	MOVWF       _mmmt+1 
;aula 3.c,195 :: 		IntToStr(mmmt, tzao);
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _tzao+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_tzao+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;aula 3.c,196 :: 		if (mmmt < 10) {
	MOVLW       128
	XORWF       _mmmt+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main34
	MOVLW       10
	SUBWF       _mmmt+0, 0 
L__main34:
	BTFSC       STATUS+0, 0 
	GOTO        L_main19
;aula 3.c,197 :: 		TIME[3] = '0';
	MOVLW       48
	MOVWF       _TIME+3 
;aula 3.c,198 :: 		TIME[4] = tzao[5];
	MOVF        _tzao+5, 0 
	MOVWF       _TIME+4 
;aula 3.c,199 :: 		} else {
	GOTO        L_main20
L_main19:
;aula 3.c,200 :: 		TIME[3] = tzao[4];
	MOVF        _tzao+4, 0 
	MOVWF       _TIME+3 
;aula 3.c,201 :: 		TIME[4] = tzao[5];
	MOVF        _tzao+5, 0 
	MOVWF       _TIME+4 
;aula 3.c,202 :: 		}
L_main20:
;aula 3.c,203 :: 		}
L_main18:
;aula 3.c,205 :: 		if (Read_EEPROM(0) == 0xFF) {
	CLRF        FARG_Read_EEPROM_END+0 
	CLRF        FARG_Read_EEPROM_END+1 
	CALL        _Read_EEPROM+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main35
	MOVLW       255
	XORWF       R0, 0 
L__main35:
	BTFSS       STATUS+0, 2 
	GOTO        L_main21
;aula 3.c,206 :: 		UART1_Write_Text("QUAL A TEMPERATURA MAXIMA\r");
	MOVLW       ?lstr2_aula_323+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr2_aula_323+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;aula 3.c,207 :: 		while(!(UART1_Data_Ready() == 1));         //AGUARDA CHEGAR ALGO NA SERIAL VINDO DO TERMINAL BURRO
L_main22:
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main23
	GOTO        L_main22
L_main23:
;aula 3.c,208 :: 		UART1_Read_Text(ENTRADA, ENTER, 32);
	MOVLW       _ENTRADA+0
	MOVWF       FARG_UART1_Read_Text_Output+0 
	MOVLW       hi_addr(_ENTRADA+0)
	MOVWF       FARG_UART1_Read_Text_Output+1 
	MOVLW       _ENTER+0
	MOVWF       FARG_UART1_Read_Text_Delimiter+0 
	MOVLW       hi_addr(_ENTER+0)
	MOVWF       FARG_UART1_Read_Text_Delimiter+1 
	MOVLW       32
	MOVWF       FARG_UART1_Read_Text_Attempts+0 
	CALL        _UART1_Read_Text+0, 0
;aula 3.c,209 :: 		temAtual=atoi(ENTRADA);
	MOVLW       _ENTRADA+0
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(_ENTRADA+0)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _temAtual+0 
	MOVF        R1, 0 
	MOVWF       _temAtual+1 
;aula 3.c,210 :: 		Write_EEPROM(0, temAtual);
	CLRF        FARG_Write_EEPROM_END+0 
	CLRF        FARG_Write_EEPROM_END+1 
	MOVF        R0, 0 
	MOVWF       FARG_Write_EEPROM_DADO+0 
	MOVF        R1, 0 
	MOVWF       FARG_Write_EEPROM_DADO+1 
	CALL        _Write_EEPROM+0, 0
;aula 3.c,211 :: 		} else {
	GOTO        L_main24
L_main21:
;aula 3.c,212 :: 		temAtual = Read_EEPROM(0);
	CLRF        FARG_Read_EEPROM_END+0 
	CLRF        FARG_Read_EEPROM_END+1 
	CALL        _Read_EEPROM+0, 0
	MOVF        R0, 0 
	MOVWF       _temAtual+0 
	MOVF        R1, 0 
	MOVWF       _temAtual+1 
;aula 3.c,213 :: 		}
L_main24:
;aula 3.c,215 :: 		ADCON1=0B00001110;
	MOVLW       14
	MOVWF       ADCON1+0 
;aula 3.c,216 :: 		TRISB = 0B00001111;
	MOVLW       15
	MOVWF       TRISB+0 
;aula 3.c,217 :: 		PORTB = 0B00000000;
	CLRF        PORTB+0 
;aula 3.c,218 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;aula 3.c,219 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;aula 3.c,220 :: 		CustomChar();
	CALL        _CustomChar+0, 0
;aula 3.c,222 :: 		Lcd_Out(1, 2, "TEMPERATURA ATUAL");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_aula_323+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_aula_323+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aula 3.c,223 :: 		Lcd_Out(3, 2, "TEMPERATURA MAXIMA");
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_aula_323+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_aula_323+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aula 3.c,224 :: 		inttostr(temAtual, TXT);
	MOVF        _temAtual+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _temAtual+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _TXT+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_TXT+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;aula 3.c,225 :: 		lcd_Out(4, 12, TXT);
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       12
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _TXT+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_TXT+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aula 3.c,226 :: 		lcd_chr_cp(0);
	CLRF        FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;aula 3.c,227 :: 		lcd_chr_cp('C');
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;aula 3.c,229 :: 		while(1)
L_main25:
;aula 3.c,232 :: 		sss= Read_RTC(0); //le segundos
	CLRF        FARG_Read_RTC_END+0 
	CLRF        FARG_Read_RTC_END+1 
	CALL        _Read_RTC+0, 0
	MOVF        R0, 0 
	MOVWF       _sss+0 
	MOVF        R1, 0 
	MOVWF       _sss+1 
;aula 3.c,233 :: 		mmm= Read_RTC(1); //le minutos
	MOVLW       1
	MOVWF       FARG_Read_RTC_END+0 
	MOVLW       0
	MOVWF       FARG_Read_RTC_END+1 
	CALL        _Read_RTC+0, 0
	MOVF        R0, 0 
	MOVWF       _mmm+0 
	MOVF        R1, 0 
	MOVWF       _mmm+1 
;aula 3.c,234 :: 		hhh= Read_RTC(2); //le horas
	MOVLW       2
	MOVWF       FARG_Read_RTC_END+0 
	MOVLW       0
	MOVWF       FARG_Read_RTC_END+1 
	CALL        _Read_RTC+0, 0
	MOVF        R0, 0 
	MOVWF       _hhh+0 
	MOVF        R1, 0 
	MOVWF       _hhh+1 
;aula 3.c,237 :: 		Transform_Time(&sss,&mmm,&hhh);
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
;aula 3.c,240 :: 		sprintf(HORA_TXT, "%02d:%02d:%02d",hhh,mmm,sss);
	MOVLW       _HORA_TXT+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_HORA_TXT+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_5_aula_323+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_5_aula_323+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_5_aula_323+0)
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
;aula 3.c,241 :: 		lcd_Out(4,1,HORA_TXT);
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _HORA_TXT+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_HORA_TXT+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aula 3.c,244 :: 		AD = ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _AD+0 
	MOVF        R1, 0 
	MOVWF       _AD+1 
;aula 3.c,245 :: 		Temperatura = ((float) AD * 5.0/1024.0) * 100.0;
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
;aula 3.c,246 :: 		inttostr(Temperatura, TXT);
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _TXT+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_TXT+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;aula 3.c,247 :: 		Lcd_Out(2, 1, TIME);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _TIME+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_TIME+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aula 3.c,248 :: 		Lcd_Out(2, 8, TXT);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _TXT+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_TXT+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aula 3.c,249 :: 		Lcd_Chr_Cp(0);
	CLRF        FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;aula 3.c,250 :: 		Lcd_Chr_CP('C');
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;aula 3.c,251 :: 		IntToStr(Temperatura, TXT);
	MOVF        _Temperatura+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _TXT+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_TXT+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;aula 3.c,252 :: 		UART1_Write_Text(TXT);
	MOVLW       _TXT+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_TXT+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;aula 3.c,253 :: 		IntToStr(temAtual, TXT);
	MOVF        _temAtual+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _temAtual+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _TXT+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_TXT+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;aula 3.c,254 :: 		UART1_Write_Text(TXT);
	MOVLW       _TXT+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_TXT+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;aula 3.c,255 :: 		if(Temperatura >= temAtual && mmmt == mmm && hhh == hhht)
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _temAtual+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main36
	MOVF        _temAtual+0, 0 
	SUBWF       _Temperatura+0, 0 
L__main36:
	BTFSS       STATUS+0, 0 
	GOTO        L_main29
	MOVF        _mmmt+1, 0 
	XORWF       _mmm+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main37
	MOVF        _mmm+0, 0 
	XORWF       _mmmt+0, 0 
L__main37:
	BTFSS       STATUS+0, 2 
	GOTO        L_main29
	MOVF        _hhh+1, 0 
	XORWF       _hhht+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main38
	MOVF        _hhht+0, 0 
	XORWF       _hhh+0, 0 
L__main38:
	BTFSS       STATUS+0, 2 
	GOTO        L_main29
L__main30:
;aula 3.c,256 :: 		Alert();
	CALL        _Alert+0, 0
L_main29:
;aula 3.c,258 :: 		}
	GOTO        L_main25
;aula 3.c,259 :: 		}
	GOTO        $+0
; end of _main
