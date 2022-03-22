# pigpiod_if2.jl
Julia wrapper for [pigpio_if2 C library](https://abyz.me.uk/rpi/pigpio/pdif2.html)

Intended functionality is to be exactly the same as the C library. Maybe after getting the whole library wrapped I will look at making some improvements.

## Example Usage
```julia
p = pigpio_start() # connecting to pigpiod on localhost
# Named variable p since pi is a constant in julia
led = 4
btn = 17
set_mode(p, led, PI_OUTPUT) # Setting LED gpio to be OUTPUT
set_mode(p, btn, PI_INPUT) # Setting BTN to be INPUT
gpio_write(p, led, HIGH)
btn_state = gpio_read(p, btn)
```

Currently getting segfaults on `callback` and `callback_ex` functions. (Likely to happen on `event_callback` and `event_callback_ex`)

#### Functions not included
- `start_thread`
- `stop_thread`
- `shell_`
- `custom_1`/`custom_2`

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
- [x] Add all global variables (variables defined in `pigpio.h` file using `#define`)
  - Will do this as I write functions to see which global variables are needed
  - May just copy `constants.jl` from the [PiGPIO.jl](https://github.com/JuliaBerry/PiGPIO.jl) library
  - Make the global variables *not* enumerations
- [ ] Figure out how to work with the `pthread.h` library, for threading functions.
- [x] Break out function wrappers into separate files (i.e. `i2c.jl`, `spi.jl`, ...)
- [ ] Figure out why the `callback` function is not working right now (getting segfaults)
- [ ] Test working with the I2C functions, especially `bsc_xfer` and `bsc_i2c` since both of them use the `bsc_xfer_t` struct
- [ ] Test working with file functions since there are arrays of characters which could be `UInt8` or characters
- Create wrappers for functions from C library (organizing by type)
  - [x] Essential
  - [x] Basic
  - [x] PWM
  - [x] Servo
  - [x] Intermediate (except for `start_thread` and `stop_thread`)
  - [x] Advanced
  - [x] Custom (Skipping)
  - [x] Events
  - [x] Scripts
  - [x] I2C (Bit Bang)
  - [x] I2C/SPI Slave
  - [x] Serial (Bit Bang)
  - [x] SPI (Bit Bang)
  - [x] Files
  - [x] Waves
  - [x] Utilities
