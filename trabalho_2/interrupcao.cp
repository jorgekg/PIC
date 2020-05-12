#line 1 "C:/git/pic-jorge/trabalho_2/interrupcao.c"

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
char TXT2[7];
unsigned short Temperatura;

int hhh, mmm, sss;
int critic_hhh, critic_mmm;

char ENTER[2] = {13,0};

char ENTRADA[33];

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
 int0if_bit=0;

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
 TMR2IF_bit = 0;
 }
}

void InitTimer2(){
 T2CON = 0x3C;
 TMR2IE_bit = 1;
 PR2 = 249;
 INTCON = 0xD0;
}

short Le_Teclado()
{
 PORTD = 0B00010000;
 if (PORTA.RA5 == 1) {while(PORTA.RA5==1); return '7';};
 if (PORTB.RB1 == 1) {while(PORTB.RB1==1); return '8';};
 if (PORTB.RB2 == 1) {while(PORTB.RB2==1); return '9';};
 if (PORTB.RB3 == 1) {while(PORTB.RB3==1); return '%';};

 PORTD = 0B00100000;
 if (PORTA.RA5 == 1) {while(PORTA.RA5==1);return '4';};
 if (PORTB.RB1 == 1) {while(PORTB.RB1==1);return '5';};
 if (PORTB.RB2 == 1) {while(PORTB.RB2==1);return '6';};
 if (PORTB.RB3 == 1) {while(PORTB.RB3==1);return '*';};

 PORTD = 0B01000000;
 if (PORTA.RA5 == 1) {while(PORTA.RA5==1);return '1';};
 if (PORTB.RB1 == 1) {while(PORTB.RB1==1);return '2';};
 if (PORTB.RB2 == 1) {while(PORTB.RB2==1);return '3';};
 if (PORTB.RB3 == 1) {while(PORTB.RB3==1);return '-';};

 PORTD = 0B10000000;
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

void Move_Delay() {
 Delay_ms(100);
}

const int WORLD_WIDTH = 20;
const int WORLD_HEIGHT = 4;
const int GHOST_COUNT = 0;
const int PACMAN = 0;

int i = 0;
int j = 0;
char world[WORLD_HEIGHT][WORLD_WIDTH];
int objects_location_x[GHOST_COUNT + 1];
int objects_location_y[GHOST_COUNT + 1];

char pacman_orientation = 0;


const char character_0[] = {31,30,28,24,24,28,30,31};

const char character_1[] = {31,15,7,3,3,7,15,31};

const char character_2[] = {31,31,31,27,17,0,0,0};

const char character_3[] = {0,0,0,17,27,31,31,31};

void CustomChar() {
 char i;
 LCD_Cmd(64);
 for (i = 0; i<=7; i++) LCD_Chr_Cp(character_0[i]);
 for (i = 0; i<=7; i++) LCD_Chr_Cp(character_1[i]);
 for (i = 0; i<=7; i++) LCD_Chr_Cp(character_2[i]);
 for (i = 0; i<=7; i++) LCD_Chr_Cp(character_3[i]);
 LCD_Cmd(_LCD_RETURN_HOME);
}

void Create_World() {
 objects_location_x[PACMAN] = 0;
 objects_location_y[PACMAN] = 0;

 for(i = 0; i < WORLD_WIDTH; ++i) {
 for(j = 0; j < WORLD_HEIGHT ; ++j)
 {
 world[i][j] = '-';
 }
 }
 world[objects_location_x[PACMAN]][objects_location_y[PACMAN]] = pacman_orientation;
}

void Print_World() {
 for(i = 0; i < WORLD_WIDTH; ++i) {
 for(j = 0; j < WORLD_HEIGHT ; ++j)
 {
 inttostr(j, TXT2);
 UART1_Write_Text(TXT2);
 UART1_Write(' ');
 inttostr(i, TXT2);
 UART1_Write_Text(TXT2);
 UART1_Write(' ');
 inttostr(world[i][j], TXT2);
 UART1_Write_Text(TXT2);
 UART1_Write(13);
 UART1_Write(10);

 Lcd_Chr(j + 1, i + 1, world[i][j]);
 }
 }
}

void update_pacman_orientation(short newX, short newY) {
 if (newX > objects_location_x[PACMAN]) {
 pacman_orientation = 0;
 } else if (newX < objects_location_x[PACMAN]) {
 pacman_orientation = 1;
 } else if (newY > objects_location_y[PACMAN]) {
 pacman_orientation = 2;
 } else if (newY < objects_location_y[PACMAN]) {
 pacman_orientation = 3;
 }
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

void main()
 {
 UART1_Init(19200);
 I2C1_Init(100000);

 ADCON1=0B00001110;
 TRISB = 0B00001111;
 PORTB = 0B00000000;
 Lcd_Init();

 TRISA=0B00100001;
 InitTimer2();

 Lcd_Cmd(_LCD_CURSOR_OFF);
 CustomChar();

 Create_World();
 Print_World();
#line 338 "C:/git/pic-jorge/trabalho_2/interrupcao.c"
}
