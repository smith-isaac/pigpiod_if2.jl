# pigpiod_if2.jl
Julia wrapper for [pigpio_if2 C library](https://abyz.me.uk/rpi/pigpio/pdif2.html)

## TODO
---
- [x] Figure out how to reference `pigpiod_if2.so` from pigpio library when calling `using pigpiod_if2`
  - Used [BinaryBuilder](https://docs.binarybuilder.org/stable/) to build [pigpiod_if2_jll](https://github.com/smith-isaac/pigpiod_if2_jll.jl) ([build_tarballs.jl](https://github.com/smith-isaac/Yggdrasil/blob/pigpiod_if2/P/pigpiod_if2/build_tarballs.jl))
  - Add using `]add https://github.com/smith-isaac/pigpiod_if2_jll.jl`
- [ ] Add all global variables (variables defined in `pigpio.h` file using `#define`)
- [ ] Create wrappers for functions from C library
