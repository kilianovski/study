## Decompile `fib.c` for Mac M1

!WIP:

1. Compile and run fib: 
```bash
gcc -o fib fib.c
./fib
```

2. Decompile and save the assembly code of the resulted program to `fib.dec.s`:
```bash
otool -tV fib > fib.dec.s
```

