.data
filename:
    .asciz "test.txt"

read:
    .asciz "r"

.text
.global main
main:
    push {lr}

    ldr r0, =filename
    ldr r1, =read
    bl fopen

    bl fclose

    mov r0, #0
    pop {pc}
