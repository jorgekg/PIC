#line 1 "C:/Users/jorge/git/PIC/keyboard/keyboard-micro.c"

sbit LCD_RS at RE0_bit;
sbit LCD_EN at RE1_bit;



sbit LCD_D7 at RD7_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D4 at RD4_bit;




sbit LCD_RS_Direction at TRISE0_bit;
sbit LCD_EN_Direction at TRISE1_bit;



sbit LCD_D7_Direction at TRISD7_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D4_Direction at TRISD4_bit;



unsigned int AD;
char TXT[7];
unsigned short Temperatura;



int hhh, mmm, sss, mmmt, hhht, mmmt2;



char ENTER[2] = {13,0};



char ENTRADA[33];
char TIME[5];


int temp;




void Pula_Linha(void)
{
 UART1_WRITE(13);
 UART1_WRITE(10);
}



void Move_Delay() {
 Delay_ms(100);
}



const char character_0[] = {3,3,0,0,0,0,0,0};
const char character_1[] = {1,1,1,1,1,1,1,1};



void CustomChar() {
 char i;
 LCD_Cmd(64);
 for (i = 0; i<=7; i++) LCD_Chr_Cp(character_0[i]);
 for (i = 0; i<=7; i++) LCD_Chr_Cp(character_1[i]);
 LCD_Cmd(_LCD_RETURN_HOME);
}



void Alert()
{
 int i;



 for(i=0; i<1; i++) {
 Lcd_Cmd(_LCD_SHIFT_RIGHT);
 Move_Delay();
 }
 for(i=0; i<1; i++) {
 Lcd_Cmd(_LCD_SHIFT_LEFT);
 Move_Delay();
 }



}



void Write_RTC(int END, int DADO)
{
 I2C1_Start();
 I2C1_Wr(0xD0);
 I2C1_Wr(END);
 I2C1_Wr(DADO);
 I2C1_Stop();
}



int Read_RTC(int END)
{
 int Dado;



 I2C1_Start();
 I2C1_Wr(0xD0);
 I2C1_Wr(END);
 I2C1_Repeated_Start();
 I2C1_Wr(0xD1);
 Dado = I2C1_Rd(0u);
 I2C1_Stop();
 return(Dado);
}

void Transform_Time(char *sec, char *min, char *hr) {
*sec = ((*sec & 0xF0) >> 4)*10 + (*sec & 0x0F);
*min = ((*min & 0xF0) >> 4)*10 + (*min & 0x0F);
*hr = ((*hr & 0xF0) >> 4)*10 + (*hr & 0x0F);
}

void Write_EEPROM(int END, int DADO)
{
 I2C1_Start();
 I2C1_Wr(0xA0);
 I2C1_Wr(END);
 I2C1_Wr(DADO);
 I2C1_Stop();
 delay_ms(10);
}

int Read_EEPROM(int END)
{
 int Dado;
 I2C1_Start();
 I2C1_Wr(0xA0);
 I2C1_Wr(END);
 I2C1_Repeated_Start();
 I2C1_Wr(0xA1);
 Dado = I2C1_Rd(0u);
 I2C1_Stop();
 return(Dado);
}

char Tecla;

short Le_Teclado()
{
 PORTD = 0B00010000;
 if (PORTB.RB0 == 1) {while(PORTB.RB0==1); return '7';};
 if (PORTB.RB1 == 1) {while(PORTB.RB1==1); return '8';};
 if (PORTB.RB2 == 1) {while(PORTB.RB2==1); return '9';};
 if (PORTB.RB3 == 1) {while(PORTB.RB3==1); return '%';};



 PORTD = 0B00100000;
 if (PORTB.RB0 == 1) {while(PORTB.RB0==1);return '4';};
 if (PORTB.RB1 == 1) {while(PORTB.RB1==1);return '5';};
 if (PORTB.RB2 == 1) {while(PORTB.RB2==1);return '6';};
 if (PORTB.RB3 == 1) {while(PORTB.RB3==1);return '*';};



 PORTD = 0B01000000;
 if (PORTB.RB0 == 1) {while(PORTB.RB0==1);return '1';};
 if (PORTB.RB1 == 1) {while(PORTB.RB1==1);return '2';};
 if (PORTB.RB2 == 1) {while(PORTB.RB2==1);return '3';};
 if (PORTB.RB3 == 1) {while(PORTB.RB3==1);return '-';};



 PORTD = 0B10000000;
 if (PORTB.RB0 == 1) {while(PORTB.RB0==1);return 'C';};
 if (PORTB.RB1 == 1) {while(PORTB.RB1==1);return '0';};
 if (PORTB.RB2 == 1) {while(PORTB.RB2==1);return '=';};
 if (PORTB.RB3 == 1) {while(PORTB.RB3==1);return '+';};



 return 255;
}

char HORA_TXT[20];
char t[1];
char t2[3];
char t3[2];
char tzao[5];
int temAtual;
char tempHoras[6];
char tempTeclas[6];
int iteracao = 0;
short pass;
char Tecla2;

void main()
 {
 UART1_Init(19200);

 I2C1_Init(100000);

 ADCON1=0B00001110;
 TRISB = 0B00001111;
 PORTB = 0B00000000;
 Lcd_Init();
 Lcd_Cmd(_LCD_CURSOR_OFF);
 CustomChar();
 Lcd_Out(1, 2, "Digite a senha");
 while(1)
 {
 Tecla2 = Le_Teclado() ;
 if(!(Tecla2==255)) {
 pass = Tecla2;
 break;
 }
 }
 if (pass == '0') {
 Write_EEPROM(0, 0xFF);
 Write_EEPROM(1, 0xFF);
 Write_EEPROM(2, 0xFF);
 }

 if (Read_EEPROM(1) == 0xFF) {
 Lcd_Out(1, 2, "HORARIO MONITORAR");
 while(1)
 {
 Tecla = Le_Teclado() ;
 if (Tecla == '=') {
 break;
 }
 if (Tecla == '-') {
 tempHoras[iteracao] = ':';
 iteracao = iteracao + 1;
 lcd_Out(2, 5, tempTeclas);
 continue;
 }
 if (Tecla == '*') {
 tempHoras[iteracao] = ' ';
 iteracao = iteracao - 1;
 lcd_Out(2, 5, tempHoras);
 continue;
 }
 if(!(Tecla==255)) {
 tempHoras[iteracao] = Tecla;
 iteracao = iteracao + 1;
 }
 lcd_Out(2, 5, tempHoras);
 }

 TIME[0] = tempHoras[0];
 TIME[1] = tempHoras[1];
 TIME[2] = tempHoras[2];
 TIME[3] = tempHoras[3];
 TIME[4] = tempHoras[4];
 t3[0] = tempHoras[0];
 t[0] = t3[0];
 t3[0] = tempHoras[1];
 t[1] = t3[0];
 hhht=atoi(t);
 Write_EEPROM(1, hhht);
 t2[0] = TIME[3];
 t2[1] = TIME[4];
 mmmt2=atoi(t2);
 Write_EEPROM(2,mmmt2);
 } else {
 hhht = Read_EEPROM(1);
 IntToStr(hhht, tzao);
 TIME[0] = tzao[4];
 TIME[1] = tzao[5];
 TIME[2] = ':';
 mmmt2 = Read_EEPROM(2);
 if (mmmt < 10) {
 TIME[3] = '0';
 TIME[4] = tzao[4];
 } else {
 TIME[3] = tzao[4];
 TIME[4] = tzao[5];
 }
 }
 if (Read_EEPROM(0) == 0xFF) {
 iteracao = 0;
 tempTeclas[0] = ' ';
 tempTeclas[1] = ' ';
 tempTeclas[2] = ' ';
 tempTeclas[3] = ' ';
 tempTeclas[4] = ' ';
 lcd_Out(2, 5, tempTeclas);
 Lcd_Out(1, 2, "TEMPERATURA MAXIMA");
 while(1)
 {
 Tecla = Le_Teclado() ;
 if (Tecla == '=') {
 break;
 }
 if (Tecla == '*') {
 tempTeclas[iteracao] = ' ';
 iteracao = iteracao - 1;
 lcd_Out(2, 5, tempTeclas);
 continue;
 }
 if(!(Tecla==255)) {
 tempTeclas[iteracao] = Tecla;
 iteracao = iteracao + 1;
 }
 lcd_Out(2, 5, tempTeclas);
 }
 temAtual=atoi(tempTeclas);
 tempTeclas[0] = ' ';
 tempTeclas[1] = ' ';
 tempTeclas[2] = ' ';
 tempTeclas[3] = ' ';
 tempTeclas[4] = ' ';
 lcd_Out(2, 5, tempTeclas);
 Write_EEPROM(0, temAtual);
 } else {
 temAtual = Read_EEPROM(0);
 }

 Lcd_Out(1, 2, "TEMPERATURA ATUAL");
 Lcd_Out(3, 2, "TEMPERATURA MAXIMA");
 inttostr(temAtual, TXT);
 lcd_Out(4, 12, TXT);
 lcd_chr_cp(0);
 lcd_chr_cp('C');
 while(1)
 {
 IntToStr(mmmt2, tzao);
 UART1_Write_Text(tzao);

 sss= Read_RTC(0);
 mmm= Read_RTC(1);
 hhh= Read_RTC(2);


 Transform_Time(&sss,&mmm,&hhh);


 sprintf(HORA_TXT, "%02d:%02d:%02d",hhh,mmm,sss);
 lcd_Out(4,1,HORA_TXT);


 AD = ADC_Read(0);
 Temperatura = ((float) AD * 5.0/1024.0) * 100.0;
 inttostr(Temperatura, TXT);
 Lcd_Out(2, 1, TIME);
 Lcd_Out(2, 8, TXT);
 Lcd_Chr_Cp(0);
 Lcd_Chr_CP('C');
 inttostr(mmmt2, TXT);
 UART1_Write_Text(TXT);




 if((Temperatura >= temAtual) && (mmmt2 == mmm && hhh == hhht)) {
 Alert();
 }

 }
}
