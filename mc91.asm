.orig x3000

	LD R6, STACK
	LD R0, VAL
	LD R1, HUND

	ADD R6, R6, -1	;move up stack one
	STR R0, R6, 0	;store r0 onto stack
	JSR MC91	;jump to mc91
	
	LDR R0, R6, 0 
	ST R0, ANS
	HALT

STACK	.fill xF000
HUND 	.fill -100
VAL	.fill 99
ANS	.blkw 1


MC91	ADD R6, R6, -3	;store init part of stack frame
	STR R7, R6, 1	;store return adress
	STR R5, R6, 0	;store old fp onto stack
	ADD R5, R6, -1	;make new sp 	
	ADD R6, R6, -2
	STR R0, R6, 1
	STR R1, R6, 2
	LDR R0, R5, 4	;load value into r0
	ADD R1, R0, R1	;value-100
	BRn RECURSE	;if (val<100) recurse
	BRp GREATER

GREATER
	ADD R1, R0, -10	;n-10
	STR R1, R5, 2	;store n-10 into return value
	BR TERMIN



RECURSE	ADD R1, R0, 11	;add 11 to val
	ADD R6, R6, -1
	STR R1, R6, 0	;store val+11 onto stack
	JSR MC91
	LDR R1, R6, 0	;load return value in r2
	ADD R6, R6, -1	;move stack pointer up
	STR R1, R6, 0
	JSR MC91
	LDR R1, R6, 0
	STR R1, R5, 3
	
TERMIN	LDR R0,R5,0	;restore R0
	LDR R1,R5,-1	;restore R1
	LDR R7,R5,2	;restore RA
	ADD R6,R5,1	;stack pointer points to OLD FP
	LDR R5,R6,0	;R5 = old FP
	ADD R6,R6,2	;R6 points to RV
	RET

.end
