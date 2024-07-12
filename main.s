;---------------------------------------------------------------------------------------------------
;  Copyright (c) Peter Bjorklund. All rights reserved. https://github.com/piot/commander-x16-test
;  Licensed under the MIT License. See LICENSE in the project root for license information.
;---------------------------------------------------------------------------------------------------

;---------------------------------------------------------------------------------------------------
.segment "ZEROPAGE" ; zero page needs to be done early, before any CODE segments.
;---------------------------------------------------------------------------------------------------
save_x: .res 1

;---------------------------------------------------------------------------------------------------
.segment "LOADADDR" ; where the .PRG file should be placed in memory when loaded
;---------------------------------------------------------------------------------------------------
.byte $01, $08 ; Should always be $0801, since that is the default for basic programs to be loaded
               ; into, so you can do `LOAD"MAIN.PRG",8` without having to specify the extra
               ; parameter `,1` in the end.
;---------------------------------------------------------------------------------------------------
.segment "STARTUP"
; the C64 .PRG basic language startup code
; that is also used by the Commander X16.
; https://bumbershootsoft.wordpress.com/2020/11/16/c64-startup-code-in-detail/
; https://michaelcmartin.github.io/Ophis/book/x72.html
;---------------------------------------------------------------------------------------------------
.byte $0D, $08  ; Points to the next line of basic code. since we only have one line of code,
                ; it points to the end of basic program signature ($00, $00).
.byte $0A, $00 ; line number `10` ($000A) in Basic. It can be any line number, but 10 seems common.
.byte $9E ; Basic byte code for the command `SYS`.
.byte $20, $24; ' $' . signifies that the following characters are a hex number.
.byte $30, $38, $30, $46 ; the address for the SYS command: $080F $30="0",$38="8",$30="0",$46="F"
.byte $00  ; End of Line for the basic line number `10 SYS$080F`.
.byte $00, $00 ; signature for end of basic program.

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
