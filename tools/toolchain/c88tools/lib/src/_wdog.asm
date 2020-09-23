; @(#)_wdog.asm	1.4
;
$LIST "CN"

; Code to handle the watchdog on the cpu.  We don't want
; the watchdog to bother us.  The simplest way to not be bothered by
; the watchdog is to process (and ignore) its interrupt.

        WDCTL   EQU     0FF40H          ; Watchdog timer control register
        WDRST   EQU     04H             ; Watdog reset bit

        DEFSECT ".watchdog_vector",DATA AT 0004H
        SECT    ".watchdog_vector"
        DW      _watchdog               ; Fill the watchdog vector

        DEFSECT ".watchdog",CODE,SHORT
        SECT    ".watchdog"

; We could put this routine in a library.
; Referencing this label is the only way
; to get it linked then.

        GLOBAL  _watchdog
_watchdog:
        PUSH    HL
	PUSH	EP
	LD	EP,#@DPAG(WDCTL)	; set page register
        LD      HL,#WDCTL
        OR      [HL],#WDRST             ; Reset the watchdog timer
	POP	EP
        POP     HL
        RETE

	END
