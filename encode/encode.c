#include <stdio.h>
//---------------------------------------------------------------
// funkcja szyfruje tekst zamieniając znaki w łańcuchu będącym parametrem
//
// Parametry:
//    str     - łańcuch wejściowy/wynikowy
//    charset - zbiór znaków do zamiany
//               0 = tylko litery ('A'->'Z',...,'Z'->'A','a'->'z',...'z'->'a')
//               1 = tylko cyfry ('0'->'9',...','9'->'0')
//               2 = litery i cyfry
//    case    - flaga decydująca o zamianie wielkości liter
//               0 = brak zamiany (pozostaje oryginalna wielkość litery)
//               1 = małe litery są zamieniane na wielkie
//               2 = wielkie litery są zamieniane na małe
//
// Wersja minimum : szyfrowanie liter (charset=0) bez zmiany wielkości
// liter (case=0)
//---------------------------------------------------------------

char* encode (char* str, int charset, int cases);

int main(){
    char str[] = "To jest tekst do zaszyfrowania. A to cyferki 0123456789";
    int charset = 2;
    int cases = 2;

    printf("Original string: %s\n", str );
    printf("Charset: %d\n", charset );
    printf("Case   : %d\n", cases );
    printf("Encoded string : %s\n", encode( str, charset, cases ) );
    return 0;
}

