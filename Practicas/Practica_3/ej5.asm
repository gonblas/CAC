        PIO EQU 30H
ORG 1000H
        NUM_CAR EQU 5 
        CAR DB ?

ORG 3000H
INI_IMP:MOV AL, 0FDH
        OUT PIO+2, AL   ;Configurar PA: Strobe (0:Salida) y Busy (1:Entrada)
        MOV AL, 0
        OUT PIO+3, AL   ;Configurar PB como salida
        IN  AL, PIO
        AND AL, 0FDH    
        OUT PIO, AL     ;Fuerza el Strobe en 0
        RET

ORG 4000H
PULSO:  IN  AL, PIO
        OR  AL, 02H     
        OUT PIO, AL    ;Forzamos el Strobe a 1
        IN AL, PIO
        AND AL, 0FDH
        OUT PIO, AL    ;Forzamos el Strobe a 0
        RET

ORG 2000H
        PUSH AX
        CALL INI_IMP
        POP  AX
        MOV BX, OFFSET CAR
        MOV CL, NUM_CAR
LAZO:   INT  6
POLL:   IN AL, PIO
        AND AL, 1
        JNZ POLL      ;Revisamos el estado de la impresora
        MOV AL, [BX]  
        OUT PIO+1, AL ;Cargamos a PB con el caracter leido
        PUSH AX
        CALL PULSO
        POP AX
        DEC CL
        JNZ LAZO
        INT 0

        END