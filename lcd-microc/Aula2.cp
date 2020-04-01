#line 1 "C:/Users/jkohn/Desktop/Nova pasta/PIC/aula2/Aula2.c"


unsigned short caracter;
unsigned short draw = 3;
unsigned short state = 0;
unsigned short led = 0;

unsigned char janelas[1];

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
 while ( 1 ) {
 if (draw == 3) {
 clear();
 state = 3;
 println("Automacao residencial");
 println("O que vc quer atuar? 1 - lampada ou 2 - janela");
 draw = 0;
 }
 if (draw == 1) {
 clear();
 state = 1;
 println("Automacao residencial");
 println("Qual lampada queres acesar? 1, 2, 3, 4");
 draw = 0;
 }
 if (draw == 2) {
 clear();
 state = 2;
 println("Qual estado? 1 ou 0");
 draw = 0;
 }

 if(UART1_Data_Ready()==1) {
 caracter = UART1_read();
 print(caracter);
 if (state == 4) {
 draw = 3;
 }
 if (state == 3) {
 if (caracter == '1') {
 draw = 1;
 } else {
 printL("Janela 1 = ");
 if (PORTB.F7) println("aberto"); else println("fechado");

 printL("Janela 2 = ");
 if (PORTB.F6) println("aberto"); else println("fechado");

 printL("Janela 3 = ");
 if (PORTB.F5) println("aberto"); else println("fechado");

 printL("Janela 4 = ");
 if (PORTB.F4) println("aberto"); else println("fechado");
 println("Toque em qualquer teclar para continuar...");
 state = 4;
 }
 }
 if (state == 1) {
 led = caracter;
 draw = 2;
 }
 if (state == 2) {
 draw = 3;
 if (led == '1') {
 PORTB.F0 = caracter;
 }
 if (led == '2') {
 PORTB.F1 = caracter;
 }
 if (led == '3') {
 PORTB.F2 = caracter;
 }
 if (led == '4') {
 PORTB.F3 = caracter;
 }
 }
 }
 }
}
