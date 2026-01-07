# easy_calulator_ARM64_Assembly
Cooking easy calculator on ARM64 Assembly language

clang -arch arm64 -nostartfiles easy_calculator.s -Wl,-e,_start -o calc
./calc
