# pigpiod_if2.jl
Julia wrapper for [pigpio_if2 C library](https://abyz.me.uk/rpi/pigpio/pdif2.html)

## TODO
---
- [ ] Figure out how to reference `pigpiod_if2.so` from pigpio library when calling `using pigpiod_if2`
- [ ] Add all global variables (variables defined in `pigpio.h` file using `#define`
- [ ] Create wrappers for functions from C library
