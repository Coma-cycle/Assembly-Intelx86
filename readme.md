The names of the files are self-explanotory, indicating what one might expect the code to do. 
these assembly programs, in terms of structure and flow, were inspired by the introduction to x86 Microprocessor course I took at IUST University.Although the cource focused on the 8086(16-bit assembly),
here I am working with x86 64-bit assembly.

the src directory contains .asm files(64-bit assembly). 
the build directory contains executed files using the following commands _for linux:

assemble using nasm :
```
nasm -f elf64 src/---.asm -o build/---.o
```
link the object file:
```
ld build/---.o -o /build/---   
```
Run:
```
build/---
```

the registers layout in x86-64 are as follow
![layout](images/registers.png)

[read_key](read_key.asm) assembly code for the algorithm below is here
```
#read key
#   ↓
#is key ESC?
#   ↓ yes → exit
#   ↓ no
#print character
#   ↓
#repeat
```
