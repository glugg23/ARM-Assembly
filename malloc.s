.data
print: .asciz "%p: %d\n"

.text
.global main
main:
    mov r0, #4 @Allocate int on heap
    bl malloc
    mov r4, r0

    mov r0, #10
    str r0, [r4]

    ldr r0, =print
    mov r1, r4
    ldr r2, [r4]
    bl printf

    mov r0, r4
    bl free

    mov r0, #0 @return 0
    mov r7, #1 @exit is syscall 1
    swi #0 @Call it
