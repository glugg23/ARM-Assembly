.cpu cortex-a53 /* Set cpu target to allow use of udiv and mls */

.data
message:
    .asciz "Enter a number: "

formatIn:
    .asciz "%d"

formatOut:
    .asciz "%d\n"

number:
    .word 0

.text
print:
    push {lr}

    ldr r0, =formatOut
    mov r1, r4
    bl printf

    pop {pc}

loop:
    push {lr}

    loopStart:
    ldr r5, =number
    ldr r5, [r5] /* Load number into r5 */
    
    cmp r4, r5
    bgt endLoop

    udiv r1, r5, r4 /* Find quotient of number / i, r1 = r5 / r4 */
    mls r0, r1, r4, r5 /* Find modulo, r0 = r5 - (r4 * r1) */

    cmp r0, #0 /* If this is 0 then i is a factor of number */
    bleq print

    add r4, r4, #1 /* Increment i */
    b loopStart

    endLoop:
    pop {pc}

.global main
main:
    push {lr} /* Push return address on stack */

    ldr r0, =message
    bl printf /* Print opening message*/

    ldr r0, =formatIn /* Set format */
    ldr r1, =number /* Set pointer */
    bl scanf /* Read in an int */

    mov r4, #1 /* Move counter into reserved register */
    bl loop    

    mov r0, #0 /* Return 0 */
    pop  {pc} /* Pop return address onto program counter */
