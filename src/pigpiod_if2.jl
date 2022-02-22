module pigpiod_if2

using Libdl
using pigpiod_if2_jll

include("constants.jl")
export PI_INPUT, PI_OUTPUT
export PI_PUD_UP, PI_PUD_OFF, PI_PUD_DOWN
export HIGH, LOW
export PIGPIO_ERROR

export pigpio_start, pigpio_stop, set_mode, gpio_write, get_mode, set_pull_up_down, gpio_read


# ESSENTIAL
function pigpio_start(addr::String = "", port::String = "")
    return ccall((:pigpio_start, libpigpiod_if2), Int32, (Cstring, Cstring), addr, port)
end

function pigpio_stop(p::Int32)
    return ccall((:pigpio_stop, libpigpiod_if2), Cvoid, (Int32,), p)
end

# BASIC
function set_mode(p::Int32, gpio::Int, mode::PIN_MODES)
    return ccall((:set_mode, libpigpiod_if2), Int32, (Int32, UInt32, UInt32), p, gpio, mode)
end

function get_mode(p::Int32, gpio::Int)
    return ccall((:get_mode, libpigpiod_if2), Int32, (Int32, UInt32), p, gpio)
end

function set_pull_up_down(p::Int32, gpio::Int, pud::PUD_MODES)
    return ccall((:set_pull_up_down, libpigpiod_if2), Int32, (Int32,  UInt32, UInt32), p, gpio, pud)
end

function gpio_read(p::Int32, gpio::Int)
    return ccall((:gpio_read, libpigpiod_if2), Int32, (Int32, UInt32), p, gpio)
end

function gpio_write(p::Int32, gpio::Int, level::PIN_LEVEL)
    return ccall((:gpio_write, libpigpiod_if2), Int32, (Int32, UInt32, UInt32), p, gpio, level)
end

# PWM
# Servo
# INTERMEDIATE
# ADVANCED
# Custom
# Events
# Scripts
# I2C
# I2C BIT BANG
# I2C/SPI SLAVE
# SERIAL
# SERIAL BIT BANG (read only)
# SPI
# SPI BIT BANG
# FILES
# WAVES
# UTILITIES
export time_time, time_sleep, pigpio_error
function time_time()
    return ccall((:time_time, libpigpiod_if2), Cdouble, ())
end

function time_sleep(seconds::Float64)
    return ccall((:time_sleep, libpigpiod_if2), Cvoid, (Cdouble,), seconds)
end

function pigpio_error(errnum::PIGPIO_ERROR)
    error_str = ccall((:pigpio_error, libpigpiod_if2), Cstring, (Int32,), errnum)
    return unsafe_string(error_str)
end

end # module
