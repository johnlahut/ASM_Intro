;Author:		John Lahut
;Title:			Course.asm
;Date:			3/1/2016
;Purpose:		Programs gets a six character course designator where the course designator is 
;				entered in uppercase, (the first three characters), and converts them to their 
;				lowercase equivalents in a "###"is a good "---" course." message.
;Assumptions:	The user will enter a valid course identification number in the format AAA-###
;				It is assumed that the user will enter letters that are in uppercase
;Input:			All input is done via the command prompt
;Output:		All output is done via the command prompt



.model small
.stack 100h

;Named constants
EXIT_NO_ERRORS equ 4C00h
LF			   equ 0Ah	
CR             equ 0Dh
CASE_CHNG      equ 20h


.data

	;The following strings are templates for the 'UI'
	enterPrompt BYTE "Enter a 6 character course designator: ", CR, LF, '$'
	goodPrompt BYTE " is a good ", '$'
	coursePrompt BYTE " course.", '$'
	
	
	courseString BYTE 3 dup(?),'$'
	courseID BYTE 3 dup(?),'$'

.code

main proc

	;Move main data segment
	mov AX, @data
	mov DS, AX

	;Print the enter prompt
	mov AH, 9h
	mov DX, offset enterPrompt
	int 21h

	;Reading in the course number
	mov AH, 1h

	;Read in the course letters
	;Add 20h to each incoming letter to bring in to lowercase
	int 21h
	add al, CASE_CHNG
	mov courseString, AL

	int 21h
	add AL, CASE_CHNG
	mov courseString+1, AL

	int 21h
	add AL, CASE_CHNG
	mov courseString+2, AL

	;Read in the course numbers
	int 21h
	mov courseID, AL
	int 21h
	mov courseID+1, AL
	int 21h
	mov courseID+2, AL

	;Line break
	mov AH, 2H
	mov DL, LF
	int 21h

	;Output statement
	mov AH, 9h
	mov DX, offset courseID
	int 21h
	mov DX, offset goodPrompt
	int 21h
	mov DX, offset courseString
	int 21h
	mov DX, offset coursePrompt
	int 21h

	;Real mode exit
	mov AX, EXIT_NO_ERRORS
	int 21h

main endp
end main

