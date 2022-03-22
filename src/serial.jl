using pigpiod_if2_jll
include("./constants.jl")

# SERIAL
#  serial_open                  Opens a serial device
#  int serial_open(int pi, char *ser_tty, unsigned baud, unsigned ser_flags)
#  This function opens a serial device at a specified baud rate with specified flags. The device name must start with /dev/tty or /dev/serial.
function serial_open(p::Int32, ser_tty::String, baud::Int, ser_flags::Int)
    return ccall((:serial_open, libpigpiod_if2), Int32, (Int32, Cstring, UInt32, UInt32), p, ser_tty, baud, ser_flags)
end

#  serial_close                 Closes a serial device
#  int serial_close(int pi, unsigned handle)
#  Closes serial device associated with handle.
function serial_close(p::Int32, handle::Int32)
    return ccall((:serial_close, libpigpiod_if2), Int32, (Int32, UInt32), p, handle)
end

#  serial_read_byte             Reads a byte from a serial device
#  int serial_read_byte(int pi, unsigned handle)
#  This function reads a byte from the serial port associated with handle.
function serial_read_byte(p::Int32, handle::Int32)
    return ccall((:serial_read_byte, libpigpiod_if2), Int32, (Int32, UInt32), p, handle)
end

#  serial_write_byte            Writes a byte to a serial device
#  int serial_write_byte(int pi, unsigned handle, unsigned bVal)
#  This function writes bVal to the serial port associated with handle.
function serial_write_byte(p::Int32, handle::Int32, bVal::Int)
    return ccall((:serial_write_byte, libpigpiod_if2), Int32, (Int32, UInt32, UInt32), p, handle, bVal)
end

#  serial_read	                Reads bytes from a serial device
#  int serial_read(int pi, unsigned handle, char *buf, unsigned count)
#  This function reads up to count bytes from the the serial port associated with handle and writes them to buf.
function serial_read(p::Int32, handle::Int32, buf::Vector{Int}, count::Int)
    return ccall((:serial_read, libpigpiod_if2), Int32, (Int32, UInt32, Ref{UInt8}, UInt32), p, handle, buf, count)
end

#  serial_write	                Writes bytes to a serial device
#  int serial_write(int pi, unsigned handle, char *buf, unsigned count)
#  This function writes count bytes from buf to the the serial port associated with handle.
function serial_write(p::Int32, handle::Int32, buf::Vector{Int}, count::Int)
    return ccall((:serial_write, libpigpiod_if2), Int32, (Int32, UInt32, Ref{UInt8}, UInt32), p, handle, buf, count)
end

#  serial_data_available	Returns number of bytes ready to be read
#  int serial_data_available(int pi, unsigned handle)
#  Returns the number of bytes available to be read from the device associated with handle.
function serial_data_available(p::Int32, handle::Int32)
    return ccall((:serial_data_available, libpigpiod_if2), Int32, (Int32, UInt32), p, handle)
end

# SERIAL BIT BANG (read only)
#  bb_serial_read_open	    Opens a GPIO for bit bang serial reads
#  int bb_serial_read_open(int pi, unsigned user_gpio, unsigned baud, unsigned data_bits)
#  This function opens a GPIO for bit bang reading of serial data.
function bb_serial_read_open(p::Int32, gpio::Int, baud::Int, bits::Int)
    return ccall((:bb_serial_read_open, libpigpiod_if2), Int32, (Int32, UInt32, UInt32, UInt32), p, gpio, baud, bits)
end

#  bb_serial_read_close	    Closes a GPIO for bit bang serial reads
#  int bb_serial_read_close(int pi, unsigned user_gpio)
#  This function closes a GPIO for bit bang reading of serial data.
function bb_serial_read_close(p::Int32, gpio::Int)
    return ccall((:bb_serial_read_close, libpigpiod_if2), Int32, (Int32, UInt32), p, gpio)
end

#  bb_serial_invert	    Invert serial logic (1 invert, 0 normal)
#  int bb_serial_invert(int pi, unsigned user_gpio, unsigned invert)
#  This function inverts serial logic for big bang serial reads.
function bb_serial_invert(p::Int32, gpio::Int, invert::Int)
    return ccall((:bb_serial_invert, libpigpiod_if2), Int32, (Int32, UInt32, UInt32), p, gpio, invert)
end

#  bb_serial_read	    Reads bit bang serial data from a GPIO
#  int bb_serial_read(int pi, unsigned user_gpio, void *buf, size_t bufSize)
#  This function copies up to bufSize bytes of data read from the bit bang serial cyclic buffer to the buffer starting at buf.
#  VERIFY THIS FUNCTION SINCE IT USES A VOID POINTER
function bb_serial_read(p::Int32, gpio::Int, buf, bufSize::Int)
    return ccall((:bb_serial_read, libpigpiod_if2), Int32, (Int32, UInt32, Ref{Any}, UInt32), p, gpio, buf, bufSize)
end
