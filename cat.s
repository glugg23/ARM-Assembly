.data
inputMessage:
    .asciz "Enter file name: "

outputMessage:
    .asciz "%s"

filename:
    .skip 128 @char[128]

line:
    .skip 512 @char[512]

read:
    .asciz "r"

.text
.global main
main:
    push {lr}

    ldr r0, =inputMessage
    bl printf

    ldr r0, =filename
    mov r1, #128
    ldr r2, =stdin
    ldr r2, [r2]
    bl fgets

    ldr r0, =filename
    bl strlen
    sub r0, r0, #1 @Remove one to get right index for adding \0

    mov r1, #0x00
    ldr r2, =filename
    str r1, [r2, r0]

    ldr r0, =filename
    ldr r1, =read
    bl fopen @fopen(filename, "r")

    mov r4, r0 @save the pointer to filename

    loop:
    ldr r0, =line
    mov r1, #512
    mov r2, r4
    bl fgets

    @ldr r0, =line
    @It should work with this line but it doesn't
    cmp r0, #0
    beq end

    ldr r0, =line
    bl printf
    b loop 

    end:
    mov r0, r4
    bl fclose

    mov r0, #0
    pop {pc}