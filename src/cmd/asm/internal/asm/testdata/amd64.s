// Copyright 2015 The Go Authors.  All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// This input was created by taking the instruction productions in
// the old assembler's (6a's) grammar and hand-writing complete
// instructions for each rule, to guarantee we cover the same space.

TEXT	foo(SB), 7, $0

// LTYPE1 nonrem	{ outcode($1, &$2); }
	NEGQ	R11
	NEGQ	4(R11)
	NEGQ	foo+4(SB)

// LTYPE2 rimnon	{ outcode($1, &$2); }
	INT	$4
	DIVB	R11
	DIVB	4(R11)
	DIVB	foo+4(SB)

// LTYPE3 rimrem	{ outcode($1, &$2); }
	SUBQ $4, DI
	SUBQ R11, DI
	SUBQ 4(R11), DI
	SUBQ foo+4(SB), DI
	SUBQ $4, 8(R12)
	SUBQ R11, 8(R12)
	SUBQ R11, foo+4(SB)

// LTYPE4 remrim	{ outcode($1, &$2); }
	CMPB	CX, $4

// LTYPER nonrel	{ outcode($1, &$2); }
label:
	JB	-4(PC) // JCS -4(PC)
	JB	label // JCS 17

// LTYPEC spec3	{ outcode($1, &$2); }
	JCS	2(PC)
	JMP	-4(PC)
	JCS	2(PC)
	JMP	label // JMP 17
	JCS	2(PC)
	JMP	foo+4(SB)
	JCS	2(PC)
	JMP	bar<>+4(SB)
	JCS	2(PC)
	JMP	bar<>+4(SB)(R11*4)
	JCS	2(PC)
	JMP	*4(SP) // JMP 4(SP)
	JCS	2(PC)
	JMP	*(R12) // JMP (R12)
	JCS	2(PC)
//	JMP	*(R12*4) // TODO: This line is silently dropped on the floor!
	JCS	2(PC)
	JMP	*(R12)(R13*4) // JMP (R12)(R13*4)
	JCS	2(PC)
	JMP	*(AX) // JMP (AX)
	JCS	2(PC)
	JMP	*(SP) // JMP (SP)
	JCS	2(PC)
//	JMP	*(AX*4) // TODO: This line is silently dropped on the floor!
	JCS	2(PC)
	JMP	*(AX)(AX*4) // JMP (AX)(AX*4)
	JCS	2(PC)
	JMP	4(SP)
	JCS	2(PC)
	JMP	(R12)
	JCS	2(PC)
//	JMP	(R12*4) // TODO: This line is silently dropped on the floor!
	JCS	2(PC)
	JMP	(R12)(R13*4)
	JCS	2(PC)
	JMP	(AX)
	JCS	2(PC)
	JMP	(SP)
	JCS	2(PC)
//	JMP	(AX*4) // TODO: This line is silently dropped on the floor!
	JCS	2(PC)
	JMP	(AX)(AX*4)
	JCS	2(PC)
	JMP	R13

// LTYPEN spec4	{ outcode($1, &$2); }
	NOP
	NOP	AX
	NOP	foo+4(SB)

// LTYPES spec5	{ outcode($1, &$2); }
	SHLL	CX, R12
	SHLL	CX, foo+4(SB)
	// Old syntax, still accepted:
	SHLL	CX, R11:AX // SHLL CX, AX, R11

// LTYPEM spec6	{ outcode($1, &$2); }
	MOVL	AX, R11
	MOVL	$4, R11
//	MOVL	AX, 0(AX):DS // no longer works - did it ever?

// LTYPEI spec7	{ outcode($1, &$2); }
	IMULB	DX
	IMULW	DX, BX
	IMULL	R11, R12
	IMULQ	foo+4(SB), R11

// LTYPEXC spec8	{ outcode($1, &$2); }
	CMPPD	X1, X2, 4
	CMPPD	foo+4(SB), X2, 4

// LTYPEX spec9	{ outcode($1, &$2); }
	PINSRW	$4, AX, X2
	PINSRW	$4, foo+4(SB), X2

// LTYPERT spec10	{ outcode($1, &$2); }
	JCS	2(PC)
	RETFL	$4

// Was bug: LOOP is a branch instruction.
	JCS	2(PC)
loop:
	LOOP	loop // LOOP

// LTYPE0 nonnon	{ outcode($1, &$2); }
	RET // c3
