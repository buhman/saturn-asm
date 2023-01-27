OUTPUT_FORMAT("elf32-sh", "elf32-sh", "elf32-sh")
OUTPUT_ARCH(sh)

MEMORY
{
  ip : ORIGIN = 0x06002000, LENGTH = 4096
}

SECTIONS
{
  .text :
  {
    KEEP(*(.text.id))
    KEEP(*(.text.sec))

    KEEP(*(.text.arej))
    KEEP(*(.text.aret))
    KEEP(*(.text.aree))
    KEEP(*(.text.areu))
    KEEP(*(.text.init))
    KEEP(*(.text.smpsys))

    . = 4096;
  } > ip
}

_text_size = SIZEOF(.text);
_load_addr = 0x06010000;
