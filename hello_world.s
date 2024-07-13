;---------------------------------------------------------------------------------------------------
;  Copyright (c) Peter Bjorklund. All rights reserved. https://github.com/piot/commander-x16-test
;  Licensed under the MIT License. See LICENSE in the project root for license information.
;---------------------------------------------------------------------------------------------------

;---------------------------------------------------------------------------------------------------
.segment "ZEROPAGE" ; zero page needs to be done early, before any CODE segments.
;---------------------------------------------------------------------------------------------------
save_x: .res 1

.include "startup.inc"

;---------------------------------------------------------------------------------------------------
.segment "CODE"
;---------------------------------------------------------------------------------------------------
; https://www.pagetable.com/c64ref/kernal/#CHROUT
; output a character from register A
CHROUT = $FFD2

start:
  ldx #0

again:
  lda hello_world,x
  cmp #0 ; check if the end of string has been encountered.
  beq done
  stx save_x ; X should not be affected by CHROUT, but if that changes in future firmware,
              ; please use `save_x`
  jsr CHROUT
  ldx save_x
  inx
  jmp again

done:
  rts

;---------------------------------------------------------------------------------------------------
.segment "RODATA"
;---------------------------------------------------------------------------------------------------
hello_world: .asciiz "hello world!"
