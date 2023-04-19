
        PIO EQU 30H
        PIC EQU 20H
        EOI EQU 20H
        N_F10 EQU 10

ORG 40
        IP_F10 DW RUT_F10

ORG 1000H
        MSJ DB "Ingrese caracteres a imprimir: "
        FIN_MSJ DB ?

ORG 3000H
RUT_F10:MOV BX, OFFSET MSJ
POLL:   IN AL, PIO
        AND AL, 1
        JNZ POLL           ;Realizo el poll
        MOV AL, [BX]
        OUT PIO+1, AL      ;Cargo a PB con el caracter
        CALL PULSO
        INC BX
        DEC AH
        JNZ POLL
        INT 3
        MOV BX, OFFSET MSJ
        MOV AL, 20H
        OUT EOI, AL
        IRET

ORG 4000H
CONFIG: PUSH AX
        MOV AL, 0FDH
        OUT PIO+2, AL
        MOV AL, 0
        OUT PIO+3, AL
        IN AL, PIO
        AND AL, 0FDH
        OUT PIO, AL
        POP AX
        RET

ORG 5000H
PULSO:  PUSH AX
        IN AL, PIO
        OR AL, 2
        OUT PIO, AL
        IN AL, PIO
        AND AL, 0FDH
        OUT PIO, AL
        POP AX
        RET

ORG 2000H
        CLI
        CALL CONFIG        ;Configurar PIO
        MOV AL, 0FEH       ;Desenmascaro solo INT0
        OUT PIC+1, AL
        MOV AL, N_F10
        OUT PIC+4, AL      ;Cargo a INT0 con el tipo de interrupcion
        MOV BX, OFFSET MSJ
        MOV AL, OFFSET FIN_MSJ- OFFSET MSJ
        INT 7
        MOV AH, 0
        STI
;Confio en que presionen F10 antes de que me sobreescriba toda la memoria :)
LAZO:   INT 6
        CLI
        INC AH
        INC BX
        STI
        JMP LAZO
        INT 0
        END