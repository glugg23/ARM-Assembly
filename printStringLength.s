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

    

    pop {pc}
