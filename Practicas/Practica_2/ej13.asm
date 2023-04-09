            TIMER EQU 10H
            PIC EQU 20H
            EOI EQU 20H
            N_CLK EQU 10
ORG 40
            IP_CLK DW RUT_CLK
ORG 1000H
            MIN DB 30H
            MIN2 DB 30H
            DP DB 58
            SEG DB 30H
            SEG2 DB 30H
            FIN DB ?
ORG 3000H
RUT_CLK:    PUSH AX
            PUSH CX
            INC SEG2
            CMP SEG2, 3AH
            JNZ RESET
            MOV SEG2, 30H
            MOV CL, 0FH
            INC SEG
            CMP SEG, 36H
            JNZ RESET
            MOV SEG, 30H
            ;Aumentar un min y comparar
            INC MIN2
            CMP MIN2, 3AH
            JNZ RESET
            MOV MIN2, 30H
            INC MIN
            CMP MIN, 36H
            JNZ RESET
            MOV MIN, 30H

RESET:      CMP CL, 0FH
            JNZ NO_PRINT
            INT 7
NO_PRINT:   MOV AL, 0
            OUT TIMER, AL
            MOV AL, EOI
            OUT PIC, AL
            POP CX
            POP AX
            IRET
ORG 2000H
            CLI
            MOV AL, 0FDH
            OUT PIC+1, AL ; PIC: registro IMR
            MOV AL, N_CLK
            OUT PIC+5, AL ; PIC: registro INT1
            MOV AL, 1
            OUT TIMER+1, AL ; TIMER: registro COMP
            MOV AL, 0
            OUT TIMER, AL ; TIMER: registro CONT
            MOV BX, OFFSET MIN
            MOV AL, OFFSET FIN-OFFSET MIN
            STI
LAZO:       JMP LAZO
            END