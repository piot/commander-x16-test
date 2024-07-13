;---------------------------------------------------------------------------------------------------
;  Copyright (c) Peter Bjorklund. All rights reserved. https://github.com/piot/commander-x16-test
;  Licensed under the MIT License. See LICENSE in the project root for license information.
;---------------------------------------------------------------------------------------------------

;---------------------------------------------------------------------------------------------------
.segment "ZEROPAGE" ; zero page needs to be done early, before any CODE segments.
;---------------------------------------------------------------------------------------------------
save_x: .res 1

.include "startup.inc"

.include "vera.inc"

;---------------------------------------------------------------------------------------------------
.segment "CODE"
;---------------------------------------------------------------------------------------------------
stz VERA_CTRL
lda %01110001 ; turn on VGA. And enable layer 0, 1 and sprites. https://github.com/X16Community/x16-docs/blob/master/X16%20Reference%20-%2009%20-%20VERA%20Programmer%27s%20Reference.md#registers
sta VERA_DC_VIDEO
rts
