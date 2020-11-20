# Requirement:
nasm<br/>
x86_64 architecture<br/>
Linux
# Compile & Run:
nasm -f elf64 -o math.o math.asm<br/>
ld math.o -o math<br/>
./math
