        HAND EQU 40H
ORG 1000H
        MSJ DB "INGENIERIA E "
        DB "INFORMATICA"
        FIN DB ?
ORG 2000H
        IN AL, HAND+1
        AND AL, 7FH      ;Forzamos el bit 7 de STATE a 0: Para hacer polling
        OUT HAND+1, AL
        MOV BX, OFFSET MSJ
        MOV CL, OFFSET FIN-OFFSET MSJ
POLL:   IN AL, HAND+1    
        AND AL, 1
        JNZ POLL         ;Realizamos una consulta de estado
        MOV AL, [BX]
        OUT HAND, AL     ;Cargamos el caracter en data
        INC BX
        DEC CL
        JNZ POLL
        INT 0
        END