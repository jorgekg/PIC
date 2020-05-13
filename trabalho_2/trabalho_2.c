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

int hhh, mmm, sss;
int critic_hhh, critic_mmm;

char ENTER[2] = {13,0};

char ENTRADA[33]; //32 para o dado entrado + reserva do NULL

int temp;
char _char;

/* Interrupção */
int cnt = 0;
int cnt2 = 0;
void InitTimer2(){
  T2CON         = 0x3C;
  TMR2IE_bit         = 1;
  PR2                 = 249;
  INTCON         = 0xD0;  //INTCON = 1100 0000 (HABILITA TMR2 INTERRUPT E INT0 INTERRUPT)
}

int total_pecas = 0;
int pecas_parcial = 0;
void external_interrupt() {
    PORTA.F2 = ~PORTA.F2;
}


void interrupt() {
  if(int0if_bit)
    {
      cnt2++;
      if(cnt2 > 1){
         cnt2=0;
         external_interrupt();
      }
      int0if_bit=0;   // clear int0if_bit
    }

  if (TMR2IF_bit) {
    cnt++;
    if (cnt >= 1000) {
      PORTA.F1 = ~PORTA.F1;
      cnt = 0;
    }
    TMR2IF_bit = 0;        // clear TMR2IF
  }
}

char Le_Teclado()
{
  PORTD = 0B00010000; // VOCÊ SELECIONOU LA
  if (PORTA.RA5 == 1) {
    while(PORTA.RA5 == 1);
    return '7';
  }
  if (PORTB.RB1 == 1) {
    while(PORTB.RB1 == 1);
    return '8';
  }
  if (PORTB.RB2 == 1) {
    while(PORTB.RB2 == 1);
    return '9';
  }
  if (PORTB.RB3 == 1) {
    while(PORTB.RB3 == 1);
    return '%';
  }

  PORTD = 0B00100000; // VOCÊ SELECIONOU LB
  if (PORTA.RA5 == 1) {
    while(PORTA.RA5 == 1);
    return '4';
  }
  if (PORTB.RB1 == 1) {
    while(PORTB.RB1 == 1);
    return '5';
  }
  if (PORTB.RB2 == 1) {
    while(PORTB.RB2 == 1);
    return '6';
  }
  if (PORTB.RB3 == 1) {
    while(PORTB.RB3 == 1);
    return '*';
  }

  PORTD = 0B01000000; // VOCÊ SELECIONOU LC
  if (PORTA.RA5 == 1) {
    while(PORTA.RA5 == 1);
    return '1';
  }
  if (PORTB.RB1 == 1) {
    while(PORTB.RB1 == 1);
    return '2';
  }
  if (PORTB.RB2 == 1) {
    while(PORTB.RB2 == 1);
    return '3';
  }
  if (PORTB.RB3 == 1) {
    while(PORTB.RB3 == 1);
    return '-';
  }

  PORTD = 0B10000000; // VOCÊ SELECIONOU LD
  if (PORTA.RA5 == 1) {
    while(PORTA.RA5 == 1);
    return 'C';
  }
  if (PORTB.RB1 == 1) {
    while(PORTB.RB1 == 1);
    return '0';
  }
  if (PORTB.RB2 == 1) {
    while(PORTB.RB2 == 1);
    return '=';
  }
  if (PORTB.RB3 == 1) {
    while(PORTB.RB3 == 1);
    return '+';
  }

  return (char) 255;
}

void Pula_Linha(void)
{
 UART1_WRITE(13);
 UART1_WRITE(10);
}

void Move_Delay() {                  // Function used for text moving
  Delay_ms(100);                     // You can change the moving speed here
}

const int WORLD_WIDTH = 20;
const int WORLD_HEIGHT = 4;
const int GHOST_COUNT = 0;

int i = 0;
int j = 0;
int pacman_x = 0;
int pacman_y = 0;

char world[WORLD_HEIGHT][WORLD_WIDTH];
char pacman_orientation = (char) 0;

// Direita
const char character_0[] = {31,30,28,24,24,28,30,31};
// Esquerda
const char character_1[] = {31,15,7,3,3,7,15,31};
// Abaixo
const char character_2[] = {31,31,31,27,17,0,0,0};
// Acima
const char character_3[] = {0,0,0,17,27,31,31,31};

void CustomChar() {
  char i;
    LCD_Cmd(64); //entra na
    for (i = 0; i<=7; i++) LCD_Chr_Cp(character_0[i]); //grava 8 bytes na cgram ENDER 0 a 7  cgram
    for (i = 0; i<=7; i++) LCD_Chr_Cp(character_1[i]); //grava 8 bytes na cgram ENDER 8 a 15 cgram
    for (i = 0; i<=7; i++) LCD_Chr_Cp(character_2[i]); //grava 8 bytes na cgram ENDER 8 a 15 cgram
    for (i = 0; i<=7; i++) LCD_Chr_Cp(character_3[i]); //grava 8 bytes na cgram ENDER 8 a 15 cgram
    LCD_Cmd(_LCD_RETURN_HOME); //sai da cgram
}

void Create_World() {
    for(i = 0; i < WORLD_WIDTH; ++i) {
       for(j = 0; j < WORLD_HEIGHT ; ++j)
       {
         world[i][j] = ' ';
       }
    }
    world[pacman_x][pacman_y] = (char) pacman_orientation;
}

void Print_World() {
    for(i = 0; i < WORLD_WIDTH; ++i) {
       for(j = 0; j < WORLD_HEIGHT; ++j)
       {
         Lcd_Chr(j + 1, i + 1, world[i][j]);
       }
    }
}

void update_pacman_orientation(int newX, int newY) {
  if (newX > pacman_x) {
    pacman_orientation = (char) 0;
  } else if (newX < pacman_x) {
    pacman_orientation = (char) 1;
  } else if (newY > pacman_y) {
    pacman_orientation = (char) 2;
  } else if (newY < pacman_y) {
    pacman_orientation = (char) 3;
  }
}

int newPacman_x = 0;
int newPacman_y = 0;
void update_pacman(char direction[]) {
  if (strcmp(direction, "cima") == 0) {
    newPacman_x = pacman_x;
    newPacman_y = pacman_y - 1;
  } else if (strcmp(direction, "baixo") == 0) {
    newPacman_x = pacman_x;
    newPacman_y = pacman_y + 1;
  } else if (strcmp(direction, "direita") == 0) {
    newPacman_x = pacman_x + 1;
    newPacman_y = pacman_y;
  } else if (strcmp(direction, "esquerda") == 0) {
    newPacman_x = pacman_x - 1;
    newPacman_y = pacman_y;
  }

  update_pacman_orientation(newPacman_x, newPacman_y);

  if (newPacman_x < 0) newPacman_x = WORLD_WIDTH - 1;
  if (newPacman_x >= WORLD_WIDTH) newPacman_x = 0;

  if (newPacman_y < 0) newPacman_y = WORLD_HEIGHT - 1;
  if (newPacman_y >= WORLD_HEIGHT) newPacman_y = 0;
  world[pacman_x][pacman_y] = ' ';
  world[newPacman_x][newPacman_y] = (char) pacman_orientation;
  
  pacman_x = newPacman_x;
  pacman_y = newPacman_y;
}

void Alert(int show)
{
  Lcd_Chr(4, 8, show ? 0 : ' ');
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

void Write_EEPROM_Int(int END, int dado) {
  Write_EEPROM(END, dado / 256);
  Write_EEPROM(END + 1, dado % 256);
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

short byte_1 = 0;
short byte_2 = 0;
int Read_EEPROM_Int(int END) {
   byte_1 = Read_EEPROM(END);
   byte_2 = Read_EEPROM(END + 1);

   return (byte_1 * 256) + byte_2;
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

void Le_Entrada_Cmd(char slot[], int showInput, int row, int column) {
    for (i = 0; i < sizeof(slot); i++) {
        slot[i] = 0;
    }
    i = 0;
    while((_char = Le_Teclado()) != '=')
    {
        if (_char != 255) {
          if (_char == '*') {
            if (i > 0) i--;
            slot[i] = 0;
            if (showInput) {
              Lcd_Out(row, column + i, " ");
            }
          } else {
            slot[i] = _char;
            i++;
            if (showInput) {
              Lcd_Out(row, column, slot);
            }
          }
        }
    }
}

void Le_Entrada(char slot[]) {
    Le_Entrada_Cmd(slot, 0, 0, 0);
}

void Le_Entrada_Cp(char slot[], int row, int column) {
    Le_Entrada_Cmd(slot, 1, row, column);
}

int meta = 0;
char command = 0;
char HORA_TXT[20];
void main()
 {
        UART1_Init(19200);
        I2C1_Init(100000);// i2c para acessar ID = D0h  = RTC

        ADCON1 = 0B00001110;
        TRISB = 0B00001111;
        TRISA = 0B00100001;
        Lcd_Init();

        Lcd_Cmd(_LCD_CURSOR_OFF);
        CustomChar();
        
        Create_World();
        InitTimer2();
        
        while (1) {
            command = Le_Teclado();
            
            if (command == '8') {
              update_pacman("cima");
            } else if (command == '2') {
              update_pacman("baixo");
            } else if (command == '6') {
              update_pacman("direita");
            } else if (command == '4') {
              update_pacman("esquerda");
            }
            
            Print_World();
        }

        /*
        while(1)
        {
                command = Le_Teclado();
                if (command == 'C') {
                     Lcd_Cmd(_LCD_CLEAR);
                     Lcd_Out(2, 2, "MODO CONFIGURACAO");
                     Delay_ms(1000);

                     Write_EEPROM_Int(0, 0);
                }

                meta = Read_EEPROM_Int(0);

                if (meta == 0) {
                  Lcd_Cmd(_LCD_CLEAR);
                  Lcd_Out(2, 2, "CONFIGURANDO A ");
                  Lcd_Out(3, 2, "META");
                  Delay_ms(2000);
                  Lcd_Cmd(_LCD_CLEAR);
                  Lcd_Out(1, 2, "QUAL A META");
                  Lcd_Out(2, 2, "ESPERADA?");
                  Lcd_Out(3, 2, "R.: ");
                  Le_Entrada_Cp(ENTRADA, 3, 6);
                  meta=atoi(ENTRADA);
                  Write_EEPROM_Int(0, meta);

                  drawInfoLabel = 1;
                }

                if (drawInfoLabel) {
                    Lcd_Cmd(_LCD_CLEAR);
                    Lcd_Out(1, 2, "HORA:");
                    Lcd_Out(2, 2, "PCS P/ MIN:");
                    Lcd_Out(3, 2, "PCS TOT:");
                    Lcd_Out(4, 2, "META:");
                    drawInfoLabel = 0;
                }

                sss = Read_RTC(0); // le segundos
                mmm = Read_RTC(1); // le minutos
                hhh = Read_RTC(2); // le horas
                Transform_Time(&sss,&mmm,&hhh);
                sprintf(HORA_TXT, "%02d:%02d:%02d",hhh,mmm,sss);
                lcd_Out(1, 8, HORA_TXT);

                if (last_second != sss) {
                  diff_seconds++;
                  if (diff_seconds >= 60) {
                    calculo_pecas_parcial = pecas_parcial;
                    sprintf(TXT, "%02d", calculo_pecas_parcial);
                    lcd_Out(2, 14, TXT);

                    pecas_parcial = 0;
                    diff_seconds = 0;
                  }
                  last_second = sss;
                }

                sprintf(TXT, "%02d", total_pecas);
                lcd_Out(3, 11, TXT);

                sprintf(TXT, "%02d", meta);
                lcd_Out(4, 9, TXT);

                Alert(calculo_pecas_parcial >= meta);
        }
        */
}