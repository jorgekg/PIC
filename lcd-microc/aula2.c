#define True 1

void print(char value) {
 UART1_Write(value);
}

void printL(char* value) {
 UART1_Write_Text(value);
}

void println(char* value) {
 UART1_Write_Text(value);
 print(13);
 print(10);
}

void clear() {
  print(12);
}

void main() {
     TRISB = 0B11110000;
     ADCON1 = 0B00001111;
     UART1_Init(19200);
}
