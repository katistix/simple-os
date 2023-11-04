; This is a simple "Hello World" bootsector
; Made for the x86_64 architecture

[org 0x7c00] ; This is the address where the BIOS will load our bootloader

; Main program
main:
    mov si, HelloWorld ; Load string into SI
    call PutStr ; Call our procedure to print the string




jmp $ ; Infinite loop
; Everything after this is Procedures and Variables (data)

; Procedures
PutStr: ; Procedure to print a string
    pusha ; Save registers
    mov ah, 0x0e ; BIOS teletype function
    mov al, [si] ; Get character from string
    cmp al, 0 ; Check if character is null
    je .done ; If it is, we're done
    int 0x10 ; Call BIOS, print character
    inc si ; Increment string index
    jmp PutStr ; Repeat
.done:
    popa ; Restore registers
    ret ; Return to caller (main)

; Data
HelloWorld: db 'Hello World!', 0 ; Null terminated string


; Bootsector signature
times 510 - ($-$$) db 0
dw 0xaa55



