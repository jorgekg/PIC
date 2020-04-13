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
unsigned short Temperatura;



int hhh, mmm, sss, mmmt, hhht;



char ENTER[2] = {13,0};



char ENTRADA[33]; //32 para o dado entrado + reserva do NULL
char TIME[5];


int temp;




void Pula_Linha(void)
{
     UART1_WRITE(13);
     UART1_WRITE(10);
}



void Move_Delay() {                  // Function used for text moving
  Delay_ms(100);                     // You can change the moving speed here
}



const char character_0[] = {3,3,0,0,0,0,0,0};
const char character_1[] = {1,1,1,1,1,1,1,1};



void CustomChar() {
  char i;
    LCD_Cmd(64); //entra na CGRAM
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


char HORA_TXT[20];
char t[2];
char tzao[5];
int temAtual;

void main()
 {
        UART1_Init(19200);

        I2C1_Init(100000);// i2c para acessar ID = D0h  = RTC
        
        if (PORTB.F6 == 1) {
          Write_EEPROM(0, 0xFF);
          Write_EEPROM(1, 0xFF);
          Write_EEPROM(2, 0xFF);
        }

        // Pega a Temperatura atual;
        if (Read_EEPROM(1) == 0xFF) {
          UART1_Write_Text("\r QUAL HORARIO MONITORAR\r");
          while(!(UART1_Data_Ready() == 1));         //AGUARDA CHEGAR ALGO NA SERIAL VINDO DO TERMINAL BURRO
          UART1_Read_Text(TIME, ENTER, 37);
          UART1_Write_Text(TIME);
          t[0] = TIME[0];
          t[1] = TIME[1];
          hhht=atoi(t);
          Write_EEPROM(1, hhht);
          t[0] = TIME[3];
          t[1] = TIME[4];
          mmmt=atoi(t);
          Write_EEPROM(2,mmmt);
        } else {
          hhht = Read_EEPROM(1);
          IntToStr(hhht, tzao);
          TIME[0] = tzao[4];
          TIME[1] = tzao[5];
          TIME[2] = ':';
          mmmt = Read_EEPROM(2);
          IntToStr(mmmt, tzao);
          if (mmmt < 10) {
             TIME[3] = '0';
             TIME[4] = tzao[5];
          } else {
             TIME[3] = tzao[4];
             TIME[4] = tzao[5];
          }
        }

        if (Read_EEPROM(0) == 0xFF) {
          UART1_Write_Text("QUAL A TEMPERATURA MAXIMA\r");
          while(!(UART1_Data_Ready() == 1));         //AGUARDA CHEGAR ALGO NA SERIAL VINDO DO TERMINAL BURRO
          UART1_Read_Text(ENTRADA, ENTER, 32);
          temAtual=atoi(ENTRADA);
          Write_EEPROM(0, temAtual);
        } else {
          temAtual = Read_EEPROM(0);
        }

        ADCON1=0B00001110;
        TRISB = 0B00001111;
        PORTB = 0B00000000;
        Lcd_Init();
        Lcd_Cmd(_LCD_CURSOR_OFF);
        CustomChar();

        Lcd_Out(1, 2, "TEMPERATURA ATUAL");
        Lcd_Out(3, 2, "TEMPERATURA MAXIMA");
        inttostr(temAtual, TXT);
        lcd_Out(4, 12, TXT);
        lcd_chr_cp(0);
        lcd_chr_cp('C');

        while(1)
        {
                // Le a Temperatura atual.
                sss= Read_RTC(0); //le segundos
                mmm= Read_RTC(1); //le minutos
                hhh= Read_RTC(2); //le horas
                
                // transforma para decimal;
                Transform_Time(&sss,&mmm,&hhh);
                
                // Mostra a hora atual
                sprintf(HORA_TXT, "%02d:%02d:%02d",hhh,mmm,sss);
                lcd_Out(4,1,HORA_TXT);
                
                // Pega a Temperatura do sensor;
                AD = ADC_Read(0);
                Temperatura = ((float) AD * 5.0/1024.0) * 100.0;
                inttostr(Temperatura, TXT);
                Lcd_Out(2, 1, TIME);
                Lcd_Out(2, 8, TXT);
                Lcd_Chr_Cp(0);
                Lcd_Chr_CP('C');
                if(Temperatura >= temAtual && mmmt == mmm && hhh == hhht)
                    Alert();

        }
}
