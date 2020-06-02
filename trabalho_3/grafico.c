#include        "__T6963C.h"

// T6963C module connections
char T6963C_dataPort at PORTD;                   // DATA port

sbit T6963C_ctrlwr  at RC2_bit;                  // WR write signal
sbit T6963C_ctrlrd  at RC1_bit;                  // RD read signal
sbit T6963C_ctrlcd  at RC0_bit;                  // CD command/data signal
sbit T6963C_ctrlrst at RC5_bit;                  // RST reset signal
sbit T6963C_ctrlwr_Direction  at TRISC2_bit;     // WR write signal
sbit T6963C_ctrlrd_Direction  at TRISC1_bit;     // RD read signal
sbit T6963C_ctrlcd_Direction  at TRISC0_bit;     // CD command/data signal
sbit T6963C_ctrlrst_Direction at TRISC5_bit;     // RST reset signal

/*
 * bitmap pictures stored in ROM
 */
const code char mC[];
const code char einstein[];
// ------------------------------------------------------
// GLCD Picture name: IMG_0046.bmp
// GLCD Model: Toshiba T6963C 240x128
// ------------------------------------------------------
int Opcao;

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
   T6963C_graphics(1);
   T6963C_text(0);
   T6963C_sprite((column - 1) * 16, (line - 1) * 16, sprite, 16, 16);
}

void print_text(unsigned char line, unsigned char column, unsigned char* text) {
   T6963C_graphics(0);
   T6963C_text(1);
   T6963C_write_text(text, line - 1, column - 1, T6963C_ROM_MODE_XOR);
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

char command = 255;
void main() {
  unsigned char  panel;         // Current panel
  unsigned int   i;             // General purpose register

  ADCON1 = 0B00001110;
  TRISB = 0B00001111;
  TRISA = 0B00100001;;

  TRISA3_bit = 1;               // Set RA3 as input
  TRISA4_bit = 1;               // Set RA4 as input

  // Initialize T6369C
  // 15 x 8
  T6963C_init(240, 128, 8);

  /*
   * Enable both graphics and text display at the same time
   */
  T6963C_graphics(1);
  T6963C_text(1);
  
  print_text(1, 1, "teste");
  Delay_ms(2000);
  print(1, 1, pacman_up);
  print(1, 2, pacman_down);
  print(1, 3, pacman_left);
  print(1, 4, pacman_right);
  print(1, 5, obstacle);
  print(1, 6, food);
  print(1, 7, ghost);

  while(1) {
      command = Le_Teclado();
      if (command != 255) {
            print_text(1, 1, "Tecla apertada!");
      }
  }

}