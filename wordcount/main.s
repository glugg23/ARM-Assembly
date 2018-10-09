.data
print: .asciz "-i: %s\n-o: %s\n"
read: .asciz "r"
write: .asciz "w"

buffer: .skip 500

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
    ldr r0, [r0]
    mov r1, #0x0
    cmp r0, r1 @Check if a filename was found

    ldr r0, =stdin
    ldr r0, [r0] @Always move something into r0
    
    ldrne r0, =inputFilename
    ldrne r0, [r0]
    ldrne r1, =read
    blne fopen @If there is one open it up

    mov r4, r0 @Move either the file name or stdin into r4
    
    ldr r0, =outputFilename
    ldr r0, [r0]
    mov r1, #0x0
    cmp r0, r1 @Check if there is an output file

    ldr r0, =stdout
    ldr r0, [r0] @Always load something into r0

    ldrne r0, =outputFilename
    ldrne r0, [r0]
    ldrne r1, =write
    blne fopen @Open output file

    mov r5, r0 @Save this value

    ldr r0, =buffer
    mov r1, #500
    mov r2, r4
    bl fgets

    ldr r0, =buffer
    bl puts

    mov r0, r4
    bl fclose @Close input file

    mov r0, r5
    bl fclose @Close output file

    mov r0, #0 @return 0
    mov r7, #1 @exit is syscall 1
    swi #0 @Call it
