#include "platform.h"

	# size of each hart's stack is 1024 bytes
	.equ	STACK_SIZE, 1024

	.global	_start

	.text
_start:
	# park harts with id != 0
	csrr	t0, mhartid		# read current hart id
	mv	tp, t0			# keep CPU's hartid in its tp for later usage.
	bnez	t0, park		# if we're not on the hart 0
					# we park the hart

	# Set all bytes in the BSS section to zero.
	la	a0, _bss_start		# _bss_start和_bss_end大概来自os.ld，但目前还不知道有啥作用，只是为了将该区域数据都初始化为0？
	la	a1, _bss_end
	bgeu	a0, a1, 2f		# branch to label 2 if a0 >= a1, but what 2f means? 
1:
	sw	zero, (a0)
	addi	a0, a0, 4
	bltu	a0, a1, 1b		# branch to label 1 if a0 < a1, unsigned comaprsion but what 1b means?
2:
	# Setup stacks, the stack grows from bottom to top, so we put the
	# stack pointer to the very end of the stack range.
	slli	t0, t0, 10		# shift left the hart id by 1024
	la	sp, stacks + STACK_SIZE	# set the initial stack pointer
					# to the end of the first stack space
	add	sp, sp, t0		# move the current hart stack pointer
					# to its place in the stack space

	j	start_kernel		# hart 0 jump to c

park:
	wfi
	j	park

stacks:
	.skip	STACK_SIZE * MAXNUM_CPU # allocate space for all the harts stacks

	.end				# End of file
