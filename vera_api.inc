
.macro CopyRAMToVRAM ram_addr, vram_addr, num_bytes
.scope
  stz VERA_CTRL
  lda #($10 | ^vram_addr) ; increase by one
  sta VERA_ADDR_HIGH

  lda #>vram_addr
  sta VERA_ADDR_MID

  lda #<vram_addr
  sta VERA_ADDR_LOW
  lda #<ram_addr
  sta zp_ptr
  lda #>ram_addr
  sta zp_ptr+1
  ldx #0
  ldy #0
loop_again:
  lda (zp_ptr),y
  sta VERA_DATA_0
  iny
  cpx #>num_bytes
  beq check_if_done
  cpy #0
  bne loop_again
  inx
  inc zp_ptr+1
  bra loop_again
check_if_done:
  cpy #<num_bytes
  bne loop_again
.endscope
.endmacro

;---------------------------------------------------------------------------------------------------
.segment "ZEROPAGE" ; zero page needs to be done early, before any CODE segments.
;---------------------------------------------------------------------------------------------------
sprite_x: .res 1
sprite_y: .res 1
sprite_z: .res 1
sprite_vflip: .res 1
sprite_hflip: .res 1
sprite_width_scale: .res 1 ; 0=8, 1=16, 2=32, 3=64 pixels
sprite_height_scale: .res 1 ; 0=8, 1=16, 2=32, 3=64 pixels
sprite_palette: .res 1 ; 0-15
sprite_pixel_ptr: .res 2

.macro SPRITE_DEFINITION ram_addr, vram_addr
   .scope
   ldx #0
   lda #>vram_addr
   sta ram_addr,x
   inx

   lda #<vram_addr
   ora #$80 ; 256 color
   sta ram_addr,x
   inx

   lda sprite_x
   sta ram_addr,x
   inx

   lda sprite_x+1
   sta ram_addr,x
   inx

   lda sprite_y
   sta ram_addr,x
   inx

   lda sprite_y+1
   sta ram_addr,x
   inx

   lda sprite_z
   asl
   ora sprite_vflip
   asl
   ora sprite_hflip

   sta ram_addr,x
   inx

   sprite_height_scale

   .endscope

.endmacro
