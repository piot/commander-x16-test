; https://github.com/X16Community/x16-docs/blob/master/X16%20Reference%20-%2009%20-%20VERA%20Programmer%27s%20Reference.md#registers
VERA_ADDR_LOW=$9F20
VERA_ADDR_MID=$9F21
VERA_ADDR_HIGH=$9F22
VERA_DATA_0=$9F23
;VERA_DATA_1=$9F24
VERA_CTRL=$9F25

VERA_DC_VIDEO=$9F29
VERA_DC_HSCALE=$9F2A
VERA_DC_VSCALE=$9F2B

VERA_L0_CONFIG=$9F2D ; Map Height (2bits, 0=32, 1=64, 2=128, 3=256), Map Width (2 bits), T256 (0=16 color, 1=256 color), BitmapMode (0=tile (text), 1=bitmap), color depth (0=1bpp, 1=2bpp, 3=4bpp, 4=8bpp)
VERA_L0_MAPBASE=$9F2E
VERA_L0_TILEBASE=$9F2F

VERA_SCALE_DOUBLE=64