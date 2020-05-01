#include <stdio.h>
#include <iostream>
extern int yyparse();
//extern int yydebug;
using namespace std;

int main(int argc, char **argv)
{
//yydebug = 1;
  cout << "ha comenzado..." << endl << endl ;
  if (yyparse() == 0) { 
    cout << "ha finalizado BIEN..." << endl << endl ;
  }
  else {
    cout << "ha finalizado MAL..." << endl << endl ;
  }
  return 0;
}
