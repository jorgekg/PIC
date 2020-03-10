#line 1 "C:/Users/jkohn/Desktop/Nova pasta/aula1.c"


void main() {
 TRISB = 0B11110000;
 ADCON1 = 0B00001111;
 while ( 1 ) {
 if (PORTB.F6 == 1 && PORTB.F7 == 1) {
 if (PORTB.F4 == 1) {
 PORTB = 0B11111111;
 continue;
 } else {
 if (PORTB.F5 == 0) {
 PORTB = 0B11111111;
 continue;
 }
 }
 }
 PORTB = 0B0000000;
 }
}
