            .data
peso:       .double 75.55
altura:     .double 1.70
infra:      .double 18.5
normal:     .double 25.0
sobrepeso:  .double 30.0
IMC:        .byte 0

            .code
            l.d f2, altura(r0)
            l.d f1, peso(r0)
            mul.d f2, f2, f2
            daddi r1, r0, 1
            l.d f3, infra(r0)
            l.d f4, normal(r0)
            l.d f5, sobrepeso(r0)
            div.d f1, f1, f2
                                    ;Comparo valores
            c.lt.d f1, f3
            bc1t fin
            daddi r1, r1, 1
            c.lt.d  f1, f4
            bc1t fin
            daddi r1, r1, 1
            c.lt.d  f1, f5
            bc1t fin
            daddi r1, r1, 1
fin:        sd r1, IMC(r0)
            halt