; What this program does:
; Prints "Press ENTER key to continue..." and waits for a keypress.
; If the keypress is not the enter, it will loop back to the beginning.
; If the keypress is the enter key, it will print "Goodbye!" and exit. (loop infinitely inside the boot sector)


[org 0x7c00] ; The BIOS loads the boot sector into memory address 0x7c00 and jumps to it.


main:
    mov si, msg ; Load the string to print into SI.
    call print_string ; Call the print_string procedure.

    ; Wait for enter
    call wait_enter ; Call the wait_enter procedure.

    ; Print "Goodbye!" on new line
    call new_line ; Call the new_line procedure.
    mov si, goodbye ; Load the string to print into SI.
    call print_string ; Call the print_string procedure.



jmp $ ; Jump to the current address (loop infinitely).


; Procedures
wait_enter:
    mov ah, 0 ; BIOS keyboard function
    int 0x16 ; Call BIOS, wait for keypress
    cmp al, 0x0d ; Check if keypress is enter
    jne wait_enter ; If it is not, jump to wait_enter.
    ret ; Otherwise, return to the calling procedure.


new_line:
    mov ah, 0x0e ; BIOS teletype function
    mov al, 0x0a ; New line character
    int 0x10 ; Call BIOS, print character
    mov al, 0x0d ; Carriage return character
    int 0x10 ; Call BIOS, print character
    ret ; Return to the calling procedure.

print_string:
    mov ah, 0x0e ; BIOS teletype function
.repeat:
    lodsb ; Load the next byte from SI into AL, and increment SI.
    cmp al, 0 ; Check if the byte is zero (end of string)
    je .done ; If it is, jump to .done.
    int 0x10 ; Otherwise, print the character.
    jmp .repeat ; Loop back to .repeat.
.done:
    ret ; Return to the calling procedure.

; Data
msg: db 'Press ENTER key to continue...', 0 ; The string to print.
goodbye: db 'Goodbye!', 0 ; The string to print.


; Padding and magic number.
times 510 - ($ - $$) db 0
dw 0xaa55