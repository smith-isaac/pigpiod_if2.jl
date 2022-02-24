# pigpiod_if2.jl
Julia wrapper for [pigpio_if2 C library](https://abyz.me.uk/rpi/pigpio/pdif2.html)

Intended functionality is to be exactly the same as the C library. Maybe after getting the whole library wrapped I will look at making some improvements.

## Calling functions from pigpiod_if2 C library
---
Uses [pigpiod_if2_jll](https://github.com/JuliaRegistries/General/tree/master/P/pigpiod_if2_jll), can add by using `]add pigpiod_if2_jll`. Shared library is referenced using `libpigpiod_if2` instead of path to `pigpiod_if2.so`. Example:

```julia
clib = Libdl.dlopen(libpigpiod_if2)
start = Libdl.dlsym(clib, :pigpio_start)
ccall(start, Cint, (Cstring, Cstring), C_NULL, C_NULL)
```

Can also be used in tuple mode. Example:

```julia
ccall((:pigpio_start, libpigpiod_if2), Cint, (Cstring, Cstring), Nothing, Nothing)
```

## TODO
---
- [x] Figure out how to reference `pigpiod_if2.so` from pigpio library when calling `using pigpiod_if2`
  - Add using `]add pigpiod_if2_jll`
  - `pigpiod_if2.so` file is referenced by `libpigpiod_if2` variable
- [ ] Add all global variables (variables defined in `pigpio.h` file using `#define`)
  - Will do this as I write functions to see which global variables are needed
  - May just copy `constants.jl` from the [PiGPIO.jl](https://github.com/JuliaBerry/PiGPIO.jl) library
  - Make the global variables *not* enumerations
- [ ] Figure out how to work with the `pthread.h` library, for threading functions.
- [ ] Break out function wrappers into separate files (i.e. `i2c.jl`, `spi.jl`, ...)
- Create wrappers for functions from C library (organizing by type)
  - [x] Essential
  - [x] Basic
  - [x] PWM
  - [x] Servo
  - [x] Intermediate (except for `start_thread` and `stop_thread`)
  - [ ] Advanced
  - [ ] Custom
  - [ ] Events
  - [ ] Scripts
  - [ ] I2C (Bit Bang)
  - [ ] I2C/SPI Slave
  - [ ] Serial (Bit Bang)
  - [ ] SPI (Bit Bang)
  - [ ] Files
  - [ ] Waves
  - [ ] Utilities
