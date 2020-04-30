// Lcd pinout settings
sbit LCD_RS at RE0_bit;
sbit LCD_EN at RE1_bit;

sbit LCD_D7 at RD7_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D4 at RD4_bit;

// Pin direction
sbit LCD_RS_Direction at TRISE0_bit;
sbit LCD_EN_Direction at TRISE1_bit;

sbit LCD_D7_Direction at TRISD7_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D4_Direction at TRISD4_bit;

unsigned int AD;        //0..1023
char TXT[7];
char TXT2[7];
unsigned short Temperatura;

int hhh, mmm, sss;
int critic_hhh, critic_mmm;

char ENTER[2] = {13,0};

char ENTRADA[33]; //32 para o dado entrado + reserva do NULL

int temp;
char _char;

int cnt = 0;
unsigned int cnt2 = 0;

char tempTeclas[4];
char Tecla;
int iteracao = 0;
char HORA_TXT[20];
int meta = 0;
int peca_por_min = 0;

void interrupt() {
  if(int0if_bit)
    {
      cnt2++;
      PORTA.F2 = ~PORTA.F2;
      int0if_bit=0;   // clear int0if_bit

    }

  if (TMR2IF_bit) {
    cnt++;
    if (cnt >= 1000) {
    if (peca_por_min == 0) {
          peca_por_min = cnt2 * 60;
          ;
     }
      PORTA.F1 = ~PORTA.F1;
      cnt = 0;
    }
    TMR2IF_bit = 0;        // clear TMR2IF
  }
}

void InitTimer2(){
  T2CON         = 0x3C;
  TMR2IE_bit         = 1;
  PR2                 = 249;
  INTCON         = 0xD0;  //INTCON = 1100 0000 (HABILITA TMR2 INTERRUPT E INT0 INTERRUPT)
}

short Le_Teclado()
{
  PORTD = 0B00010000; // VOCÊ SELECIONOU LA
  if (PORTA.RA5 == 1) {while(PORTA.RA5==1); return '7';};
  if (PORTB.RB1 == 1) {while(PORTB.RB1==1); return '8';};
  if (PORTB.RB2 == 1) {while(PORTB.RB2==1); return '9';};
  if (PORTB.RB3 == 1) {while(PORTB.RB3==1); return '%';};

  PORTD = 0B00100000; // VOCÊ SELECIONOU LB
  if (PORTA.RA5 == 1) {while(PORTA.RA5==1);return '4';};
  if (PORTB.RB1 == 1) {while(PORTB.RB1==1);return '5';};
  if (PORTB.RB2 == 1) {while(PORTB.RB2==1);return '6';};
  if (PORTB.RB3 == 1) {while(PORTB.RB3==1);return '*';};

  PORTD = 0B01000000; // VOCÊ SELECIONOU LC
  if (PORTA.RA5 == 1) {while(PORTA.RA5==1);return '1';};
  if (PORTB.RB1 == 1) {while(PORTB.RB1==1);return '2';};
  if (PORTB.RB2 == 1) {while(PORTB.RB2==1);return '3';};
  if (PORTB.RB3 == 1) {while(PORTB.RB3==1);return '-';};

  PORTD = 0B10000000; // VOCÊ SELECIONOU LD
  if (PORTA.RA5 == 1) {while(PORTA.RA5==1);return 'C';};
  if (PORTB.RB1 == 1) {while(PORTB.RB1==1);return '0';};
  if (PORTB.RB2 == 1) {while(PORTB.RB2==1);return '=';};
  if (PORTB.RB3 == 1) {while(PORTB.RB3==1);return '+';};

  return 255;
}

void Pula_Linha(void)
{
 UART1_WRITE(13);
 UART1_WRITE(10);
}

void Move_Delay() {                  // Function used for text moving
  Delay_ms(100);                     // You can change the moving speed here
}

const char character_0[] = {0,0,4,14,31,14,14,14};
const char character_1[] = {14,14,14,31,14,4,0,0};

void CustomChar() {
  char i;
    LCD_Cmd(64); //entra na
    for (i = 0; i<=7; i++) LCD_Chr_Cp(character_0[i]); //grava 8 bytes na cgram ENDER 0 a 7  cgram
        for (i = 0; i<=7; i++) LCD_Chr_Cp(character_1[i]); //grava 8 bytes na cgram ENDER 8 a 15 cgram
    LCD_Cmd(_LCD_RETURN_HOME); //sai da cgram
}

void Alert()
{
 int i;
 for(i=0; i<1; i++) {               // Move text to the right 4 times
      Lcd_Cmd(_LCD_SHIFT_RIGHT);
      Move_Delay();
      }
 for(i=0; i<1; i++) {               // Move text to the left 4 times
      Lcd_Cmd(_LCD_SHIFT_LEFT);
      Move_Delay();
      }
}

void Write_EEPROM(int END, int DADO)
{
  I2C1_Start();           // issue I2C start signal
  I2C1_Wr(0xA0);          // send byte via I2C  (device address + W)
  I2C1_Wr(END);             // send byte (address of EEPROM location)
  I2C1_Wr(DADO);          // send data (data to be written)
  I2C1_Stop();            // issue I2C stop signal
  delay_ms(10);
}

int Read_EEPROM(int END)
{
  int Dado;
  I2C1_Start();           // issue I2C start signal
  I2C1_Wr(0xA0);          // send byte via I2C  (device address + W)
  I2C1_Wr(END);             // send byte (data address)
  I2C1_Repeated_Start();  // issue I2C signal repeated start
  I2C1_Wr(0xA1);          // send byte (device address + R)
  Dado = I2C1_Rd(0u);    // Read the data (NO acknowledge)
  I2C1_Stop();            // issue I2C stop signal
  return(Dado);
}

void Write_RTC(int END, int DADO)
{
  I2C1_Start();           // issue I2C start signal
  I2C1_Wr(0xD0);          // send byte via I2C  (device address + W)
  I2C1_Wr(END);             // send byte (address of EEPROM location)
  I2C1_Wr(DADO);          // send data (data to be written)
  I2C1_Stop();            // issue I2C stop signal
}

int Read_RTC(int END)
{
  int Dado;
  I2C1_Start();           // issue I2C start signal
  I2C1_Wr(0xD0);          // send byte via I2C  (device address + W)
  I2C1_Wr(END);             // send byte (data address)
  I2C1_Repeated_Start();  // issue I2C signal repeated start
  I2C1_Wr(0xD1);          // send byte (device address + R)
  Dado = I2C1_Rd(0u);    // Read the data (NO acknowledge)
  I2C1_Stop();            // issue I2C stop signal
  return(Dado);
}

// bcd para binario
void Transform_Time(char *sec, char *min, char *hr) {
  *sec = ((*sec & 0xF0) >> 4)*10 + (*sec & 0x0F);
  *min = ((*min & 0xF0) >> 4)*10 + (*min & 0x0F);
  *hr = ((*hr & 0xF0) >> 4)*10 + (*hr & 0x0F);
}

void main()
 {
        UART1_Init(19200);
        I2C1_Init(100000);// i2c para acessar ID = D0h  = RTC

        ADCON1=0B00001110;
        TRISB = 0B00001111;
        PORTB = 0B00000000;
        Lcd_Init();

        TRISA=0B00100001;
        InitTimer2();

        Lcd_Cmd(_LCD_CURSOR_OFF);
        CustomChar();
        Lcd_Out(1, 2, "DIGITE A SENHA");
         while(1)
            {
               Tecla = Le_Teclado() ;
               if (Tecla == '=') {
                  break;
               }
               if (Tecla == '0') {
                  Write_EEPROM(0, 0xFF);
                  break;
               }
               
            }
        if (Read_EEPROM(0) == 0xFF) {
          Lcd_Out(1, 2, "DIGITE A META");
          while(1)
            {
               Tecla = Le_Teclado() ;
               if (Tecla == '=') {
                  meta = atoi(tempTeclas);
                  Write_EEPROM(0, meta);
                  cnt2 = 0;
                  cnt = 0;
                break;
               }
               if(!(Tecla==255)) {
                 tempTeclas[iteracao] = Tecla;
                 iteracao = iteracao + 1;
               }
               lcd_Out(2, 5, tempTeclas);
            }
          } else {
            meta = Read_EEPROM(0);
          }
        Lcd_Out(1, 1, "HORA: ");
        Lcd_Out(2, 1, "QTD PECA Prod POR MIN:");
        Lcd_Out(3, 1, "META: ");
        Lcd_Out(3, 5, "PROD:");
        
        inttostr(peca_por_min, TXT);
                 Lcd_Out(3, 10, TXT);
                inttostr(meta, TXT);
                Lcd_Out(3, 6, TXT);

        while(1)
        {
                sss = Read_RTC(0); //le segundos
                mmm = Read_RTC(1); //le minutos
                hhh = Read_RTC(2); //le horas
                Transform_Time(&sss,&mmm,&hhh);
                sprintf(HORA_TXT, "%02d:%02d:%02d ",hhh,mmm,sss);
                lcd_Out(1, 7, HORA_TXT);
                if (peca_por_min >= meta) {
                   lcd_Out(4, 1, "META ATINGIDA ");
                   Lcd_Chr_Cp(0);
                } else {
                   lcd_Out(4, 1, "ABAIXO DA META");
                   Lcd_Chr_Cp(1);
                }
        }
}
