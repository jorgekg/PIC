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
int isStarted = 0;


const int DO1 = 65;
const int RE_1 = 73;
const int MI1 = 82;
const int FA1 = 87;
const int SOL1 = 98;
const int LA1 = 110;
const int SI1 = 123;
const int DO2 = 131;

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

void print(unsigned char column, unsigned char line, code const unsigned char* sprite) {
  T6963C_display. F3  = 1; T6963C_writeCommand(T6963C_display) ;
  T6963C_display. F2  = 0; T6963C_writeCommand(T6963C_display) ;
 T6963C_sprite(column * 16, line * 16, sprite, 16, 16);
}

void print_text(unsigned char column, unsigned char line, unsigned char* text) {
  T6963C_display. F3  = 0; T6963C_writeCommand(T6963C_display) ;
  T6963C_display. F2  = 1; T6963C_writeCommand(T6963C_display) ;
 T6963C_write_text(text, line - 1, column - 1,  0b10000001 );
}

long world[8][15];

int i = 0;
int j = 0;
int pacman_x = 0;
int pacman_y = 0;

int ghost_x = 14;
int ghost_y = 0;

int new_ghost_y = 0;
int new_ghost_x = 0;

char pacman_orientation = 1;
char barrier_orientation = 4;
char food_orientation = 5;
char ghost_orientation = 6;

const unsigned char* getSprite(char charactereValue) {
 if (charactereValue == 0) {
 return pacman_up;
 } else if (charactereValue == 1) {
 return pacman_right;
 } else if (charactereValue == 2) {
 return pacman_down;
 } else if (charactereValue == 3) {
 return pacman_left;
 } else if (charactereValue == food_orientation) {
 return food;
 } else if (charactereValue == ghost_orientation) {
 return ghost;
 } else if (charactereValue == barrier_orientation) {
 return obstacle;
 }
 return blank;
}

void printCoordinate(int x, int y) {
 print(x, y, getSprite(world[x][y]));
}
unsigned int QTD_FOOD = 3;
int IS_FINISH = 0;
int IS_GAME_OVER = 0;

int cnt = 0;
int cnt2 = 0;
void InitTimer2(){
 T2CON = 0x3C;
 TMR2IE_bit = 1;
 PR2 = 249;
 INTCON = 0xD0;
}

int generate_food_bool = 0;

int move_ghost_bool = 0;
char old_ghost_obj = ' ';
void move_ghost() {
 new_ghost_x = ghost_x;

 if (pacman_x > ghost_x) {
 new_ghost_x = ghost_x + 1;
 } else if (pacman_x < ghost_x) {
 new_ghost_x = ghost_x - 1;
 }

 if (world[new_ghost_x][ghost_y] == barrier_orientation) {
 new_ghost_x = ghost_x;
 if (world[ghost_x][ghost_y + 1] != barrier_orientation) {
 new_ghost_y = ghost_y + 1;
 } else if (world[ghost_x][ghost_y - 1] != barrier_orientation) {
 new_ghost_y = ghost_y - 1;
 }
 } else if (new_ghost_x == ghost_x) {
 if (pacman_y > ghost_y && world[ghost_x][ghost_y + 1] != barrier_orientation) {
 new_ghost_y = ghost_y + 1;
 } else if (pacman_y < ghost_y && world[ghost_x][ghost_y - 1] != barrier_orientation) {
 new_ghost_y = ghost_y - 1;
 }
 }

 world[ghost_x][ghost_y] = old_ghost_obj;
 printCoordinate(ghost_x, ghost_y);

 old_ghost_obj = world[new_ghost_x][new_ghost_y];
 world[new_ghost_x][new_ghost_y] = ghost_orientation;
 printCoordinate(new_ghost_x, new_ghost_y);

 ghost_y = new_ghost_y;
 ghost_x = new_ghost_x;
}


void interrupt() {
 if(int0if_bit)
 {
 cnt2++;
 if (cnt2 > 180) {
 IS_FINISH = 1;
 IS_GAME_OVER = 1;
 }
 int0if_bit = 0;
 }

 if (TMR2IF_bit) {
 cnt++;
 if (cnt >= 10000) {
 cnt = 0;
 }
 if (cnt % 5000 == 0) {
 if (isStarted) {
 generate_food_bool = 1;
 }
 }
 if (cnt % 1000 == 0) {
 if (isStarted) {
 move_ghost_bool = 1;
 }
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

void Print_World() {
 for(i = 0; i < 15; ++i) {
 for(j = 0; j < 8; ++j)
 {
 printCoordinate(i, j);
 }
 }
}

void Create_World() {
 for(i = 0; i < 15; ++i) {
 for(j = 0; j < 8 ; ++j)
 {
 world[i][j] = ' ';
 }
 }
 world[5][0] = barrier_orientation;
 world[5][1] = barrier_orientation;
 world[2][5] = barrier_orientation;
 world[11][5] = barrier_orientation;
 world[10][6] = barrier_orientation;
 world[3][5] = barrier_orientation;
 world[4][5] = barrier_orientation;
 world[11][5] = barrier_orientation;
 world[14][5] = barrier_orientation;
 world[12][6] = barrier_orientation;
 world[13][7] = barrier_orientation;
 world[3][2] = barrier_orientation;
 world[8][3] = barrier_orientation;
 world[4][1] = barrier_orientation;

 world[11][5] = food_orientation;
 world[5][3] = food_orientation;
 world[8][2] = food_orientation;
 world[7][7] = food_orientation;

 world[ghost_x][ghost_y] = ghost_orientation;
 world[pacman_x][pacman_y] = pacman_orientation;

 Print_World();
}

int food_x = 0;
int food_y = 0;
void generate_food() {
 food_x = rand() % 15;
 food_y = rand() % 8;
 if (world[food_x][food_y] == ' ') {
 world[food_x][food_y] = food_orientation;
 printCoordinate(food_x, food_y);
 QTD_FOOD++;
 }
}

char update_pacman_orientation(int newX, int newY) {
 if (newX > pacman_x) {
 return (char) 1;
 } else if (newX < pacman_x) {
 return (char) 3;
 } else if (newY > pacman_y) {
 return (char) 2;
 } else if (newY < pacman_y) {
 return 0;
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
 newPacman_x = pacman_x + 1;
 newPacman_y = pacman_y;
 } else if (direction == 2) {
 newPacman_x = pacman_x;
 newPacman_y = pacman_y + 1;
 } else if (direction == 3) {
 newPacman_x = pacman_x - 1;
 newPacman_y = pacman_y;
 }

 newPacmanOrientation = update_pacman_orientation(newPacman_x, newPacman_y);

 if (newPacman_x < 0) newPacman_x = 14;
 if (newPacman_x > 14) newPacman_x = 0;

 if (newPacman_y < 0) newPacman_y = 7;
 if (newPacman_y > 7) newPacman_y = 0;

 if (world[newPacman_x][newPacman_y] != barrier_orientation) {
 if (world[newPacman_x][newPacman_y] == food_orientation) {
 QTD_FOOD--;
 }
 if (QTD_FOOD == 0) {
 IS_FINISH = 1;
 IS_GAME_OVER = 0;
 }

 pacman_orientation = newPacmanOrientation;

 world[pacman_x][pacman_y] = ' ';
 printCoordinate(pacman_x, pacman_y);

 world[newPacman_x][newPacman_y] = pacman_orientation;
 printCoordinate(newPacman_x, newPacman_y);

 pacman_x = newPacman_x;
 pacman_y = newPacman_y;
 }
}

int meta = 0;
char command = (char) 0;
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

void Start_Screen_1() {
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
 Sound_Play(DO1, 100);
}

void main() {
 UART1_Init(19200);
 I2C1_Init(100000);
 ADCON1 = 0B00001110;
 TRISB = 0B00001111;
 TRISA = 0B00100001;

 TRISA3_bit = 1;
 TRISA4_bit = 1;

 Sound_Init(&PORTC, 5);
 Start_Screen_1();


 T6963C_init(240, 128, 8);
#line 449 "C:/Users/jorge/git/PIC/teste/compy.c"
  T6963C_display. F3  = 1; T6963C_writeCommand(T6963C_display) ;
  T6963C_display. F2  = 1; T6963C_writeCommand(T6963C_display) ;

 InitTimer2();


 Create_World();
 isStarted = 1;

 while (1) {
 if (IS_FINISH) {
 break;
 }

 if (pacman_x == ghost_x && pacman_y == ghost_y) {
 IS_FINISH = 1;
 IS_GAME_OVER = 1;
 }

 command = Le_Teclado();
 if (command == '8') {
 update_pacman(0);
 } else if (command == '6') {
 update_pacman(1);
 } else if (command == '2') {
 update_pacman(2);
 } else if (command == '4') {
 update_pacman(3);
 }

 if (move_ghost_bool) {
 move_ghost_bool = 0;
 UART1_Write_Text("X");
 move_ghost();
 }
 if (generate_food_bool) {
 generate_food_bool = 0;
 UART1_Write_Text("Y");
 generate_food();
 }
 if (QTD_FOOD < 1) {
 IS_FINISH = 1;
 IS_GAME_OVER = 0;
 }
 }
 Finish();

}
