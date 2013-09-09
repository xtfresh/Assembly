.orig x80
	.fill x5000
.end

.orig x5000
	AND R2, R2, #0	
	ADD R1, R1, #0  ;check if r1 is negative
	BRn NEG

POS 	ADD R2,R2,R0
	ADD R1, R1, #-1
	
	BRp POS
	
	RET

NEG	ADD R2,R2,R0
	ADD R1, R1, #1
	
	BRn NEG


	NOT R2, R2
	ADD R2, R2, #1
	
	RET



.end



.orig x3000
	LD R0, A
	LD R1, B
	TRAP x80
	; code
	HALT
A	.FILL -4
B	.FILL -5
.end
