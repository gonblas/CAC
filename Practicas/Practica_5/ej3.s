            .data
base:       .double 5.85
altura:     .double 13.47
resultado:  .double 0.0

            .code
            l.d f1, base(r0)
            l.d f2, altura(r0)
            mul.d f4, f2, f1
            daddi   r1, r0, 2     ;Para dividir por 2
            mtc1 r1, f3           ;Cargo a f3 el valor entero de r1
            cvt.d.l f3, f3        ;Paso a punto flotante
            div.d f4, f4, f3
            s.d f4, resultado(r0)
            halt