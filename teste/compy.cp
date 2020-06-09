#line 1 "C:/Users/jorge/git/PIC/teste/compy.c"
#line 1 "c:/users/jorge/git/pic/teste/__t6963c.h"
#line 165 "c:/users/jorge/git/pic/teste/__t6963c.h"
void T6963C_init(unsigned int w, unsigned char h, unsigned char fntW);
void T6963C_writeData(unsigned char mydata);
void T6963C_writeCommand(unsigned char mydata);
void T6963C_setPtr(unsigned int addr, unsigned char t);
void T6963C_waitReady(void);
void T6963C_fill(unsigned char mydata, unsigned int start, unsigned int len);
void T6963C_dot(int x, int y, unsigned char color);
void T6963C_write_char(unsigned char c, unsigned char x, unsigned char y, unsigned char mode);
void T6963C_write_text(unsigned char *str, unsigned char x, unsigned char y, unsigned char mode);
void T6963C_line(int px0, int py0, int px1, int py1, unsigned char pcolor);
void T6963C_rectangle(int x0, int y0, int x1, int y1, unsigned char pcolor);
void T6963C_box(int x0, int y0, int x1, int y1, unsigned char pcolor);
void T6963C_circle(int x, int y, long r, unsigned char pcolor);
void T6963C_image(const char *pic);
void T6963C_sprite(unsigned char px, unsigned char py, const char *pic, unsigned char sx, unsigned char sy);
void T6963C_set_cursor(unsigned char x, unsigned char y);
#line 185 "c:/users/jorge/git/pic/teste/__t6963c.h"
extern sfr char T6963C_dataPort;
extern sfr char T6963C_cntlPort;

extern unsigned int T6963C_grWidth;
extern unsigned int T6963C_grHeight;
extern unsigned int T6963C_txtCols;

extern unsigned int T6963C_fontWidth;
extern unsigned int T6963C_grHomeAddr;
extern unsigned int T6963C_textHomeAddr;
extern unsigned int T6963C_grMemSize;
extern unsigned int T6963C_txtMemSize;

extern sfr sbit T6963C_cntlwr;
extern sfr sbit T6963C_cntlrd;
extern sfr sbit T6963C_cntlcd;
extern sfr sbit T6963C_cntlrst;

extern unsigned char T6963C_display;
#line 4 "C:/Users/jorge/git/PIC/teste/compy.c"
char T6963C_dataPort at PORTD;

sbit T6963C_ctrlwr at RC2_bit;
sbit T6963C_ctrlrd at RC1_bit;
sbit T6963C_ctrlcd at RC0_bit;
sbit T6963C_ctrlrst at RC5_bit;
sbit T6963C_ctrlwr_Direction at TRISC2_bit;
sbit T6963C_ctrlrd_Direction at TRISC1_bit;
sbit T6963C_ctrlcd_Direction at TRISC0_bit;
sbit T6963C_ctrlrst_Direction at TRISC5_bit;
unsigned int rands = 13;

unsigned char const blank[] = {
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
};

unsigned char const food[] = {
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x80,0x03,0xC0,
0x03,0xC0,0x01,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
};

unsigned char const ghost[] = {
0x00,0x00,0x0F,0xF0,0x1F,0xF8,0x3F,0xFC,0x7F,0xFE,0x73,0xCE,0x73,0xCE,0x7F,0xFE,
0x7F,0xFE,0x7F,0xFE,0x79,0x9E,0x76,0x6E,0x7F,0xFE,0x6E,0xEE,0x44,0x46,0x00,0x00
};

unsigned char const obstacle[] = {
0x00,0x00,0x3F,0xFC,0x5F,0xFA,0x6F,0xF6,0x77,0xEE,0x7B,0xDE,0x7D,0xBE,0x7E,0x7E,
0x7E,0x7E,0x7D,0xBE,0x7B,0xDE,0x77,0xEE,0x6F,0xF6,0x5F,0xFA,0x3F,0xFC,0x00,0x00
};

unsigned char const pacman_up[] = {
0x00,0x00,0x08,0x00,0x18,0x18,0x38,0x3C,0x78,0x7E,0x78,0xFE,0x79,0xCE,0x7B,0xCE,
0x7F,0xFE,0x7F,0xFE,0x7F,0xFE,0x7F,0xFE,0x3F,0xFC,0x1F,0xF8,0x0F,0xF0,0x00,0x00
};

unsigned char const pacman_down[] = {
0x00,0x00,0x0F,0xF0,0x1F,0xF8,0x3F,0xFC,0x7F,0xFE,0x7F,0xFE,0x7F,0xFE,0x7F,0xFE,
0x7B,0xCE,0x79,0xCE,0x78,0xFE,0x78,0x7E,0x38,0x3C,0x18,0x18,0x08,0x00,0x00,0x00
};

unsigned char const pacman_left[] = {
0x00,0x00,0x0F,0xF0,0x1F,0xF8,0x3F,0xFC,0x7C,0xFE,0x7C,0xFE,0x3F,0xFE,0x0F,0xFE,
0x03,0xFE,0x01,0xFE,0x7F,0xFE,0x7F,0xFE,0x3F,0xFC,0x1F,0xF8,0x0F,0xF0,0x00,0x00
};

unsigned char const pacman_right[] = {
0x00,0x00,0x07,0xF0,0x1F,0xF8,0x3F,0xFC,0x3F,0x3E,0x7F,0x3E,0x7F,0xFC,0x7F,0xF8,
0x7F,0xE0,0x7F,0xC0,0x7F,0xFE,0x3F,0xFE,0x3F,0xFC,0x1F,0xF8,0x07,0xF0,0x00,0x00
};

void print(unsigned char line, unsigned char column, code const unsigned char* sprite) {
  T6963C_display. F3  = 1; T6963C_writeCommand(T6963C_display) ;
  T6963C_display. F2  = 0; T6963C_writeCommand(T6963C_display) ;
 T6963C_sprite((column - 1) * 16, (line - 1) * 16, sprite, 16, 16);
}

void print_text(unsigned char line, unsigned char column, unsigned char* text) {
  T6963C_display. F3  = 0; T6963C_writeCommand(T6963C_display) ;
  T6963C_display. F2  = 1; T6963C_writeCommand(T6963C_display) ;
 T6963C_write_text(text, line - 1, column - 1,  0b10000001 );
}

int world[8][15];
int i = 0;
int j = 0;
int pacman_x = 1;
int pacman_y = 1;

int ghost_x = 1;
int ghost_y = 14;

int new_ghost_y = 0;
int new_ghost_x = 0;

char pacman_orientation = (char) 0;
char barrier_orientation = (char) 4;
char food_orientation = (char) 5;
char ghost_orientation = (char) 6;

unsigned int AD;
unsigned int QTD_FOOD = 7;
int IS_FINISH = 0;
int IS_GAME_OVER = 0;
char TXT[7];
unsigned long next = 1;

int hhh, mmm, sss;
int critic_hhh, critic_mmm;

char ENTER[2] = {13,0};
char ENTRADA[33];

int temp;
char _char;


int cnt = 0;
int cnt2 = 0;
void InitTimer2(){
 T2CON = 0x3C;
 TMR2IE_bit = 1;
 PR2 = 249;
 INTCON = 0xD0;
}

void external_interrupt() {
 PORTA.F2 = ~PORTA.F2;
}

char old_ghost_obj = 0;
void interrupt() {
 if(int0if_bit)
 {
 cnt2++;
 if (cnt2 > 180) {
 IS_FINISH = 1;
 IS_GAME_OVER = 1;
 }
 new_ghost_y = ghost_y;
 new_ghost_x = ghost_x;
 if (cnt2 % 6 == 0) {
 if (pacman_y > ghost_y) {
 new_ghost_y = (ghost_y + 1);
 } else if (pacman_y < ghost_y) {
 new_ghost_y = (ghost_y - 1);
 } else {
 if (pacman_x > ghost_x) {
 new_ghost_x = (ghost_x + 1);

 } else if (pacman_x < ghost_x) {
 new_ghost_x = (ghost_x - 1);
 }
 }
 if (world[new_ghost_x][new_ghost_x] == barrier_orientation) {
 new_ghost_x = new_ghost_x + 1;
 }
 world[ghost_x][ghost_y] = old_ghost_obj != 0 ? old_ghost_obj : ' ';
 old_ghost_obj = world[ghost_x][ghost_x] != ghost_orientation ? world[new_ghost_x][new_ghost_y] : ' ';
 world[new_ghost_x][new_ghost_y] = ghost_orientation;

 ghost_y = new_ghost_y;
 ghost_x = new_ghost_x;
 }
 int0if_bit=0;
 }

 if (TMR2IF_bit) {
 cnt++;
 if (cnt >= 1000) {
 PORTA.F1 = ~PORTA.F1;
 cnt = 0;
 }
 TMR2IF_bit = 0;
 }
}

char Le_Teclado()
{
 PORTD = 0B00010000;
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

 PORTD = 0B00100000;
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

 PORTD = 0B01000000;
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

 PORTD = 0B10000000;
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

void Move_Delay() {
 Delay_ms(100);
}


const int GHOST_COUNT = 0;

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
 I2C1_Start();
 I2C1_Wr(0xD0);
 I2C1_Wr(END);
 I2C1_Repeated_Start();
 I2C1_Wr(0xD1);
 Dado = I2C1_Rd(0u);
 I2C1_Stop();
 return(Dado);
}

int food_x = 0;
int food_y = 0;
void Create_World() {
 for(i = 0; i < 15; ++i) {
 for(j = 0; j < 15 ; ++j)
 {
 world[i][j] = ' ';
 }
 }

 world[4][myrand(rands * 5) & 0b000000000000000111] = barrier_orientation;
 world[myrand(rands * 1) & 0b000000000000000111][myrand(rands * 1) & 0b000000000000000111] = barrier_orientation;
 world[myrand(rands * 50) & 0b000000000000000111][myrand(rands * 26) & 0b000000000000000111] = barrier_orientation;
 world[myrand(rands * 985) & 0b000000000000000111][myrand(rands * 76) & 0b000000000000000111] = barrier_orientation;

 world[myrand(rands * 12)& 0b000000000000000111][myrand(rands * 500)& 0b000000000000000111] = food_orientation;
 world[myrand(rands * 85)& 0b000000000000000111][myrand(rands * 1)& 0b000000000000000111] = food_orientation;
 world[myrand(rands * 552)& 0b000000000000000111][myrand(rands * 63)& 0b000000000000000111] = food_orientation;
 world[5][11] = food_orientation;
 world[3][5] = food_orientation;
 world[2][8] = food_orientation;
 world[7][7] = food_orientation;

 if (world[ghost_x][ghost_y] == food_orientation) --QTD_FOOD;
 if (world[pacman_x][pacman_y] == food_orientation) --QTD_FOOD;
 world[ghost_x][ghost_y] = ghost_orientation;
 world[pacman_x][pacman_y] = (char) pacman_orientation;
}
char currentCharactere = 0;
const unsigned char* currentSprite;
void Print_World() {

 for(i = 0; i < 15; ++i) {
 for(j = 0; j < 15; ++j)
 {
 currentCharactere = world[i][j];
 if (currentCharactere == 0) {
 currentSprite = pacman_right;
 } else if (currentCharactere == 1) {
 currentSprite = pacman_left;
 } else if (currentCharactere == 2) {
 currentSprite = pacman_up;
 } else if (currentCharactere == 3) {
 currentSprite = pacman_down;
 } else if (currentCharactere == food_orientation) {
 currentSprite = food;
 } else if (currentCharactere == ghost_orientation) {
 currentSprite = ghost;
 } else if (currentCharactere == barrier_orientation) {
 currentSprite = obstacle;
 } else if (currentCharactere == ' ') {
 currentSprite = blank;
 } else {
 currentSprite = blank;
 }
 print(i, j, currentSprite);
 }
 }
}

char update_pacman_orientation(int newX, int newY) {
 if (newX > pacman_x) {
 return (char) 0;
 } else if (newX < pacman_x) {
 return (char) 1;
 } else if (newY > pacman_y) {
 return (char) 2;
 } else if (newY < pacman_y) {
 return 3;
 }
 return pacman_orientation;
}

int newPacman_x = 0;
int newPacman_y = 0;
int newPacmanOrientation = 0;
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

 newPacmanOrientation = update_pacman_orientation(newPacman_x, newPacman_y);

 if (newPacman_x < 0) newPacman_x = 14;
 if (newPacman_x >= 14) newPacman_x = 0;

 if (newPacman_y < 0) newPacman_y = 14;
 if (newPacman_y >= 14) newPacman_y = 0;

 if (world[newPacman_x][newPacman_y] != barrier_orientation) {
 if (world[newPacman_x][newPacman_y] == food_orientation) {
 QTD_FOOD --;
 }
 if (QTD_FOOD == 0) {
 IS_FINISH = 1;
 IS_GAME_OVER = 0;
 }

 pacman_orientation = newPacmanOrientation;

 world[pacman_x][pacman_y] = ' ';
 world[newPacman_x][newPacman_y] = pacman_orientation;

 pacman_x = newPacman_x;
 pacman_y = newPacman_y;
 }
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

void Write_EEPROM_Int(int END, int dado) {
 Write_EEPROM(END, dado / 256);
 Write_EEPROM(END + 1, dado % 256);
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

short byte_1 = 0;
short byte_2 = 0;
int Read_EEPROM_Int(int END) {
 byte_1 = Read_EEPROM(END);
 byte_2 = Read_EEPROM(END + 1);

 return (byte_1 * 256) + byte_2;
}



void Transform_Time(char *sec, char *min, char *hr) {
 *sec = ((*sec & 0xF0) >> 4)*10 + (*sec & 0x0F);
 *min = ((*min & 0xF0) >> 4)*10 + (*min & 0x0F);
 *hr = ((*hr & 0xF0) >> 4)*10 + (*hr & 0x0F);
}

int meta = 0;
char command = (char) 0;
char HORA_TXT[20];

void Start_Screen() {
 print_text(1, 6, "PAC MAN");
 print_text(3, 1, "PRESSIONE UMA TECLA!");

 while (Le_Teclado() == 255);
}

void Finish() {
 for(i = 0; i < 15; ++i) {
 for(j = 0; j < 8; ++j) {
 world[i][j] = ' ';
 }
 }
 Print_World();
 if (IS_GAME_OVER) {
 print_text(2, 1, "Game over");
 } else {
 print_text(2, 1, "Win");
 }
}

void main() {
UART1_Init(19200);
 I2C1_Init(100000);
 ADCON1 = 0B00001110;
 TRISB = 0B00001111;
 TRISA = 0B00100001;

 TRISA3_bit = 1;
 TRISA4_bit = 1;



 T6963C_init(240, 128, 8);
#line 480 "C:/Users/jorge/git/PIC/teste/compy.c"
  T6963C_display. F3  = 1; T6963C_writeCommand(T6963C_display) ;
  T6963C_display. F2  = 1; T6963C_writeCommand(T6963C_display) ;


 InitTimer2();


 Create_World();


 while (1) {
 if (IS_FINISH) {
 break;
 }
 command = Le_Teclado();
 if (command == '8') {
 update_pacman(0);
 } else if (command == '2') {
 update_pacman(1);
 } else if (command == '6') {
 update_pacman(2);
 } else if (command == '4') {
 update_pacman(3);
 }
 Print_World();
 if (pacman_x == ghost_x && pacman_y == ghost_y) {
 IS_FINISH = 1;
 IS_GAME_OVER = 1;
 }
 }
 Finish();

}