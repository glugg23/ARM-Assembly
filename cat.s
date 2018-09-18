.data
outputMessage:
    .asciz "%s"

line:
    .skip 512 @char[512]

read:
    .asciz "r"

.text
.global main
main:
    push {lr}

    ldr r0, [r1, #4] @argv[1] = filename
    ldr r1, =read
    bl fopen @fopen(filename, "r")

    mov r4, r0 @save the pointer to filename

    loop:
    ldr r0, =line
    mov r1, #512
    mov r2, r4
    bl fgets

    cmp r0, #0 @Check return value of fgets
    beq end

    ldr r0, =line
    bl printf
    b loop 

    end:
    mov r0, r4
    bl fclose

    mov r0, #0
    pop {pc}
