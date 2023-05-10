        .data
NUM1:   .word 3
NUM2:   .word 5
RES:    .word 0


        .code
        dadd r3, r0, r0
        ld r1, NUM1(r0)
        ld r2, NUM2(r0)
        dadd r10, r0, r0

        slt r3, r1, r2          ;Comparo cual de los dos es menor y lo utilizo como contador de sumas
        beq r3, r0, sig
        dadd r4, r1, r0         ;Swap si r2 > r1
        dadd r1, r2, r0        
        dadd r2, r4, r0
                                ;Multiplico con r2 como contador y r1 como sumador
        
sig:    daddi r2, r2, -1        ;Decremento cantidad de sumas
mult:   dadd r10, r10, r1
        bnez r2, mult
        daddi r2, r2, -1        ;Decremento cantidad de sumas

fin:    sd r10, RES(r0)
        halt


