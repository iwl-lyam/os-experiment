echo Assembling
i686-elf-as boot.s -o boot.o
echo "Assembled ... Compiling"
i686-elf-gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
#i686-elf-gcc -c descriptor_tables.c -o descriptor_tables.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
echo "Compiled ... Linking"
i686-elf-gcc -T linker.ld -o myos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc

echo "Linked ... Verifying GRUB"
if grub-file --is-x86-multiboot myos.bin; then
    echo "GRUB Verified ... Moving to OS"
    cp myos.bin isodir/boot/myos.bin
    cp grub.cfg isodir/boot/grub/grub.cfg
    grub-mkrescue -o myos.iso isodir

    echo "OS ready to run"
else
  echo "Verification Failure"
fi

