.PHONY: clean win unix winbmi
	
BIN=./bin/
TARGET = $(BIN)gull
WIN_TARGET = $(BIN)Samir.exe

BMI_FLAGS := -mbmi -mbmi2 -DHNI

win32:
	i686-w64-mingw32-c++-posix -O3 -g0 -std=c++11 -fno-rtti -static -fno-exceptions -DW32_BUILD -msse3 Samir.cpp -o $(WIN_TARGET)
	@strip $(WIN_TARGET)

win64:
	x86_64-w64-mingw32-c++-posix -O3 -g0 -std=c++11 -fno-rtti -static -fno-exceptions -msse3 Samir.cpp -o $(WIN_TARGET)
	@strip $(WIN_TARGET)
	
win64-prof:	
	x86_64-w64-mingw32-c++-posix -O3 -g0 -std=c++11 -fno-rtti -static -fno-exceptions -msse3 gull.cpp -fprofile-generate -lgcov -o $(WIN_TARGET)
	$(WIN_TARGET) bench
	x86_64-w64-mingw32-c++-posix -O3 -g0 -std=c++11 -fno-rtti -static -fno-exceptions -msse3 Samir.cpp -fprofile-use -lgcov -o $(WIN_TARGET)
	@strip $(WIN_TARGET)
	
unix:
	g++ -O3 -g0 -std=c++11 -DUNIX -fno-rtti -static -fno-exceptions -msse3 Samir.cpp -o $(TARGET)
	
winbmi:
	x86_64-w64-mingw32-c++-posix -O3 -g0 -std=c++11 -fno-rtti -static -fno-exceptions -msse3 $(BMI_FLAGS) Samir.cpp -o $(WIN_TARGET)
	@strip $(WIN_TARGET)

clean:
	@rm -f $(WIN_TARGET) $(TARGET)
