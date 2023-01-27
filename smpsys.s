        .section .text.smpsys

        mov.l _entry, r1
        jmp @r1
        nop

        .align 4
_entry: .long _load_addr
