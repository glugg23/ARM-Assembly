.data
print: .asciz "-i: %s\n-o: %s\n"

.text
.include "commandFlags.s"
.global main
main:
    bl commandFlags

    ldr r0, =print
    ldr r1, =inputFilename
    ldr r1, [r1]
    ldr r2, =outputFilename
    ldr r2, [r2]
    bl printf

    mov r0, #0 @return 0
    mov r7, #1 @exit is syscall 1
    swi #0 @Call it
