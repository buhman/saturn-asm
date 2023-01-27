        .section .text

        /* set TV Mode (see the definition of tvmd_* below) */
        mov.l tvmd,r1
        mov.w tvmd_v,r2
        mov.w r2,@r1

        /* turn off all screens (make BACK visible) */
        mov.l bgon,r1
        mov #0,r2
        mov.w r2,@r1

        /* set the Back Screen color mode to "single color" */
        /* set the high bits of the Back Screen Table Address to zero */
        mov.l bktau,r1
        mov.w bktau_v,r2
        mov.w r2,@r1

        /* set the low bits of Back Screen Table Address */
        /* (relative to the beginning of VDP2 VRAM) */
        mov.l bktal,r1
        mov.w bktal_v,r2
        mov.w r2,@r1

        /* write "red" to VDP2 VRAM */
        mov.l vram,r1
        mov #31,r2 /* red (RGB15) */
        mov.w r2,@r1

forever:
        bra forever
        nop

        .align 4
bgon:           .long (0x20000000 | (0x05E00000 + 0x180020))
tvmd:           .long (0x20000000 | (0x05E00000 + 0x180000))
bktau:          .long (0x20000000 | (0x05E00000 + 0x1800AC))
bktal:          .long (0x20000000 | (0x05E00000 + 0x1800AE))
vram:           .long (0x20000000 | (0x05E00000 + 0x000000))

bktau_v:        .word 0
bktal_v:        .word 0
tvmd_v:         .word (1 << 15 | 1 << 8 | 0b01 << 4 | 0b000 << 0)
