PIO EQU 30H

ORG 1000H
        MSJ DB  "CONCEPTOS DE "
        DB  "ARQUITECTURA DE "    
        DB  "COMPUTADORAS"
        FIN DB  ?
ORG 2000H
        MOV AL, 0FDH ;11111101b
        OUT PIO+2, AL  ;Configurar PA: Strobe (0:Salida)
        MOV AL, 0
        OUT PIO+3, AL  ;Configurar PB: Todo de salida
        IN AL, PIO     
        AND AL, 0FDH   
        OUT PIO, AL    ;Forzamos el Strobe a 0 sin tocar los demas bits
        MOV BX, OFFSET MSJ
        MOV CL, OFFSET FIN-OFFSET MSJ
POLL:   IN  AL, PIO
        AND AL, 1      ;Revisamos el estado del Busy
        JNZ POLL       ;Seguimos consultando hasta que este libre
        MOV AL, [BX]
        OUT PIO+1, AL  ;Cargamos el caracter en PB
        IN  AL, PIO
        OR  AL, 02H    ;Establecemos el Strobe en 1 para avisar a la impresora
        OUT PIO, AL
        IN  AL, PIO
        AND AL, 0FDH   ;Volvemos a forzar el Strobe a 0
        OUT PIO, AL
        INC BX
        DEC CL
        JNZ POLL
        INT 0
        END