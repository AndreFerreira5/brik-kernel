#include "source.h"
#include "keyboard.h"

void main(){
  terminal_buffer = (unsigned short*)VGA_ADDRESS;
  vga_index = 0;
  clear_screen();
  print_string("--------------------------", YELLOW);
  vga_index = 80;
  print_string("WELCOME TO THE BRIK KERNEL", YELLOW);
  vga_index = 160;
  print_string("--------------------------", YELLOW);
  vga_index = 240;

  while(1){
    keyboard_handler();
  }

  return;
}
