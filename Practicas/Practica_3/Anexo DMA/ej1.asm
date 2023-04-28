        PIC EQU 20H
        DMA EQU 50H
        N_DMA EQU 20
ORG 80
        IP_DMA DW  RUT_DMA
ORG 1000H
        MSJ DB  "FACULTAD DE"
        DB  " INFORMATICA"
        FIN DB  ?
        NCHAR DB  ?
ORG 1500H
        COPIA DB  ?
;rutina aten interrupción del CDMA
ORG 3000H     
RUT_DMA:MOV AL, 0FFH
        OUT PIC+1, AL  ;Desenmascaro todas las interrupciones
        MOV BX, OFFSET COPIA
        MOV AL, NCHAR
        INT 7         
        MOV AL, 20H
        OUT PIC, AL    
        IRET
ORG 2000H
        CLI
        MOV AL, N_DMA   
        OUT PIC+7, AL    ;Pasar el tipo de interrupcion a INT3 
        MOV AX, OFFSET MSJ
        OUT DMA, AL      ;Cargamos RFL
        MOV AL, AH
        OUT DMA+1, AL    ;Cargamos RFH
        MOV AX, OFFSET FIN-OFFSET MSJ
        OUT DMA+2, AL    ;Cargamos CONT low (reg. contador)
        MOV AL, AH       
        OUT DMA+3, AL    ;Cargamos CONT high (reg. contador)
        MOV AX, OFFSET COPIA ;
        OUT DMA+4, AL    ;Cargamos RDL
        MOV AL, AH       
        OUT DMA+5, AL    ;Cargamos RDH
        MOV AL, 0AH      ;Mem-Mem por bloque
        OUT DMA+6, AL    
        MOV AL, 0F7H     
        OUT PIC+1, AL    ;Desenmascaro INT3
        STI
        MOV BX, OFFSET MSJ
        MOV AL, OFFSET FIN-OFFSET MSJ
        MOV NCHAR, AL    ;Muevo la cant de caracteres
        INT 7          
        MOV AL, 7H
        OUT DMA+7, AL  
        INT 0
        END