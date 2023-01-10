#include <C:\MinGW\lib\gcc\mingw32\6.3.0\include\stddef.h>
#include <stdint.h>
#if defined(__linux__)
	#error "This code must be compiled with a cross-compiler"
#endif
volatile uint16_t* vga_buffer = (uint16_t*)0xB8000;
const int VGA_COLS = 80;
const int VGA_ROWS = 25;
int term_col = 0;
int term_row = 0;
uint8_t term_color = 0x0F;
void term_init()
{
	for (int col = 0; col < VGA_COLS; col ++)
	{
		for (int row = 0; row < VGA_ROWS; row ++)
		{
			const size_t index = (VGA_COLS * row) + col;
			vga_buffer[index] = ((uint16_t)term_color << 8) | ' ';
		}
	}
}
void term_putc(char c)
{
	switch (c)
	{
	case '\n':
		{
			term_col = 0;
			term_row ++;
			break;
		}
 
	default:
		{
			const size_t index = (VGA_COLS * term_row) + term_col;
			vga_buffer[index] = ((uint16_t)term_color << 8) | c;
			term_col ++;
			break;
		}
	}
	if (term_col >= VGA_COLS)
	{
		term_col = 0;
		term_row ++;
	}
	if (term_row >= VGA_ROWS)
	{
		term_col = 0;
		term_row = 0;
	}
}
void term_print(const char* str)
{
	for (size_t i = 0; str[i] != '\0'; i ++)
		term_putc(str[i]);
}
void kernel_main()
{
	term_init();
	term_print("\n");
	term_print(" Welcome to\n");
	term_print(" _     _  ______  _       _       ______     ______________     ______________\n");
	term_print("| |   | ||  ____|| |     | |     |  __  |   /              \\   /              \\\n");
	term_print("| |___| || |____ | |     | |     | |  | |  /    _________   \\ /    ___________/\n");
	term_print("|  ___  ||  ____|| |     | |     | |  | |  |   |         |  | |   |\n");
	term_print("| |   | || |____ | |____ | |____ | |__| |  |   |         |  | |   | \n");       
	term_print("|_|   |_||______||______||______||______|  |   |         |  | |   |___________\n");        
	term_print(" _     _  ______  _____   _       _____    |   |         |  | \\               \\\n");
	term_print("| | _ | ||  __  ||  _  | | |     |  __ \\   |   |         |  |  \\___________   |\n");
	term_print("| |/ \\| || |  | || |_| | | |     | |  | |  |   |         |  |              |  |\n");
	term_print("|       || |  | ||     | | |     | |  | |  |   |_________|  |  ____________|  |\n");
	term_print("|  /\\   || |__| || |\\  \\ | |____ | |  | |  \\                / /               /\n");
	term_print("|_/  \\__||______||_| \\__\\|______||_____/    \\______________/  \\______________/\n");
	term_print("\n                                                    Corporation Version 1.0.0\n");
}
