        PIC EQU 20H
        TIMER EQU 10H
        PIO EQU 30H
        N_CLK EQU 10
ORG 40
        IP_CLK DW  RUT_CLK

ORG 2000H
        CLI
        MOV AL, 0FDH
        OUT PIC+1, AL   ;Habilita el TIMER
        MOV AL, N_CLK
        OUT PIC+5, AL   ;Carga INT1
        MOV AL, 1
        OUT TIMER+1, AL ;Setea el TIMER
        MOV AL, 0
        OUT PIO+3, AL   ;Setea a PB y CB (salida) en 0
        OUT PIO+1, AL
        OUT TIMER, AL
        MOV CL, 1
        MOV CH, 0       ;0=Rot izq. y FF=Rot. der.
        STI
LAZO:   JMP LAZO

ORG 3000H
RUT_CLK:MOV AL, CL
        OUT PIO+1, AL
        MOV AL, 0
        OUT TIMER, AL
        
        CMP CH, 0
        JZ IZQ
        CMP CL, 1H
        JZ CAMBIO
        MOV AH, 7
DER:    ADD CL, CL      
        JNC SIG         
        INC CL          
SIG:    DEC AH          
        JNZ DER 
        JMP FIN
CAMBIO: MOV CL, 2
        MOV CH, 0
        JMP FIN
IZQ:    ADD CL, CL
        CMP CL, 0H
        JNZ FIN
        MOV CH, 0FFH
        MOV CL, 40h

FIN:    MOV AL, 20H
        OUT PIC, AL
        IRET
        END


;Ineficiente