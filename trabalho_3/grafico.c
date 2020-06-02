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

void main() {
  char txt1[] = " EINSTEIN WOULD HAVE LIKED mE";
  char txt[] =  " GLCD LIBRARY DEMO, WELCOME !";

  unsigned char  panel;         // Current panel
  unsigned int   i;             // General purpose register

  ADCON1=0x0E;

  TRISA3_bit = 1;               // Set RA3 as input
  TRISA4_bit = 1;               // Set RA4 as input

  // Initialize T6369C
  T6963C_init(240, 128, 8);

  /*
   * Enable both graphics and text display at the same time
   */
  T6963C_graphics(1);
  T6963C_text(1);
  
  T6963C_sprite(10,10,icone_16_16_pixel,16,16);
  //T6963C_sprite(0,0,portaavioes,16,16);
  
  delay_ms(10000);
  
  T6963C_image(IMG_0046_bmp);
  
  delay_ms(3000);
  
  panel = 0;
  i = 0;
  /*
   * Text messages
   */
  T6963C_write_text(txt, 0, 0, T6963C_ROM_MODE_XOR);
  T6963C_write_text(txt1, 0, 15, T6963C_ROM_MODE_XOR);

  /*
   * Cursor
   */
  T6963C_cursor_height(8);       // 8 pixel height
  T6963C_set_cursor(0, 0);       // Move cursor to top left
  T6963C_cursor(0);              // Cursor off

  /*
   * Draw rectangles
   */
  T6963C_rectangle(0, 0, 239, 127, T6963C_WHITE);
  T6963C_rectangle(20, 20, 219, 107, T6963C_WHITE);
  T6963C_rectangle(40, 40, 199, 87, T6963C_WHITE);
  T6963C_rectangle(60, 60, 179, 67, T6963C_WHITE);

  /*
   * Draw a cross
   */
  T6963C_line(0, 0, 239, 127, T6963C_WHITE);
  T6963C_line(0, 127, 239, 0, T6963C_WHITE);
  /*
   * Draw solid boxes
   */
  T6963C_box(0, 0, 239, 8, T6963C_WHITE);
  T6963C_box(0, 119, 239, 127, T6963C_WHITE);

  /*
   * Draw circles
   */
  T6963C_circle(120, 64, 10, T6963C_WHITE);
  T6963C_circle(120, 64, 30, T6963C_WHITE);
  T6963C_circle(120, 64, 50, T6963C_WHITE);
  T6963C_circle(120, 64, 70, T6963C_WHITE);
  T6963C_circle(120, 64, 90, T6963C_WHITE);
  T6963C_circle(120, 64, 110, T6963C_WHITE);
  T6963C_circle(120, 64, 130, T6963C_WHITE);

  //T6963C_sprite(76, 4, einstein, 88, 119);         // Draw a sprite

  T6963C_setGrPanel(1);                            // Select other graphic panel
  
  for(;;) {                                        // Endless loop

    Opcao = RA3_bit * 2 + RA4_bit;

    if(Opcao==0) {
      T6963C_graphics(1);
      T6963C_text(0);
      Delay_ms(300);
      }
    else if(Opcao==1) {
      panel++;
      panel &= 1;
      T6963C_displayGrPanel(panel);
      Delay_ms(300);
      }
    else if(Opcao==2) {
      T6963C_graphics(0);
      T6963C_text(1);
      Delay_ms(300);
      }
    else if(Opcao==3) {
      T6963C_graphics(1);
      T6963C_text(1);
      Delay_ms(300);
      }
      delay_ms(2000);
  }
}