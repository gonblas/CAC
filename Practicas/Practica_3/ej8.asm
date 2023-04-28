        PIC EQU 20H
        HAND EQU 40H
        N_HND EQU 10
ORG 40
        IP_HND DW RUT_HND

ORG 3000H
;No funciona bien para una impresora muy rapida
RUT_HND:PUSH AX
        MOV AL, [BX]
        OUT HAND, AL
        INC BX
        DEC CL
        MOV AL, 20H
        OUT PIC, AL
        POP AX
        IRET

ORG 1000H
        MSJ DB  "UNIVERSIDAD "
        DB  "NACIONAL DE LA PLATA"
        FIN DB  ?

ORG 2000H
        MOV BX, OFFSET MSJ
        MOV CL, OFFSET FIN-OFFSET MSJ
        CLI
        MOV AL, 0FBH    ;Desenmascaramos INT2
        OUT PIC+1, AL
        MOV AL, N_HND   ;Enviamos el ID
        OUT PIC+6, AL
        MOV AL, 80H     ;Forzamos el bit 7 del registro state en 1: para realizar interrupciones
        OUT HAND+1, AL
        STI
LAZO:   CMP CL, 0
        JNZ LAZO
        CLI
        IN AL, HAND+1  ;Forzamos el bit 7 del registro state en 0: para que no pueda interrumpir mas
        AND AL, 7FH
        OUT HAND+1, AL
        STI
        INT 0
        END