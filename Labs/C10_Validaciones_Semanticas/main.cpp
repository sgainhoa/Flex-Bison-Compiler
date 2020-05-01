#include <stdio.h>
#include <iostream>
extern int yyparse();
using namespace std;

int main(int argc, char **argv)
{
  cout << "ha comenzado..." << endl << endl ;
  yyparse();
  cout << "ha finalizado..." << endl << endl ;
  return 0;
}
