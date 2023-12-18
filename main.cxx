#include <iostream>
#include <filesystem>
#include <string>
#include <fstream>

namespace fs = std::filesystem;

int main(int argc, char* argv[]) {
	if ( argc < 2 )
	{
		std::cout << -1;
		return -1;
	}
	
	if ( !fs::exists(argv[1]) )
	{
		std::cout << -1;
		return -1;
	}
	
	std::cout << 0;
	return 0;
}
