            TIMER EQU 10H
            PIC EQU 20H
            EOI EQU 20H
            N_CLK EQU 11
            N_F10 EQU 10
ORG 40
            IP_F10 DW RUT_F10
ORG 44
            IP_CLK DW RUT_CLK
ORG 1000H
            SEG DB ?
            SEG2 DB ?
            TEXT DB "Ingrese un valor de dos digitos para la cuenta regresiva: "
            FIN DB ?
ORG 3000H
RUT_CLK:    PUSH AX
            DEC SEG2
            CMP SEG2, 30H
            JNS RESET
            CMP SEG, 30H
            JNZ SIGO
            INT 0
SIGO:       MOV SEG2, 39H
            DEC SEG
            JNS RESET

RESET:      INT 7
NO_INC:     MOV AL, 0
            OUT TIMER, AL
            MOV AL, EOI
            OUT PIC, AL
            POP AX
            IRET
ORG 4000H
RUT_F10:    PUSH AX
            CLI
            MOV AL, 0FDH  ;Dejo habilitado solo el TIMER
            OUT PIC+1, AL ; PIC: registro IMR
            MOV AL, N_CLK
            OUT PIC+5, AL ; PIC: registro INT1
            MOV AL, 1
            OUT TIMER+1, AL ; TIMER: registro COMP
            MOV AL, 0
            OUT TIMER, AL ; TIMER: registro CONT
            MOV AL, EOI
            OUT PIC, AL
            POP AX
            STI
            IRET
ORG 2000H
            CLI
            MOV AL, 0FEH
            OUT PIC+1, AL ; PIC: registro IMR
            MOV AL, N_F10
            OUT PIC+4, AL ; PIC: registro INT0
            ;Calcular el tiempo regresivo
            MOV BX, OFFSET TEXT
            MOV AL, OFFSET FIN - OFFSET TEXT
            INT 7
            MOV BX, OFFSET SEG
            INT 6
            INC BX
            INT 6
            DEC BX
            MOV AL, OFFSET TEXT-OFFSET SEG
            STI
LAZO:       JMP LAZO
            END