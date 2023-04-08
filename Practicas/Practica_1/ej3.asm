ORG 1000H
    INI DB 0
    FIN DB 15
ORG 2000H
    MOV AL, INI
    MOV AH, FIN
    SUMA: INC AL
    CMP AL, AH
    JNZ SUMA
    HLT
END

;3a) El lazo se ejecuta 15 veces. Depende de las etiquetas INI y FIN.
;3b) 
;1) JS: El lazo se ejecuta 15 veces. AL = FH.
;2) JZ: El lazo se ejecuta 1 vez. AL = 1H.
;3) JMP: El lazo se ejecuta infinitamente. AL = indefinido.