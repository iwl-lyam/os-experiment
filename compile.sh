echo Assembling
i686-elf-as boot.s -o boot.o
echo Compiling
i686-elf-gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
echo Linking
i686-elf-gcc -T linker.ld -o myos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc

echo Confirming
if grub-file --is-x86-multiboot myos.bin; then
  echo multiboot confirmed
else
  echo the file is not multiboot
fi

echo Moving
cp myos.bin isodir/boot/myos.bin
cp grub.cfg isodir/boot/grub/grub.cfg
grub-mkrescue -o myos.iso isodir