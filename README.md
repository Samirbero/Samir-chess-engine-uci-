Samir-chess-engine-uci-
=======================

chess engine  uci  
#include <iostream>

#include "book.h"
#include "bitboard.h"
#include "evaluate.h"
#include "position.h"
#include "search.h"
#include "thread.h"
#include "tt.h"
#include "ucioption.h"

extern "C" void init() {

	  std::cout << engine_info() << std::endl;

	  UCI::init(Options);
	  Bitboards::init();
	  Position::init();
	  Bitbases::init_kpk();
	  Search::init();
	  Pawns::init();
	  Eval::init();
	  Threads.init();
	  TT.resize(Options["Hash"]);

	  UCI::commandInit();
}

int main(int argc, char* argv[]) {
  init();

  std::string args;

  for (int i = 1; i < argc; ++i)
      args += std::string(argv[i]) + " ";

  if(!args.empty())
	  UCI::command(args);

#ifndef EMSCRIPTEN
  std::string cmd;
  while(std::getline(std::cin, cmd))
	  UCI::command(cmd);
#endif
}

extern "C" void uci_command(const char* cmd) {
	UCI::command(cmd);
}

extern "C" void set_book(unsigned char* pBookData, unsigned int size) {
	PolyglotBook::setBookData(pBookData, size);
	UCI::command("setoption name OwnBook value true");
}

