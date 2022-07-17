#include "os.h"

/*
 * Following functions SHOULD be called ONLY ONE time here,
 * so just declared here ONCE and NOT included in file os.h.
 */
extern void uart_init(void);
extern void page_init(void);

void start_kernel(void)
{
	uart_init();
	uart_puts("Hello, RVOS!\n");
	printf("%d\n", printf("hello\n"));
	printf("%d\n", myprintf("hello\n"));
	page_init();

	while (1) {}; // stop here!
}

