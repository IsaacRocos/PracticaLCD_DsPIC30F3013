;******************************************************************************
; DESCRIPCIÓN: ESTE PROGRAMA CONTIENE LOS BLOQUES DEL ENSAMBLADOR
; DISPOSITIVO: DSPIC30F3013
;******************************************************************************
    .equ __30F3013, 1
    .include "p30F3013.inc"
;******************************************************************************
; BITS DE CONFIGURACIÓN
;******************************************************************************
;..............................................................................
;SE DESACTIVA EL CLOCK SWITCHING Y EL FAIL-SAFE CLOCK MONITOR (FSCM) Y SE
;ACTIVA EL OSCILADOR INTERNO (FAST RC) PARA TRABAJAR
;FSCM: PERMITE AL DISPOSITIVO CONTINUAR OPERANDO AUN CUANDO OCURRA UNA FALLA
;EN EL OSCILADOR. CUANDO OCURRE UNA FALLA EN EL OSCILADOR SE GENERA UNA TRAMPA
;Y SE CAMBIA EL RELOJ AL OSCILADOR FRC
;..............................................................................
    config __FOSC, CSW_FSCM_OFF & FRC
;..............................................................................
;SE DESACTIVA EL WATCHDOG
;..............................................................................
    config __FWDT, WDT_OFF
;..............................................................................
;SE ACTIVA EL POWER ON RESET (POR), BROWN OUT RESET (BOR), POWER UP TIMER (PWRT)
;Y EL MASTER CLEAR (MCLR)
;POR: AL MOMENTO DE ALIMENTAR EL DSPIC OCURRE UN RESET CUANDO EL VOLTAJE DE
;ALIMENTACIÓN ALCANZA UN VOLTAJE DE UMBRAL (VPOR), EL CUAL ES 1.85V
;BOR: ESTE MODULO GENERA UN RESET CUANDO EL VOLTAJE DE ALIMENTACIÓN DECAE
;POR DEBAJO DE UN CIERTO UMBRAL ESTABLECIDO (2.7V)
;PWRT: MANTIENE AL DSPIC EN RESET POR UN CIERTO TIEMPO ESTABLECIDO, ESTO AYUDA
;A ASEGURAR QUE EL VOLTAJE DE ALIMENTACIÓN SE HA ESTABILIZADO (16ms)
;..............................................................................
    config __FBORPOR, PBOR_ON & BORV27 & PWRT_16 & MCLR_EN
;..............................................................................
;SE DESACTIVA EL CÓDIGO DE PROTECCIÓN
;..............................................................................
    config __FGS, CODE_PROT_OFF & GWRP_OFF
;******************************************************************************
; DECLARACIONES GLOBALES
;******************************************************************************
;..............................................................................
;ETIQUETA DE LA PRIMER LINEA DE CÓDIGO
;..............................................................................
    .global __reset
;..............................................................................
;******************************************************************************
;CONSTANTES ALMACENADAS EN EL ESPACIO DE LA MEMORIA DE PROGRAMA
;******************************************************************************
    .section .myconstbuffer, code
    .palign 2

    MENSAJE:
    ;.BYTE   'E','Q','U','I','P','O',' ','-',' ','1','1', 0x00
    .BYTE   'E','S','C','O','M', 0x00
;******************************************************************************
;SECCION DE CODIGO EN LA MEMORIA DE PROGRAMA
;******************************************************************************
.text
    __reset:
        CALL    INI_PERIFERICOS
        MOV     #tblpage(MENSAJE),  W0
        MOV     W0, TBLPAG
        MOV     #tbloffset(MENSAJE), W3  ;INICIO DEL ARREGLO
        MOV     W3, W1                   ;APUNTADOR
        CALL   _iniciarLCD4bits

    MOSTRAR:
        TBLRDL.B    [W1++], W0
        CP0     W0
        BRA     Z, FIN
        RCALL   _disponibleLCD                ;_disponibleLCDBRA     Z, FIN
        RCALL   _datoLCD4bits
        GOTO    MOSTRAR

;    MOSTRAR_TEST:
;        MOV     #0x45, W0;
;        CALL   _disponibleLCD                ;_disponibleLCDBRA     ;Z, FIN
;        CALL   _datoLCD4bits

    FIN:
        NOP
        GOTO    FIN

;******************************************************************************
;DESCRICION:	ESTA RUTINA INICIALIZA LOS PERIFERICO
;PARAMETROS: 	NINGUNO
;RETORNO: 		NINGUNO
;******************************************************************************
INI_PERIFERICOS:
    CLR     PORTB
    NOP
    CLR     LATB
    NOP
    CLR     TRISB
    NOP
    CLR     PORTF
    NOP
    CLR     LATF
    NOP
    CLR     TRISF
    NOP
    SETM    ADPCFG
    NOP
    RETURN

.END
