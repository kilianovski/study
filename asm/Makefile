hello_world_m1: hello_world_m1.o
	ld -macos_version_min 11.0.0 -o hello_world_m1.bin hello_world_m1.o -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _start -arch arm64 & ./hello_world_m1.bin

hello_world_m1.o: hello_world_m1.s
	as -o hello_world_m1.o hello_world_m1.s


print_registers: print_registers.o
	ld -macos_version_min 11.0.0 -o print_registers.bin print_registers.o -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _start -arch arm64 & ./print_registers.bin

print_registers.o: print_registers.s
	as -o print_registers.o print_registers.s
