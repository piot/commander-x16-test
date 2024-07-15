;---------------------------------------------------------------------------------------------------
;  Copyright (c) Peter Bjorklund. All rights reserved. https://github.com/piot/commander-x16-test
;  Licensed under the MIT License. See LICENSE in the project root for license information.
;---------------------------------------------------------------------------------------------------

.include "startup.inc"

;---------------------------------------------------------------------------------------------------
.segment "ZEROPAGE" ; zero page needs to be done early, before any CODE segments.
;---------------------------------------------------------------------------------------------------
reserved: .res 1
reserved_2: .res 1
zp_ptr: .res 2

;---------------------------------------------------------------------------------------------------
.segment "DATA" ; zero page needs to be done early, before any CODE segments.
;---------------------------------------------------------------------------------------------------


.include "vera.inc"
.include "vera_api.inc"

;---------------------------------------------------------------------------------------------------
.segment "RODATA"
;---------------------------------------------------------------------------------------------------

tiles:
.incbin "sprite.bin"
end_tiles:
TILES_SIZE = end_tiles-tiles


;---------------------------------------------------------------------------------------------------
.segment "CODE"
;---------------------------------------------------------------------------------------------------


VRAM_layer0_map   = $00000
;VRAM_layer1_map   = $00200
VRAM_tiles        = $00800

start:

stz VERA_DC_VIDEO ; disable display

lda #VERA_SCALE_DOUBLE
sta VERA_DC_HSCALE
sta VERA_DC_VSCALE


stz VERA_CTRL

;VERA_PALETTE=$01f00

;lda #<VERA_PALETTE
;sta zp_ptr
;stz VERA_CTRL
;lda #>VERA_PALETTE
;sta zp_ptr+1


; Map Height (2bits, 0=32, 1=64, 2=128, 3=256), Map Width (2 bits), T256 (0=16 color, 1=256 color), BitmapMode (0=tile (text), 1=bitmap), color depth 2 (0=1bpp, 1=2bpp, 2=4bpp, 3=8bpp)
; 256x256 tiles, 256 color, tile mode, depth = 8bpp,
lda #%00001011
sta VERA_L0_CONFIG

lda #(VRAM_layer0_map >> 9)
sta VERA_L0_MAPBASE

lda #(VRAM_tiles >> 9) ; 8x8 tiles
sta VERA_L0_TILEBASE

; Write a tile; tile_address = TILEBASE + TILE_INDEX * TILE_SIZE
; tile_address = 0 + 1 * 2 (index, palette/vflip/hflip/tile_index (9:8))


; copy tile index maps to VRAM
CopyRAMToVRAM sky, VRAM_layer0_map, MAPS_SIZE

; copy tiles to VRAM
CopyRAMToVRAM tiles, VRAM_tiles, TILES_SIZE


lda #%00010011 ; turn on VGA. And enable layer 0, 1 and sprites. https://github.com/X16Community/x16-docs/blob/master/X16%20Reference%20-%2009%20-%20VERA%20Programmer%27s%20Reference.md#registers
sta VERA_DC_VIDEO

rts

