using pigpiod_if2_jll
include("./constants.jl")

mutable struct gpioPulse_t
    gpioOn::UInt32
    gpioOff::UInt32
    usDelay::UInt32
end

#  WAVES
#  wave_clear	                Deletes all waveforms
#  int wave_clear(int pi)
#  This function clears all waveforms and any data added by calls to the wave_add_* functions.
function wave_clear(p::Int32)
    return ccall((:wave_clear, libpigpiod_if2), Int32, (Int32,), p)
end

#  wave_add_new	                Starts a new waveform
#  int wave_add_new(int pi)
#  This function starts a new empty waveform.
#  You wouldn't normally need to call this function as it is automatically called after a waveform is created with the wave_create function.
function wave_add_new(p::Int32)
    return ccall((:wave_add_new, libpigpiod_if2), Int32, (Int32,), p)
end

#  wave_add_generic	        Adds a series of pulses to the waveform
#  int wave_add_generic(int pi, unsigned numPulses, gpioPulse_t *pulses)
#  This function adds a number of pulses to the current waveform.
function wave_add_generic(p::Int32, numPulses::Int, pulses::gpioPulse_t)
    return ccall((:wave_add_generic, libpigpiod_if2), Int32, (Int32, UInt32, Ref{gpioPulse_t}), p, numPulses, pulses)
end

#  wave_add_serial	        Adds serial data to the waveform
#  int wave_add_serial(int pi, unsigned user_gpio, unsigned baud, unsigned data_bits, unsigned stop_bits, unsigned offset, unsigned numBytes, char *str)
#  This function adds a waveform representing serial data to the existing waveform (if any). The serial data starts offset microseconds from the start of the waveform.
function wave_add_serial(p::Int32, gpio::Int, baud::Int, data_bits::Int, stop_bits::Int, offset::Int, numBytes::Int, str::String)
    return ccall((:wave_add_serial, libpigpiod_if2), Int32, (Int32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, Cstring), p, gpio, baud, data_bits, stop_bits, offset, numBytes, str)
end

#  wave_create	                Creates a waveform from added data
#  int wave_create(int pi)
#  This function creates a waveform from the data provided by the prior calls to the wave_add_* functions.
#  Upon success a wave id greater than or equal to 0 is returned, otherwise PI_EMPTY_WAVEFORM, PI_TOO_MANY_CBS, PI_TOO_MANY_OOL, or PI_NO_WAVEFORM_ID.
function wave_create(p::Int32)
    return ccall((:wave_create, libpigpiod_if2), Int32, (Int32,), p)
end

#  wave_create_and_pad	        Creates a waveform of fixed size from added data
#  int wave_create_and_pad(int pi, int percent)
#  This function creates a waveform like wave_create but pads the consumed resources.
#  Where percent gives the percentage of the resources to use (in terms of the theoretical maximum, not the current amount free).
#  This allows the reuse of deleted waves while a transmission is active.
function wave_create_and_pad(p::Int32, percent::Int)
    return ccall((:wave_create_and_pad, libpigpiod_if2), Int32, (Int32, Int32), p, percent)
end

#  wave_delete	                Deletes one or more waveforms
#  int wave_delete(int pi, unsigned wave_id)
#  This function deletes the waveform with id wave_id.
function wave_delete(p::Int32, wave_id::Int32)
    return ccall((:wave_delete, libpigpiod_if2), Int32, (Int32, UInt32), p, wave_id)
end

#  wave_send_once	        Transmits a waveform once
#  int wave_send_once(int pi, unsigned wave_id)
#  This function transmits the waveform with id wave_id. The waveform is sent once.
function wave_send_once(p::Int32, wave_id::Int32)
    return ccall((:wave_send_once, libpigpiod_if2), Int32, (Int32, UInt32), p, wave_id)
end

#  wave_send_repeat	        Transmits a waveform repeatedly
#  int wave_send_repeat(int pi, unsigned wave_id)
#  This function transmits the waveform with id wave_id. The waveform cycles until cancelled (either by the sending of a new waveform or by wave_tx_stop).
function wave_send_repeat(p::Int32, wave_id::Int32)
    return ccall((:wave_send_repeat, libpigpiod_if2), Int32, (Int32, UInt32), p, wave_id)
end

#  wave_send_using_mode	        Transmits a waveform in the chosen mode
#  int wave_send_using_mode(int pi, unsigned wave_id, unsigned mode)
#  Transmits the waveform with id wave_id using mode mode.
function wave_send_using_mode(p::Int32, wave_id::Int32, mode::Int)
    return ccall((:wave_send_using_mode, libpigpiod_if2), Int32, (Int32, UInt32, UInt32), p, wave_id, mode)
end

#  wave_chain	                Transmits a chain of waveforms
#  int wave_chain(int pi, char *buf, unsigned bufSize)
#  This function transmits a chain of waveforms.
function wave_chain(p::Int32, buf::Vector{Int}, bufSize::Int)
    return ccall((:wave_chain, libpigpiod_if2), Int32, (Int32, Ref{UInt8}, UInt32), p, buf, bufSize)
end

#  wave_tx_at	                Returns the current transmitting waveform
#  int wave_tx_at(int pi)
#  This function returns the id of the waveform currently being transmitted by wave_send*. Chained waves are not supported.
function wave_tx_at(p::Int32)
    return ccall((:wave_tx_at, libpigpiod_if2), Int32, (Int32,), p)
end

#  wave_tx_busy	                Checks to see if the waveform has ended
#  int wave_tx_busy(int pi)
#  This function checks to see if a waveform is currently being transmitted.
function wave_tx_busy(p::Int32)
    return ccall((:wave_tx_busy, libpigpiod_if2), Int32, (Int32,), p)
end

#  wave_tx_stop	                Aborts the current waveform
#  int wave_tx_stop(int pi)
#  This function stops the transmission of the current waveform.
function wave_tx_stop(p::Int32)
    return ccall((:wave_tx_stop, libpigpiod_if2), Int32, (Int32,), p)
end

#  wave_get_cbs	                Length in cbs of the current waveform
#  int wave_get_cbs(int pi)
#  This function returns the length in DMA control blocks of the current waveform.
function wave_get_cbs(p::Int32)
    return ccall((:wave_get_cbs, libpigpiod_if2), Int32, (Int32,), p)
end

#  wave_get_high_cbs	        Length of longest waveform so far
#  int wave_get_high_cbs(int pi)
#  This function returns the length in DMA control blocks of the longest waveform created since the pigpio daemon was started.
function wave_get_high_cbs(p::Int32)
    return ccall((:wave_get_high_cbs, libpigpiod_if2), Int32, (Int32,), p)
end

#  wave_get_max_cbs	        Absolute maximum allowed cbs
#  int wave_get_max_cbs(int pi)
#  This function returns the maximum possible size of a waveform in DMA control blocks.
function wave_get_max_cbs(p::Int32)
    return ccall((:wave_get_max_cbs, libpigpiod_if2), Int32, (Int32,), p)
end

#  wave_get_micros	        Length in micros of the current waveform
#  int wave_get_micros(int pi)
#  This function returns the length in microseconds of the current waveform.
function wave_get_micros(p::Int32)
    return ccall((:wave_get_micros, libpigpiod_if2), Int32, (Int32,), p)
end

#  wave_get_high_micros	        Length of longest waveform so far
#  int wave_get_high_micros(int pi)
#  This function returns the length in microseconds of the longest waveform created since the pigpio daemon was started.
function wave_get_high_micros(p::Int32)
    return ccall((:wave_get_high_micros, libpigpiod_if2), Int32, (Int32,), p)
end

#  wave_get_max_micros	        Absolute maximum allowed micros
#  int wave_get_max_micros(int pi)
#  This function returns the maximum possible size of a waveform in microseconds.
function wave_get_max_micros(p::Int32)
    return ccall((:wave_get_max_micros, libpigpiod_if2), Int32, (Int32,), p)
end

#  wave_get_pulses	        Length in pulses of the current waveform
#  int wave_get_pulses(int pi)
#  This function returns the length in pulses of the current waveform.
function wave_get_pulses(p::Int32)
    return ccall((:wave_get_pulses, libpigpiod_if2), Int32, (Int32,), p)
end

#  wave_get_high_pulses	        Length of longest waveform so far
#  int wave_get_high_pulses(int pi)
#  This function returns the length in pulses of the longest waveform created since the pigpio daemon was started.
function wave_get_high_pulses(p::Int32)
    return ccall((:wave_get_high_pulses, libpigpiod_if2), Int32, (Int32,), p)
end

#  wave_get_max_pulses	        Absolute maximum allowed pulses
#  int wave_get_max_pulses(int pi)
#  This function returns the maximum possible size of a waveform in pulses.
function wave_get_max_pulses(p::Int32)
    return ccall((:wave_get_max_pulses, libpigpiod_if2), Int32, (Int32,), p)
end
