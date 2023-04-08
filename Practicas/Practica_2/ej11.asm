ORG 1000H
            NUM DB 65 ;ASCII DEL 'A'
            EOI EQU 20H
            PIC EQU 20H
            N_F10 EQU 10
            CANT_LETRAS EQU 26

ORG 40   ;Donde se encuentra la posicion del vector de interrupciones 10
            DW RUT_F10

ORG 3000H
RUT_F10:    PUSH AX
            PUSHF
            ADD [BX], DL
            INT 7
            MOV BYTE PTR [BX], 65
            MOV AL, 20H
            OUT EOI, AL
            POPF
            POP AX
            IRET


ORG 2000H
            CLI
            MOV AL, 0FEH
            OUT PIC+1, AL
            MOV AL, N_F10
            OUT PIC+4, AL ;Cargo en INT0 el indice del vector de interrupciones
            MOV DL, 0     ;Para randomizar
            MOV BX, OFFSET NUM
            MOV AL, 1
            STI
LAZO:       CMP DL, CANT_LETRAS-1
            JS SUMO
            MOV DL, 0
SUMO:       INC DL
            JMP LAZO
            HLT
            END