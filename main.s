;---------------------------------------------------------------------------------------------------
;  Copyright (c) Peter Bjorklund. All rights reserved. https://github.com/piot/commander-x16-test
;  Licensed under the MIT License. See LICENSE in the project root for license information.
;---------------------------------------------------------------------------------------------------

;---------------------------------------------------------------------------------------------------
.segment "ZEROPAGE" ; zero page needs to be done early, before any CODE segments.
;---------------------------------------------------------------------------------------------------
save_x: .res 1

; default .org is $0801

;---------------------------------------------------------------------------------------------------
.segment "LOADADDR"
;---------------------------------------------------------------------------------------------------
.byte $01, $08 ; The first address to start in Basic? Should always be $0801.
;.addr jump_label_in_your_program ; usually there is a jump to the label where the code starts

;---------------------------------------------------------------------------------------------------
.segment "CODE"
;---------------------------------------------------------------------------------------------------
.byte $00, $08 ; not sure what this is, something for the basic interpreter? first byte does not seem to do anything `$00`, but second needs to be $08.
.byte $0A, $00 ; line number `10` in Basic, can probably be more or less any line number?
.byte $9E ; Token in Basic for the command `SYS`
.byte $24; '$'
.byte $30, $38, $30, $45 ; the address for the sys command: $080E $30="0",$38="8",$30="0",$45="E"
.byte $00  ; End of Line for the basic line number `10`.
.byte $00, $00 ; signature for End of basic program.

.org $080e


; https://www.pagetable.com/c64ref/kernal/#CHROUT
; output a character from register A
CHROUT = $FFD2

start:
  ldx #0

again:
  lda hello_world,x
  cmp #0 ; check if the end of string has been encountered.
  beq done
  ;stx save_x ; X should not be affected by CHROUT
  jsr CHROUT
  ;ldx save_x
  inx
  jmp again

done:
  rts

;---------------------------------------------------------------------------------------------------
.segment "RODATA"
;---------------------------------------------------------------------------------------------------
hello_world: .asciiz "hello world!"
