        PIC EQU 20H
        TIMER EQU 10H
        PIO EQU 30H
        N_CLK EQU 10
ORG 40
        IP_CLK DW  RUT_CLK
ORG 1000H
        TABLA DB 1H, 2H, 4H, 8H, 10H, 20H, 40H, 80H
        FIN_TABLA DB ?

ORG 2000H
        CLI
        MOV AL, 0FDH
        OUT PIC+1, AL   ;Habilito el TIMER
        MOV AL, N_CLK
        OUT PIC+5, AL   ;Cargo INT1
        MOV AL, 1
        OUT TIMER+1, AL ;Seteo el TIMER
        MOV AL, 0
        OUT PIO+3, AL   ;Seteo a PB y CB (salida) en 0
        OUT PIO+1, AL
        OUT TIMER, AL
        MOV CH, 0       ;0=Rot izq. y FF=Rot der.
        MOV BX, OFFSET TABLA
        STI
LAZO:   JMP LAZO

ORG 3000H
RUT_CLK:MOV AL, [BX]
        OUT PIO+1, AL
        MOV AL, 0
        OUT TIMER, AL
        
        CMP CH, 0
        JNZ DER
        INC BX
        CMP BX, OFFSET FIN_TABLA
        JNZ FIN
        SUB BX, 2H
        XOR CH, 0FFH
        JMP FIN
        
DER:    DEC BX
        CMP BX, OFFSET TABLA
        JNS FIN
        ADD BX, 2H
        XOR CH, 0FFH
FIN:    MOV AL, 20H
        OUT PIC, AL
        IRET
        END


