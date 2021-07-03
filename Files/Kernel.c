// Kernel written in c to display "Hello, World!" at the top left corner in screen
// For color display with VGA text mode enabled the memory starts at 0xb8000

void main(){
	char* vid_mem = (char*) 0xb8000;
	*vid_mem = "Hello, World!";
}
