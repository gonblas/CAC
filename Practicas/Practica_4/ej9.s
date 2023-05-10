        .data
X:      .byte 1
Y:      .byte 3
A:      .byte 5

        .code
        lb r3, A(r0)
        lb r1, X(r0)
        lb r2, Y(r0)

        daddi r3, r3, -1
while:  dadd r1, r1, r2
        bnez r3, while
        daddi r3, r3, -1

        sb r1, X(r0)
        halt