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
            SEG DB 30H
            SEG2 DB 30H
            FIN DB ?
ORG 3000H
RUT_CLK:    PUSH AX
            PUSH CX
            CMP CL, 0FH
            JZ NO_INC
            INC SEG2
            CMP SEG2, 3AH
            JNZ RESET
            MOV SEG2, 30H
            INC SEG
            CMP SEG, 33H   ;Comparo con 30 seg
            JNZ RESET
            INT 7
            INT 0

RESET:      INT 7
NO_INC:     MOV AL, 0
            OUT TIMER, AL
            MOV AL, EOI
            OUT PIC, AL
            POP CX
            POP AX
            IRET
ORG 4000H
RUT_F10:    PUSH AX
            XOR CL, 0FH
            MOV AL, EOI
            OUT PIC, AL
            POP AX
            IRET
ORG 2000H
            CLI
            MOV AL, 0FCH
            OUT PIC+1, AL ; PIC: registro IMR
            MOV AL, N_F10
            OUT PIC+4, AL ; PIC: registro INT0
            MOV AL, N_CLK
            OUT PIC+5, AL ; PIC: registro INT1
            MOV AL, 1
            OUT TIMER+1, AL ; TIMER: registro COMP
            MOV AL, 0
            OUT TIMER, AL ; TIMER: registro CONT
            MOV BX, OFFSET SEG
            MOV AL, OFFSET FIN-OFFSET SEG
            MOV CL, 0
            STI
LAZO:       JMP LAZO
            END