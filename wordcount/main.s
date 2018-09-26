.data
print: .asciz "-i: %s\n-o: %s\n"
read: .asciz "r"
write: .asciz "w"

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

    ldr r0, =inputFilename
    mov r1, #0x0
    cmp r0, r1 @Check if a filename was found

    ldreq r4, =stdin
    ldreq r4, [r4] @If no filename was found load stdin

    ldrne r1, =read
    blne fopen @Otherwise call fopen
    movne r1, r4 @And save the FILE*

    mov r0, #0 @return 0
    mov r7, #1 @exit is syscall 1
    swi #0 @Call it
