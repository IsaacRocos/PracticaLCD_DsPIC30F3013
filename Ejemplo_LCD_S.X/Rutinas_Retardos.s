;******************************************************************************
; DESCRIPCIÓN: RUTINAS RETARDOS: 1s, 15ms
; DISPOSITIVO: DSPIC30F3013
;******************************************************************************
        .include "p30F3013.inc"
;******************************************************************************
; DECLARACIONES GLOBALES
;******************************************************************************
        .global _retardo1s
        .global _retardo15ms
;******************************************************************************
;DESCRICION:	ESTA RUTINA GENERA UN RETARDO DE APROX 1S FOSC=7.3728MHZ
;PARAMETROS: 	NINGUNO
;RETORNO: 		NINGUNO
;******************************************************************************
_retardo1s:
    PUSH.D  W0
    MOV     #10, W1

    C2_1S:
    CLR     W0

    C1_1S:
    DEC     W0, W0
    BRA     NZ, C1_1S

    DEC     W1, W1
    BRA     NZ, C2_1S

    POP.D     W0

RETURN
;******************************************************************************
;DESCRICION:	ESTA RUTINA GENERA UN RETARDO DE APROX 15 ms FOSC=7.3728MHZ
;PARAMETROS: 	NINGUNO
;RETORNO: 		NINGUNO
;******************************************************************************
_retardo15ms:
    PUSH.D  W0
    MOV     #4, W1

    C2_15ms:
    CLR.B   W0

    C1_15ms:
    DEC.B   W0, W0
    BRA     NZ, C1_15ms

    DEC     W1, W1
    BRA     NZ, C2_15ms

    POP.D     W0

RETURN
