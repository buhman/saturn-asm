set -eux

#
# begin build sys_ip.bin
#

sh2-none-elf-as \
    -g --isa=sh2 --big \
    sys_id.s -o sys_id.o

sh2-none-elf-objcopy \
    -I coff-sh -O elf32-sh \
    --rename-section .text=.text.sec \
    segasmp/lib/sys_sec.o sys_sec.o

sh2-none-elf-objcopy \
    -I coff-sh -O elf32-sh \
    --rename-section .text=.text.arej \
    segasmp/lib/sys_arej.o sys_arej.o

sh2-none-elf-objcopy \
    -I coff-sh -O elf32-sh \
    --rename-section .text=.text.aret \
    segasmp/lib/sys_aret.o sys_aret.o

sh2-none-elf-objcopy \
    -I coff-sh -O elf32-sh \
    --rename-section .text=.text.aree \
    segasmp/lib/sys_aree.o sys_aree.o

sh2-none-elf-objcopy \
    -I coff-sh -O elf32-sh \
    --rename-section .text=.text.areu \
    segasmp/lib/sys_areu.o sys_areu.o

sh2-none-elf-objcopy \
    -I coff-sh -O elf32-sh \
    --rename-section .text=.text.init \
    segasmp/lib/sys_init.o sys_init.o

sh2-none-elf-as \
    -g --isa=sh2 --big \
    smpsys.s -o smpsys.o

sh2-none-elf-ld \
    --print-memory-usage -T sys_ip.lds \
    sys_id.o \
    sys_sec.o \
    sys_arej.o sys_aret.o sys_aree.o sys_areu.o \
    sys_init.o \
    smpsys.o \
    -o sys_ip.elf

sh2-none-elf-objcopy \
    -O binary \
    sys_ip.elf sys_ip.bin

#
# end build sys_ip.bin
#

#
# begin build main.bin
#

sh2-none-elf-as \
    -g --isa=sh2 --big \
    main.s -o main.o

sh2-none-elf-ld \
    --print-memory-usage -T sh2.lds \
    main.o -o main.elf

sh2-none-elf-objcopy \
    -O binary \
    main.elf main.bin

#
# end build main.bin
#

#
# begin build main.iso
#

mkisofs \
        -sysid "SEGA SEGASATURN" \
        -volid "SAMPLE_GAME_TITLE" \
        -volset "SAMPLE_GAME_TITLE" \
        -publisher "SEGA ENTERPRISES, LTD." \
        -preparer "SEGA ENTERPRISES, LTD." \
        -copyright "smp_cpy.txt" \
        -abstract "smp_abs.txt" \
        -biblio "smp_bib.txt" \
        -sectype data \
        -G sys_ip.bin \
        -o main.iso \
        -graft-points \
        /0main.bin=./main.bin \
        /=./segasmp/smp_cpy.txt \
        /=./segasmp/smp_abs.txt \
        /=./segasmp/smp_bib.txt

#
# end build main.iso
#

echo "FILE \"main.iso\" BINARY" > main.cue
echo "  TRACK 01 MODE1/2048" >> main.cue
echo "    INDEX 01 00:00:00" >> main.cue
