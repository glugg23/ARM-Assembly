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
    push {r0} /* Push the value from strlen onto the stack */

    ldr r0, =print
    ldr r1, =string
    pop {r2}
    bl printf

    pop {pc}
