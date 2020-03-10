#define True 1

void main() {
     TRISB = 0B11110000;
     ADCON1 = 0B00001111;
     while (True) {
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
