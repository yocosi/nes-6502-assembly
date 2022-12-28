;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;ines header (contains a total of 16 bytes with the flags at $7FF0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "HEADER"
.org $7FF0                  ;Location of this segment in the cartdrige
.byte $4E,$45,$53,$1A       ;4 bytes with the characters 'N','E','S','\n'
.byte $02                   ;How many 16kb of PRG-ROM we'll use (32kb in our case)
.byte $01                   ;How many 8kb of CHR-ROM we'll use (8kb in our case)
.byte %00000000             ;Flags 6: Horizontal mirroring, no battery, mapper 0
.byte %00000000             ;Flags 7: mapper 0, playchoice, NES 2.0
.byte $00                   ;Flags 8: No PRG-RAM
.byte $00                   ;Flags 9: NTSC TV Format
.byte $00                   ;Flags 10: No PRG-RAM
.byte $00,$00,$00,$00,$00   ;Unused padding to complete 16 bytes of header

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;PRG-ROM code located at $8000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "CODE"
.org $8000 ;16 bytes after the iNES header because it is 16 bytes long. The iNES header should always be placed BEFORE the bytes of PRG-ROM
;TODO: Add code of PRG-ROM
RESET:
  sei                       ;Disable all IRQ interrupts
  cld                       ;Clear the decimal mode (unsupported by the NES)
  ldx #$FF                  ;Initialize the stack pointer at $01FF
  txs                       ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  lda #0                    ;A = 0
  ldx #$FF                  ;X = $FF
MemLoop:
  sta $0,x                  ;Store the value of A (0) at the address $0+X
  dex                       ;X--
  bne MemLoop               ;Loop until X = 0

NMI:
  rti ;return

IRQ:
  rti ;return


.segment "VECTORS"
.org $FFFA
.word RESET
.word NMI
.word IRQ
