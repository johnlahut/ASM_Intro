
;Author:		John Lahut
;Program name:	Initials.asm
;Date:			3/1/2016
;Purpose:		Programs gets first, middle and last initials (in lower case) from the user and
;				prints their upper case equivalents out in a "Hello " --- ", how are you?" message
;Assumptions:	The user will enter the correct initials in lower case
;Input:			Input is done via the command prompt
;Output:		Output is text shown on the command prompt

; Directive - 1 data and 1 code segment
.model small


;Declare named constants
  EXIT_NO_ERRORS equ 4C00h
  LF             equ 0Ah
  CR			 equ 0Dh
  CASE_CHNG      equ 20h

; Directive - Declare a 256 Byte stack 
.stack 100h

; Directive - Declare identifiers here:
.data


	   askPrompt BYTE "Enter your first, middle, and last initials (in lower case)", LF, CR, '$'	
      
	   ;First, middle, and last initials
	   first BYTE ?
	   middle BYTE ?
	   last BYTE ?

	   ;Prompt templates used for 'UI'
	   helloPrompt BYTE "Hello ", '$'
	   howareyouPrompt BYTE ", how are you?", '$'


; Executable instructions begin here:
.code

; int main()
main proc
	
	;Store the beginning address of the data segment in ds
	mov AX, @data
	mov ds, AX

	;Printing the ask prompt
	mov AH, 9h
	mov DX, offset askPrompt
	int 21h

	; Reading initials
	mov AH, 1h
	int 21h
	mov first, AL
	int 21h
	mov middle, AL
	int 21h
	mov last, AL

	;Changing to uppercase

	;First
	mov AL, first
	sub AL, CASE_CHNG
	mov first, AL

	;Middle
	mov AL, middle
	sub AL, CASE_CHNG
	mov middle, AL

	;Last
	mov AL, last
	sub AL, CASE_CHNG
	mov last, AL

	;Priniting the initals

	;New line
	mov AH, 2H;
	mov DL, LF
	int 21h

	;Print hello
	mov AH, 9H
	mov DX, offset helloPrompt
	int 21h

	;First
	mov AH, 2H
	mov DL, first
	int 21h

	;Middle
	mov DL, middle
	int 21h

	;Last
	mov DL, last
	int 21h;

	;Print how are you
	mov AH, 9H
	mov DX, offset howareyouPrompt
	int 21h

	; Terminate Program
	mov AX, EXIT_NO_ERRORS
	int 21h

; Directive - end main procedure
main endp
end main