.data
inputString:
    .asciz "Enter string: "

print:
    .asciz "'%s' was %d characters long.\n"

string:
    .skip 128

.text
.global main
main:
    push {lr}

    ldr r0, =inputString
    bl printf
    
    ldr r0, =string
    mov r1, #128
    ldr r2, =stdin
    ldr r2, [r2]
    bl fgets

    ldr r0, =string
    bl strlen
    mov r4, r0 @Store result of strlen in a non volatile register
    sub r4, r4, #1 @Remove one from length to allow getting rid of new line
    
    mov r0, #0x00 @Move null terminator to r0
    ldr r1, =string
    str r0, [r1, r4] @string[r4] = '\0'

    ldr r0, =print
    ldr r1, =string
    mov r2, r4
    bl printf

    mov r0, #0 
    pop {pc}
