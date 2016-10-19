title      Welcome.asm

;Author:   Marc Guise
;Purpose:  This program displays a message to welcome a beginning 8086 Assembly
;              Language programmer.

; Directive - 1 data and 1 code segment
.model small


;Declare named constants
  EXIT_NO_ERRORS equ 4C00h
  LF                     equ 0Ah
  CR			 equ 0Dh

; Directive - Declare a 256 Byte stack 
.stack 100h

; Directive - Declare identifiers here:
.data
       message1 byte "Welcome to 8086 Assembly Language baby!", LF, CR, '$'
       message2 byte 'Have fun with it this semester!!', LF, CR, '$'


; Executable instructions begin here:
.code

; int main()
main proc
    ;Store the beginning address of the data segment in ds
      mov  ax, @data
      mov  ds, ax

    ;Print "Welcome to 8086 Assembly Language!"
      mov  ah, 9h
      mov  dx, offset message1
      int  21h

    ;Print "Have fun with it this semester!!"
      mov dx, offset message2
      int 21h

    ;Terminate program
      mov  ax, EXIT_NO_ERRORS
      int  21h

; Directive - end main procedure
main endp
end main
