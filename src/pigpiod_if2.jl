module pigpiod_if2

using Libdl
using pigpiod_if2_jll

include("constants.jl")
export INPUT, OUTPUT
export PUD_UP, PUD_OFF, PUD_DOWN
export HIGH, LOW

export pigpio_start, pigpio_stop, set_mode, gpio_write, get_mode, set_pull_up_down, gpio_read


# ESSENTIAL
function pigpio_start(addr::String = "", port::String = "")
    return ccall((:pigpio_start, libpigpiod_if2), Int32, (Cstring, Cstring), addr, port)
end

function pigpio_stop(p::Int32)
    return ccall((:pigpio_stop, libpigpiod_if2), Cvoid, (Int32,), p)
end

# BASIC
function set_mode(p::Int32, gpio::Int, mode::Int)
    return ccall((:set_mode, libpigpiod_if2), Int32, (Int32, UInt32, UInt32), p, gpio, mode)
end

function get_mode(p::Int32, gpio::Int)
    return ccall((:get_mode, libpigpiod_if2), Int32, (Int32, UInt32), p, gpio)
end

function set_pull_up_down(p::Int32, gpio::Int, pud::Int)
    return ccall((:set_pull_up_down, libpigpiod_if2), Int32, (Int32,  UInt32, UInt32), p, gpio, pud)
end

function gpio_read(p::Int32, gpio::Int)
    return ccall((:gpio_read, libpigpiod_if2), Int32, (Int32, UInt32), p, gpio)
end

function gpio_write(p::Int32, gpio::Int, level::Int)
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
export gpio_trigger, set_watchdog, read_bank_1, read_bank_2, clear_bank_1, clear_bank_2, set_bank_1, set_bank_2, callback, callback_ex, callback_cancel, wait_for_edge
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

# set_bank_1
function set_bank_1(p::Int32, bits::UInt32)
    return ccall((:set_bank_1, libpigpiod_if2), Int32, (Int32, UInt32), p, bits)
end

# set_bank_2
function set_bank_2(p::Int32, bits::UInt32)
    return ccall((:set_bank_2, libpigpiod_if2), Int32, (Int32, UInt32), p, bits)
end


# clear_bank_2
function clear_bank_2(p::Int32, bits::UInt32)
    return ccall((:clear_bank_2, libpigpiod_if2), Int32, (Int32, UInt32), p, bits)
end

# callback
function callback(p::Int32, gpio::Int, edge::Int, f::Ptr{Nothing})
    return ccall((:callback, libpigpiod_if2), Int32, (Int32, UInt32, UInt32, Ptr{Cvoid}), p, gpio, edge, f)
end

# callback_ex
function callback_ex(p::Int32, gpio::Int, edge::Int, f::Ptr{Nothing}, user_data)
    return ccall((:callback_ex, libpigpiod_if2), Int32, (Int32, UInt32, UInt32, Ptr{Cvoid}, Any), p, gpio, edge, f, user_data)
end

# callback_cancel
function callback_cancel(callback_id::Int32)
    return ccall((:callback_cancel, libpigpiod_if2), Int32, (UInt32,), callback_id)
end

# wait_for_edge
function wait_for_edge(p::Int32, gpio::Int, edge::Int, timeout::Float32)
    return ccall((:wait_for_edge, libpigpiod_if2), Int32, (Int32, UInt32, UInt32, Float32), p, gpio, edge, timeout)
end

# Let's not do threading for now, since it depends on "pthread.h"
# start_thread
# stop_thread

# ADVANCED
# notify_open
function notify_open(p::Int32)
    return ccall((:notify_open, libpigpiod_if2), Int32, (Int32,), p)
end

# notify_begin
function notify_begin(p::Int32, handle::Int32, bits::UInt32)
    return ccall((:notify_begin, libpigpiod_if2), Int32, (Int32, UInt32, UInt32), p, handle, bits)
end

# notify_pause
function notify_pause(p::Int32, handle::Int32)
    return ccall((:notify_pause, libpigpiod_if2), Int32, (Int32, UInt32), p, handle)
end

# notify_close
function notify_close(p::Int32, handle::Int32)
    return ccall((:notify_close, libpigpiod_if2), Int32, (Int32, UInt32), p, handle)
end

# hardware_clock
function hardware_clock(p::Int32, gpio::Int, clkfreq::Int)
    ccall((:hardware_clock, libpigpiod_if2), Int32, (Int32, UInt32, UInt32), p, gpio, clkfreq)
end

# hardware_PWM
function hardware_PWM(p::Int32, gpio::Int, PWMfreq::Int, PWMduty::Int)
    ccall((:hardware_PWM, libpigpiod_if2), Int32, (Int32, UInt32, UInt32, UInt32), p, gpio, PWMfreq, PWMduty)
end

# set_glitch_filter
function set_glitch_filter(p::Int32, gpio::Int, steady::Int)
    return ccall((:set_glitch_filter, libpigpiod_if2), Int32, (Int32, UInt32, UInt32), p, gpio, steady)
end

# set_noise_filter
function set_noise_filter(p::Int32, gpio::Int, steady::Int, active::Int)
    return ccall((:set_noise_filter, libpigpiod_if2), Int32, (Int32, UInt32, UInt32, UInt32), p, gpio, steady, active)
end

# set_pad_strength
function set_pad_strength(p::Int32, pad::Int, padStrength::Int)
    return ccall((:set_pad_strength, libpigpiod_if2), Int32, (Int32, UInt32, UInt32), p, pad, padStrength)
end

# get_pad_strength
function get_pad_strength(p::Int32, pad::Int)
    return ccall((:get_pad_strength, libpigpiod_if2), Int32, (Int32, UInt32), p, pad)
end

# shell_ # Not necessary
# Custom (skipping)
# Events
export event_callback, event_callback_ex, event_callback_cancel, event_trigger, wait_for_event
# event_callback
function event_callback(p::Int32, event::Int, f)
    return ccall((:event_callback, libpigpiod_if2), Int32, (Int32, UInt32, Ptr{Cvoid}), p, event, f)
end

# event_callback_ex
function event_callback_ex(p::Int32, event::Int, f, user_data)
    return ccall((:event_callback_ex, libpigpiod_if2), Int32, (Int32, UInt32, Ptr{Cvoid}, Any), p, event, f, user_data)
end

# event_callback_cancel
function event_callback_cancel(callback_id::Int)
    return ccall((:event_callback_cancel, libpigpiod_if2), Int32, (UInt32,), callback_id)
end

# event_trigger
function event_trigger(p::Int32, event::Int)
    return ccall((:event_trigger, libpigpiod_if2), Int32, (Int32, UInt32), p, event)
end

# wait_for_event
function wait_for_event(p::Int32, event::Int, timeout::Float32)
    return ccall((:wait_for_event, libpigpiod_if2), Int32, (Int32, UInt32, Float32), p, event, timeout)
end

# Scripts
export store_script, run_script, update_script, script_status, stop_script, delete_script
# store_script
# int store_script(int pi, char *script)
function store_script(p::Int32, script::String)
    return ccall((:store_script, libpigpiod_if2), Int32, (Int32, Cstring), p, script)
end

# run_script
# int run_script(int pi, unsigned script id, unsigned numPar, uint32_t *param)
function run_script(p::Int32, script_id::Int32, numPar::Int, param::Array{Int})
    return ccall((:run_script, libpigpiod_if2), Int32, (Int32, UInt32, UInt32, Ptr{Cint}), p, script_id, numPar, param)
end

# update_script
# int update_script(int pi, unsigned script_id, unsigned numPar, uint32_t *param)
function update_script(p::Int32, script_id::Int32, numPar::Int, param::Array{Int})
    return ccall((:update_script, libpigpiod_if2), Int32, (Int32, UInt32, UInt32, Ptr{Cint}), p, script_id, numPar, param)
end

# script_status
# int script_status(int pi, unsigned script_id, uint32_t *param)
function script_status(p::Int32, script_id::Int32, param::Array{Int})
    return ccall((:script_status, libpigpiod_if2), Int32, (Int32, UInt32, Ptr{Cint}), p, script_id, param)
end

# stop_script
# int stop_script(int pi, unsigned script_id)
function stop_script(p::Int32, script_id::Int32)
    return ccall((:stop_script, libpigpiod_if2), Int32, (Int32, UInt32), p, script_id)
end

# delete_script
# int delete_script(int pi, unsigned script_id)
function delete_script(p::Int32, script_id::Int32)
    return ccall((:delete_script, libpigpiod_if2), Int32, (Int32, UInt32), p, script_id)
end

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

function pigpio_error(errnum::Int)
    error_str = ccall((:pigpio_error, libpigpiod_if2), Cstring, (Int32,), errnum)
    return unsafe_string(error_str)
end

end # module
