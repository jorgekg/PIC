#line 1 "C:/Users/jorge/git/PIC/analogico_temperatura/analogico.c"

int analogicDigital;
char text[7];
unsigned short temp;

void pulaLinha(void) {
 UART1_Write(13);
 UART1_Write(10);
}

void main() {
 UART1_Init(19200);
 TRISB = 0B11110000;
 ADCON1 = 0B00001111;
 PORTB = 0B00000000;
 while(1) {
 analogicDigital = ADC_Read(0);
 temp = ((float) analogicDigital * 5.0 / 1024.0) * 100.0;
 if (temp <= 24.0) {
 PORTB = 0B00001000;
 }
 if (temp > 24.0 && temp <= 33.0) {
 PORTB = 0B00001100;
 }
 if (temp > 33.0 && temp <= 43.0) {
 PORTB = 0B00001110;
 }
 if (temp > 43.0 && temp <= 89.0) {
 PORTB = 0B00001111;
 }
 IntToStr(temp, text);
 UART1_Write_Text(text);
 pulaLinha();
 }
}
