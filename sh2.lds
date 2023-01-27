OUTPUT_FORMAT("elf32-sh", "elf32-sh", "elf32-sh")
OUTPUT_ARCH(sh)
MEMORY
{
  work_ram_h : ORIGIN = 0x06000000, LENGTH = 1M
}
SECTIONS
{
  . = 0x06010000;

  .text ALIGN(4) : SUBALIGN(4)
  {
    KEEP(*(.text))
  } > work_ram_h
}
