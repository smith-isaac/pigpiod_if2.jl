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
export set_PWM_range, set_PWM_frequency, set_PWM_dutycycle, get_PWM_range, get_PWM_dutycycle, get_PWM_frequency, get_PWM_real_range
# set_PWM_dutycycle
function set_PWM_dutycycle(p::Int32, gpio::Int, dutycycle::Int)
    return ccall((:set_PWM_dutycycle, libpigpiod_if2), Int32, (Int32, UInt32, UInt32), p, gpio, dutycycle)
end

# set_PWM_frequency
function set_PWM_frequency(p::Int32, gpio::Int, frequency::Int)
    return ccall((:set_PWM_frequency, libpigpiod_if2), Int32, (Int32, UInt32, UInt32), p, gpio, frequency)
end

# set_PWM_range
function set_PWM_range(p::Int32, gpio::Int, r::Int)
    return ccall((:set_PWM_range, libpigpiod_if2), Int32, (Int32, UInt32, UInt32), p, gpio, r)
end

# get_PWM_dutycycle
function get_PWM_dutycycle(p::Int32, gpio::Int)
    return ccall((:get_PWM_dutycycle, libpigpiod_if2), Int32, (Int32, UInt32), p, gpio)
end

# get_PWM_frequency
function get_PWM_frequency(p::Int32, gpio::Int)
    return ccall((:get_PWM_frequency, libpigpiod_if2), Int32, (Int32, UInt32), p, gpio)
end

# get_PWM_range
function get_PWM_range(p::Int32, gpio::Int)
    return ccall((:get_PWM_range, libpigpiod_if2), Int32, (Int32, UInt32), p, gpio)
end

# get_PWM_real_range
function get_PWM_real_range(p::Int32, gpio::Int)
    return ccall((:get_PWM_real_range, libpigpiod_if2), Int32, (Int32, UInt32), p, gpio)
end

# Servo
export set_servo_pulsewidth, get_servo_pulsewidth
# set_servo_pulsewidth
function set_servo_pulsewidth(p::Int32, gpio::Int, pulsewidth::Int)
    return ccall((:set_servo_pulsewidth, libpigpiod_if2), Int32, (Int32, UInt32, UInt32), p, gpio, pulsewidth)
end

# get_servo_pulsewidth
function get_servo_pulsewidth(p::Int32, gpio::Int)
    return ccall((:get_servo_pulsewidth, libpigpiod_if2), Int32, (Int32, UInt32), p, gpio)
end

# INTERMEDIATE
# gpio_trigger
function gpio_trigger(p::Int32, gpio::Int, pulseLen::Int, level::Int)
    return ccall((:gpio_trigger, libpigpiod_if2), Int32, (Int32, UInt32, UInt32, UInt32), p, gpio, pulseLen, level)
end

# set_watchdog
function set_watchdog(p::Int32, gpio::Int, timeout::Int)
    return ccall((:set_watchdog, libpigpiod_if2), Int32, (Int32, UInt32, UInt32), p, gpio, timeout)
end

# read_bank_1
function read_bank_1(p::Int32)
    return ccall((:read_bank_1, libpigpiod_if2), UInt32, (Int32,), p)
end

# read_bank_2
function read_bank_2(p::Int32)
    return ccall((:read_bank_2, libpigpiod_if2), UInt32, (Int32,), p)
end

# clear_bank_1
function clear_bank_1(p::Int32, bits::UInt32)
    return ccall((:clear_bank_1, libpigpiod_if2), Int32, (Int32, UInt32), p, bits)
end

# clear_bank_2
function clear_bank_2(p::Int32, bits::UInt32)
    return ccall((:clear_bank_2, libpigpiod_if2), Int32, (Int32, UInt32), p, bits)
end

# callback
function callback(p::Int32, gpio::Int, edge::PI_EDGES, f::Ptr{Nothing})
    return ccall((:callback, libpigpiod_if2), Int32, (Int32, UInt32, UInt32, Ptr{Cvoid}), p, gpio, edge, f)
end

# callback_ex
function callback_ex(p::Int32, gpio::Int, edge::PI_EDGES, f::Ptr{Nothing}, user_data)
    return ccall((:callback_ex, libpigpiod_if2), Int32, (Int32, UInt32, UInt32, Ptr{Cvoid}, Any), p, gpio, edge, f, user_data)
end

# callback_cancel
function callback_cancel(callback_id::Int32)
    return ccall((:callback_cancel, libpigpiod_if2), Int32, (UInt32,), callback_id)
end

# wait_for_edge
function wait_for_edge(p::Int32, gpio::Int, edge::PI_EDGES, timeout::Float32)
    return ccall((:wait_for_edge, libpigpiod_if2), Int32, (Int32, UInt32, UInt32, Float32), p, gpio, edge, timeout)
end

# Let's not do threading for now, since it depends on "pthread.h"
# start_thread
# stop_thread

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
