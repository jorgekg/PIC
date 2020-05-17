int world[5][21];

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
unsigned int QTD_FOOD = 6;
int IS_FINISH = 0;
int IS_GAME_OVER = 0;
char TXT[7];
unsigned long next = 1;

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

void external_interrupt() {
    PORTA.F2 = ~PORTA.F2;
}


void interrupt() {
  if(int0if_bit)
    {          ;
      cnt2++;
      if (cnt2 > 180) {
         IS_FINISH = 1;
         IS_GAME_OVER = 1;
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


const int GHOST_COUNT = 0;

// Notes
const int DO1 = 65;
const int RE_1 = 73;
const int MI1 = 82;
const int FA1 = 87;
const int SOL1 = 98;
const int LA1 = 110;
const int SI1 = 123;
const int DO2 = 131;

int i = 0;
int j = 0;
int pacman_x = 0;
int pacman_y = 0;

char pacman_orientation = (char) 0;
char barrier_orientation = (char) 4;
char food_orientation = (char) 5;

// Direita
const char character_0[] = {31,30,28,24,24,28,30,31};
// Esquerda
const char character_1[] = {31,15,7,3,3,7,15,31};
// Abaixo
const char character_2[] = {31,31,31,27,17,0,0,0};
// Acima
const char character_3[] = {0,0,0,17,27,31,31,31};
// barreira
const char character_4[] = {31,31,31,31,31,31,31,31};
// Comida
const char character_5[] = {0,0,14,31,31,14,0,0};

void CustomChar() {
  char i;
    LCD_Cmd(64); //entra na
    for (i = 0; i<=7; i++) LCD_Chr_Cp(character_0[i]); //grava 8 bytes na cgram ENDER 0 a 7  cgram
    for (i = 0; i<=7; i++) LCD_Chr_Cp(character_1[i]); //grava 8 bytes na cgram ENDER 8 a 15 cgram
    for (i = 0; i<=7; i++) LCD_Chr_Cp(character_2[i]); //grava 8 bytes na cgram ENDER 8 a 15 cgram
    for (i = 0; i<=7; i++) LCD_Chr_Cp(character_3[i]); //grava 8 bytes na cgram ENDER 8 a 15 cgram
    for (i = 0; i<=7; i++) LCD_Chr_Cp(character_4[i]); //grava 8 bytes na cgram ENDER 8 a 15 cgram
    for (i = 0; i<=7; i++) LCD_Chr_Cp(character_5[i]); //grava 8 bytes na cgram ENDER 8 a 15 cgram
    LCD_Cmd(_LCD_RETURN_HOME); //sai da cgram
}

int myrand(unsigned seed) {
    next = seed;
    next = next * 1103515245 + 12345;
    return((unsigned)(next/65536) % 32768);
}

void mysrand(unsigned seed) {
    next = seed;
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

void Create_World() {
    for(i = 0; i < 20; ++i) {
       for(j = 0; j < 4 ; ++j)
       {
         world[i][j] = ' ';
       }
    }
    // Foi criado um metodo para fazer isso, porem o compilador caga
    world[myrand(Read_RTC(0)) & 0b000000000000010011][myrand(Read_RTC(0) + 1) & 0b000000000000000011] = barrier_orientation;
    world[myrand(Read_RTC(0) + 1) & 0b000000000000010011][myrand(Read_RTC(0) + 2) & 0b000000000000000011] = barrier_orientation;
    world[myrand(Read_RTC(0) + 2) & 0b000000000000010011][myrand(Read_RTC(0) + 3) & 0b000000000000000011] = barrier_orientation;
    world[myrand(Read_RTC(0) + 3) & 0b000000000000010011][myrand(Read_RTC(0) + 4) & 0b000000000000000011] = barrier_orientation;

    world[myrand(Read_RTC(0)) & 0b000000000000010011][myrand(Read_RTC(0) + 10) & 0b000000000000000011] = food_orientation;
    world[myrand(Read_RTC(0) + 10) & 0b000000000000010011][myrand(Read_RTC(0) + 20) & 0b000000000000000011] = food_orientation;
    world[myrand(Read_RTC(0) + 20) & 0b000000000000010011][myrand(Read_RTC(0) + 30) & 0b000000000000000011] = food_orientation;
    world[myrand(Read_RTC(0) + 30) & 0b000000000000010011][myrand(Read_RTC(0) + 45) & 0b000000000000000011] = food_orientation;
    world[myrand(Read_RTC(0) + 30) & 0b000000000000010011][myrand(Read_RTC(0) + 46) & 0b000000000000000011] = food_orientation;
    world[myrand(Read_RTC(0) + 35) & 0b000000000000010011][myrand(Read_RTC(0) + 44) & 0b000000000000000011] = food_orientation;
    world[myrand(Read_RTC(0) + 38) & 0b000000000000010011][myrand(Read_RTC(0) + 47) & 0b000000000000000011] = food_orientation;
    world[pacman_x][pacman_y] = (char) pacman_orientation;
}

void Print_World() {
    for(i = 0; i < 20; ++i) {
       for(j = 0; j < 4; ++j)
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
void update_pacman(short direction) {
  if (direction == 0) {
    newPacman_x = pacman_x;
    newPacman_y = pacman_y - 1;
  } else if (direction == 1) {
    newPacman_x = pacman_x;
    newPacman_y = pacman_y + 1;
  } else if (direction == 2) {
    newPacman_x = pacman_x + 1;
    newPacman_y = pacman_y;
  } else if (direction == 3) {
    newPacman_x = pacman_x - 1;
    newPacman_y = pacman_y;
  }
  if (world[newPacman_x][newPacman_y] != barrier_orientation) {
    if (world[newPacman_x][newPacman_y] == food_orientation) {
       QTD_FOOD --;
    }
    if (QTD_FOOD == 0) {
        IS_FINISH = 1;
        IS_GAME_OVER = 0;
    }
    update_pacman_orientation(newPacman_x, newPacman_y);

    if (newPacman_x < 0) newPacman_x = 19;
    if (newPacman_x >= 20) newPacman_x = 0;

    if (newPacman_y < 0) newPacman_y = 3;
    if (newPacman_y >= 4) newPacman_y = 0;
    world[pacman_x][pacman_y] = ' ';
    world[newPacman_x][newPacman_y] = pacman_orientation;

    pacman_x = newPacman_x;
    pacman_y = newPacman_y;
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

// bcd para binario
void Transform_Time(char *sec, char *min, char *hr) {
  *sec = ((*sec & 0xF0) >> 4)*10 + (*sec & 0x0F);
  *min = ((*min & 0xF0) >> 4)*10 + (*min & 0x0F);
  *hr = ((*hr & 0xF0) >> 4)*10 + (*hr & 0x0F);
}

void Play_Intro_Music() {
    Sound_Play(DO1, 200);
    Sound_Play(DO1, 200);
    Sound_Play(RE1, 200);
    Sound_Play(DO1, 200);
    Sound_Play(FA1, 1000);
    Delay_ms(500);
    Sound_Play(DO2, 100);
    Sound_Play(SI1, 100);
    Sound_Play(LA1, 100);
    Sound_Play(SOL1, 100);
    Sound_Play(FA1, 100);
    Sound_Play(MI1, 100);
    Sound_Play(RE_1, 100);
    Sound_Play(DO1, 100);
    Delay_ms(500);
    Sound_Play(DO1, 100);
    Delay_ms(1000);
}

int meta = 0;
char command = (char) 0;
char HORA_TXT[20];

void Start_Screen() {
    Lcd_Out(1, 6, "PAC MAN ");
    Lcd_Chr_Cp(0);
    Play_Intro_Music();

    Lcd_Out(3, 1, "PRESSIONE UMA TECLA!");

    while (Le_Teclado() == 255);
}

void Finish() {
     for(i = 0; i < 20; ++i) {
       for(j = 0; j < 4 ; ++j)
       {
         world[i][j] = ' ';
       }
    }
    Print_World();
    if (IS_GAME_OVER) {
     Lcd_Out(2, 1, "Game over");
    } else {
     Lcd_Out(2, 1, "Win");
    }
}
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

        InitTimer2();

        Sound_Init(&PORTC, 5);

        // Start_Screen();
        Create_World();
        Print_World();

        while (1) {
            if (IS_FINISH) {
              break;
            }
            command = Le_Teclado();
            if (command == '8') {
              Sound_Play(FA1, 50);
              update_pacman(0);
            } else if (command == '2') {
              Sound_Play(FA1, 50);
              update_pacman(1);
            } else if (command == '6') {
              Sound_Play(FA1, 50);
              update_pacman(2);
            } else if (command == '4') {
              Sound_Play(FA1, 50);
              update_pacman(3);
            }
            Print_World();
        }
        Finish();
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
