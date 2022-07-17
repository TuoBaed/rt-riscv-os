void start_kernel(void)
{
	// my test case
	volatile int auto_var = 0x1111;
	volatile int *p = &auto_var;
	volatile int stack_var = 0x2222;

	while (1) {}; // stop here!
}

