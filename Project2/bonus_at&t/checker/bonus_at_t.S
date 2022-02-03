/*
 * Don't forget to include "positions.h"
 */

#include "positions.h"
	
	/* macro pentru scalatul pozitiei, cautarea in vecor
	 * si scaderea elementelor din vector
	 */
	.macro find a, b
		movl \a, %ebx
		movl 16(%ebp), %eax

		mul %ebx
		movl $0, %edx
		movl $10, %ecx
		div %ecx

		movl 20(%ebp), %edi

		movl $4, %ebx
		mul %ebx

		addl %eax, %edi
		subl \b, (%edi)
	.endm

.section .text
.global add_vect

/* 
 * void add_vect(int *v1, int *v2, int n, int *v)
 *
 * add v1 and v2, that have both the length n, and store the result in v3.
 * also, substract from v3 the values provided in positions.S, as described
 * in the task
 */

add_vect:
	pushl 	%ebp
	movl	%esp, %ebp

	pushal

	/* pun argumentele functiei in registri */
	movl $0, %eax
	movl 16(%ebp), %ecx
	movl 8(%ebp), %ebx
	movl 12(%ebp), %edx
	movl 20(%ebp), %edi


/* adun elementele celor 2 vectori */
loop:
	movl $0, %esi

	movl (%ebx), %esi
	movl %esi, (%edi)

	movl (%edx), %esi
	addl %esi, (%edi)

	addl $1, %eax

	addl $4, %ebx
	addl $4, %edx
	addl $4, %edi

	cmp %ecx, %eax
	jle loop

	/* fac schimbarile in vector */
	find $FIRST_POSITION, $FIRST_VALUE
	find $SECOND_POSITION, $SECOND_VALUE
	find $THIRD_POSITION, $THIRD_VALUE

	popal

	leave
	ret
