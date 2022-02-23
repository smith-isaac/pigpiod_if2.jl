# pigpiod_if2.jl
Julia wrapper for [pigpio_if2 C library](https://abyz.me.uk/rpi/pigpio/pdif2.html)

Intended functionality is to be exactly the same as the C library. Maybe after getting the whole library wrapped I will look at making some improvements.

## Calling functions from pigpiod_if2 C library
---
Uses [pigpiod_if2_jll](https://github.com/JuliaRegistries/General/tree/master/P/pigpiod_if2_jll), can add by using `]add pigpiod_if2_jll`. Shared library is referenced using `libpigpiod_if2` instead of path to `pigpiod_if2.so`. Example:

```julia
clib = Libdl.dlopen(libpigpiod_if2)
start = Libdl.dlsym(clib, :pigpio_start)
ccall(start, Cint, (Cstring, Cstring), Nothing, Nothing)
```

Can also be used in tuple mode. Example:

```julia
ccall((:pigpio_start, libpigpiod_if2), Cint, (Cstring, Cstring), Nothing, Nothing)
```

## Callbacks
---
Since the `callback` and `callback_ex` functions require functions to call when the specified event occurs, the user must convert the desired function to a C function (`f::Ptr{Nothing}`) before passing to `callback`/`callback_ex`

#### `callback`
---
In C the `callback` function is defined as
```c
int callback(int pi, unsigned user_gpio, unsigned edge, CBFunc_t f);
```
and `CBFunc_t` is defined as
```c
typedef void (*CBFunc_t)(int pi, unsigned user_gpio, unsigned level, uint32_t tick);
```
Therefore, the function `f` must be defined in Julia as
```julia
function f(p::Int32, user_gpio::Int32, level::UInt32, tick::UInt32)
    # Whatever you want your function to do
    return nothing # Must have this line! Must return type Cvoid
end
```
Then the function must be converted to a c function
```julia
f_c = @cfunction(f, Cvoid, (Int32, UInt32, UInt32))
```
and in turn `f_c` is last argument passed to the `callback` function.

#### `callback_ex`
---

In C the `callback_ex` function is defined as
```c
int callback_ex(int pi, unsigned user_gpio, unsigned edge, CBFuncEx_t f, void *userdata);
```
and `CBFuncEx_t` is defined as
```c
typedef void (*CBFuncEx_t)(int pi, unsigned user_gpio, unsigned level, uint32_t tick, void * userdata);
```
It is common to define the `userdata` as a `struct` in C, and can function in the same way in Julia
```julia
mutable struct Params # Must be mutable, since the callback_ex function may modify it
    # Your params here
end
```
Therefore, the function `f` must be defined in Julia as
```julia
function f(p::Int32, user_gpio::Int32, level::UInt32, tick::UInt32, user_data::Params)
    # Whatever you want your function to do
    return nothing # Must have this line! Must return type Cvoid
end
```
Then the function must be converted to a c function
```julia
f_c = @cfunction(f, Cvoid, (Int32, UInt32, UInt32, Ref{Params}))
```
and in turn `f_c` is last argument passed to the `callback` function. `Ref{Params}` is used here to serve as a pointer to the struct, and hence the data inside will be modifiable. If `Params` is used here, then the struct will not be modified.


## TODO
---
- [x] Figure out how to reference `pigpiod_if2.so` from pigpio library when calling `using pigpiod_if2`
  - Add using `]add pigpiod_if2_jll`
  - `pigpiod_if2.so` file is referenced by `libpigpiod_if2` variable
- [ ] Add all global variables (variables defined in `pigpio.h` file using `#define`)
  - Will do this as I write functions to see which global variables are needed
- [ ] Break out function wrappers into separate files (i.e. `basic.jl`, `intermediate.jl`, ...)
- Create wrappers for functions from C library (organizing by type)
  - [x] Essential
  - [x] Basic
  - [x] PWM
  - [x] Servo
  - [ ] Intermediate
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
