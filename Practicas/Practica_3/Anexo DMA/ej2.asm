        PIC EQU 20H
        HAND EQU 40H
        DMA EQU 50H
        N_DMA EQU 20

ORG 80
        IP_DMA DW RUT_DMA
ORG 1000H
        MSJ DB " INFORMATICA"
        FIN DB  ?
        FLAG DB  0
;rutina atención interrupción del CDMA
ORG 3000H
RUT_DMA:MOV AL, 0
        OUT HAND+1, AL
        MOV FLAG, 1    ;Se indica que se termino la transferencia
        MOV AL, 0FFH
        OUT PIC+1, AL  
        MOV AL, 20H
        OUT PIC, AL    
        IRET

ORG 2000H
        CLI
        MOV AL, N_DMA
        OUT PIC+7, AL        ;reg INT3 de PIC
        MOV AX, OFFSET MSJ
        OUT DMA, AL          ;dir comienzo ...
        MOV AL, AH           ;del bloque ...
        OUT DMA+1, AL        ;a transferir
        MOV AX, OFFSET FIN-OFFSET MSJ
        OUT DMA+2, AL        ;cantidad ..
        MOV AL, AH           ;a ..
        OUT DMA+3, AL        ;transferir
        MOV AL, 4            ;inicialización ..
        OUT DMA+6, AL        ;de control DMA 
        MOV AL, 0F7H
        OUT PIC+1, AL        ;habilita INT3
        OUT DMA+7, AL        ;arranque Transfer
        MOV AL, 80H
        OUT HAND+1, AL       ;interrup de HAND (Bit7 State = 1)
        STI

LAZO:   CMP FLAG, 1
        JNZ LAZO
        INT 0
        END