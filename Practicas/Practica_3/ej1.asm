        PA EQU 30H
        PB EQU 31H
        CA EQU 32H
        CB EQU 33H
ORG 2000H
        MOV AL, 0FFH      ;PA entradas (Microconmutadores)
        OUT CA, AL
        MOV AL, 0         ;PB salidas (Luces)
        OUT CB, AL
POLL:   IN AL, PA         ;Lee los bits de los microconmutadores
        OUT PB, AL        ;Enciende las luces correspondientes
        JMP POLL
        END

;Configura PA con todos 1 para que el mismo pueda leer todos los microconmutadores
;Configura PB con todos 0 para que el mismo pueda enviar los datos y encedender las luces