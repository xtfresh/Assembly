;@plugin filename=lc3_udiv vector=x80
;;======================================================================
;; CS2110                     Timed Lab #4                Spring 2013
;;======================================================================
;; Filename: nyanSaver.asm
;; Author: Montek Singh
;;======================================================================

;; The program code will start at memory address 0x3000.
.orig   x3000
MAIN    
	LD R6, STACK
	LD R0, POPTARTS

	; Do the things you need to do to pass POPTARTS as an argument on the stack here

	
	JSR NYANSAVER
	; Do the things you need to do to put the return value into R0 here
	
	LDR R0, R6, 0	; Get the return value from the stack
	ADD R6, R6, 3	; Pop the return value and arguments off the stack
	ST R0, ANSWER
	LD R6, STACK
	HALT

;---------------
; Data Section:
;---------------
STACK   .fill   xF000
; Change the below line to test your code.
; We will be testing your code with our own test cases
; Be sure to TEST YOUR CODE COMPLETELY.
POPTARTS	.fill	678
ANSWER  	.fill 0




NYANSAVER
	ADD R6, R6, -1	;stack pointer up
	STR R0, R6, 0	;store poptarts onto stack
	ADD R6, R6, -4	;store init part of stack frame
	STR R7, R6, 2	;store return address
	STR R5, R6, 1	;store ofp
	ADD R5, R6, 0	;r5 = 56

	STR R1, R6, 0	;store whatever is in r1 onto stack
	AND R1, R1, 0	;clear r1
	ADD R1, R1, -10	;r1 = -10
	
	
	ADD R1, R0, R1	;r2 = poptarts - 10
	BRn LESS	;if r2 is negative (poptarts < 10)
	
	AND R1, R1, 0	;clear r1
	ADD R1, R1, 10 	;r1 = 10	
	TRAP x80
	ADD R6, R6, -1
	STR R1, R6, 0
	JSR NYANSAVER
	LDR R0, R6, 0
	LDR R1, R6, 0
	JSR PRINTNUM	
	LDR R2, R5, 2	;load return value of nyansaver(pop/10)
	ADD R2, R2, 1	; rainbows + 1
	STR R2, R6, 4	;rv = rainbows+1
	BR TERMIN
LESS
	JSR PRINTNUM	;jump to print num
	AND R1, R1, 0	;clear r1
	ADD R1, R1, 1	;r1 = 1
	STR R1, R5, 3	;return 1 (store 1 in rv)
	BR TERMIN

TERMIN	LDR R0,R5,0	;restore R0
	LDR R1,R5,-1	;restore R1
	LDR R7,R5,2	;restore RA
	ADD R6,R5,1	;stack pointer points to OLD FP
	LDR R5,R6,0	;R5 = old FP
	
	ADD R6, R6, 2
	RET

	
; NOTE: You may (in fact will have to) use the division trap (UDIV) inside your nyanSaver subroutine.	
;; Postconditions:
;;  R0 <- R0 / R1
;;  R1 <- R0 % R1
	
;;===================================================
;; You should not modify any code beyond this point!!
;;===================================================

;;================================================================
;; PrintNum subroutine
;;================================================================
;; PRINTNUM
;;
;; Preconditions:
;; R0 contains c the character you want to print (0-9)
;;
;; Postconditions:
;; R0 still contains c (its unchanged)
;; The character is printed to the LC3 Console
;; Again no other registers are trashed.
;;================================================================
PRINTNUM
	ADD R6, R6, #-2
	STR R0, R6, #0
	STR R7, R6, #1
	
	ADD R0, R0, #15
	ADD R0, R0, #15
	ADD R0, R0, #15
	ADD R0, R0, #3
	OUT
	
	LDR R0, R6, #0
	LDR R7, R6, #1
	ADD R6, R6, #2
	RET
.end
