#line 1 "C:/Users/jorge/git/PIC/lcd2-microc/led.c"

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

int isFirst = 1;
unsigned int AD;
char TXT[7];
unsigned short Temperatura;
char entrada[33];
char enter[2] = {13, 0};
int temp;

void Pula_Linha(void)
{
 UART1_WRITE(13);
 UART1_WRITE(10);
}


const char character_0[] = {2,5,2,0,0,0,0,0};
const char character_1[] = {1,1,1,1,1,1,1,1};


void CustomChar() {
 char i;
 LCD_Cmd(64);
 for (i = 0; i<=7; i++) LCD_Chr_Cp(character_0[i]);
 for (i = 0; i<=7; i++) LCD_Chr_Cp(character_1[i]);
 LCD_Cmd(_LCD_RETURN_HOME);
}

void Move_Delay() {
 Delay_ms(100);
}

void main()
 {
 UART1_Init(19200);
 UART1_Write_Text("Qual a Temperatura maxima\r");
 UART1_Read_Text(entrada, enter, 32);
 UART1_Write_Text(entrada);
 temp = atoi(entrada);

 ADCON1=0B00001110;
 TRISB = 0B00001111;
 PORTB = 0B00000000;
 Lcd_Init();

 Lcd_Cmd(_LCD_CURSOR_OFF);

 CustomChar();

 Lcd_Out(1, 6, "Temperatura");




 while(1)
 {
 AD = ADC_Read(0);
 Temperatura = ((float) AD * 5.0/1024.0) * 100.0;
 inttostr(Temperatura, TXT);
 Lcd_Out(2, 6, TXT);
 Lcd_Chr_Cp(0);
 Lcd_Chr_CP('C');
 Lcd_Out(3, 5, "Temp. Maxima");
 inttostr(temp, TXT);
 Lcd_Out(4, 6, TXT);
 Lcd_Chr_Cp(0);
 Lcd_Chr_CP('C');
 if (Temperatura > temp) {
 int i = 0;
 for(i=0; i<4; i++) {
 Lcd_Cmd(_LCD_SHIFT_RIGHT);
 Move_Delay();
 }
 for( i=0; i<4; i++) {
 Lcd_Cmd(_LCD_SHIFT_LEFT);
 Move_Delay();
 }
 }
 if (Temperatura > temp) {
 int i = 0;
 for(i=0; i<4; i++) {
 Lcd_Cmd(_LCD_SHIFT_LEFT);
 Move_Delay();
 }
 for( i=0; i<4; i++) {
 Lcd_Cmd(_LCD_SHIFT_RIGHT);
 Move_Delay();
 }
 }

 }
}
