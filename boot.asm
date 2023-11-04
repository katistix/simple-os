[org 0x7c00] ; BIOS loads the boot sector into 0x7c00
mov ah, 0x0e ; BIOS teletype function

mov bx, variableName ; Move the address of variableName into bx

printString:
    mov al, [bx] ; Move the value of the address in bx into al
    cmp al, 0 ; Compare al to 0
    je exit ; If al is 0, jump to exit (string end)
    int 0x10 ; Print the character in al
    inc bx ; Increment bx
    jmp printString ; Jump to printString, loop function


variableName:
    db "This is my string", 0


exit: ; Infinite loop, exit label, end of program
    jmp $
times 510-($-$$) db 0 ; Fill the rest of the sector with 0s
db 0x55, 0xaa ; Boot signature