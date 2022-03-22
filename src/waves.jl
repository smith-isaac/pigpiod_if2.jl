using pigpiod_if2_jll
include("./constants.jl")

#  WAVES
#  wave_clear	                Deletes all waveforms
#  wave_add_new	                Starts a new waveform
#  wave_add_generic	        Adds a series of pulses to the waveform
#  wave_add_serial	        Adds serial data to the waveform
#  wave_create	                Creates a waveform from added data
#  wave_create_and_pad	        Creates a waveform of fixed size from added data
#  wave_delete	                Deletes one or more waveforms
#  wave_send_once	        Transmits a waveform once
#  wave_send_repeat	        Transmits a waveform repeatedly
#  wave_send_using_mode	        Transmits a waveform in the chosen mode
#  wave_chain	                Transmits a chain of waveforms
#  wave_tx_at	                Returns the current transmitting waveform
#  wave_tx_busy	                Checks to see if the waveform has ended
#  wave_tx_stop	                Aborts the current waveform
#  wave_get_cbs	                Length in cbs of the current waveform
#  wave_get_high_cbs	        Length of longest waveform so far
#  wave_get_max_cbs	        Absolute maximum allowed cbs
#  wave_get_micros	        Length in micros of the current waveform
#  wave_get_high_micros	        Length of longest waveform so far
#  wave_get_max_micros	        Absolute maximum allowed micros
#  wave_get_pulses	        Length in pulses of the current waveform
#  wave_get_high_pulses	        Length of longest waveform so far
#  wave_get_max_pulses	        Absolute maximum allowed pulses
