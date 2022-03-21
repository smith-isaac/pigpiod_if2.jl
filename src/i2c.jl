using pigpiod_if2_jll
include("constants.jl")
# I2C
#  i2c_open                     Opens an I2C device
#  int i2c_open(int pi, unsigned i2c_bus, unsigned i2c_addr, unsigned i2c_flags)
#  Returns handle for the device at address addr on bus "bus"
function i2c_open(p::Int32, bus::Int, addr::Int, flags::Int)
    return ccall((:i2c_open, libpigpiod_if2), Int32, (Int32, UInt32, UInt32, UInt32), p, bus, addr, flags)
end

#  i2c_close                    Closes an I2C device
#  int i2c_close(int pi, unsigned handle)
#  Closes i2c device with associated handle
function i2c_close(p::Int32, handle::Int32)
    return ccall((:i2c_close, libpigpiod_if2), Int32, (Int32, UInt32), p, handle)
end

#  i2c_write_quick              smbus write quick
#  int i2c_write_quick(int pi, unsigned handle, unsigned bit)
#  Sends a single bit (0 ot 1) to the device associated with "handle"
function i2c_write_quick(p::Int32, handle::Int32, bit::Int)
    return ccall((:i2c_write_quick, libpigpiod_if2), Int32, (Int32, UInt32, UInt32), p, handle, bit)
end

#  i2c_read_byte                smbus read byte
#  int i2c_read_byte(int pi, unsigned handle)
#  Reads single byte from device with handle
function i2c_read_byte(p::Int32, handle::Int32)
    return ccall((:i2c_read_byte, libpigpiod_if2), Int32, (Int32, UInt32), p, handle)
end

#  i2c_write_byte               smbus write byte
#  int i2c_write_byte(int pi, unsigned handle, unsigned bVal)
#  Sends a single byte to the device with handle
function i2c_write_byte(p::Int32, handle::Int32, bVal::Int)
    return ccall((:i2c_write_byte, libpigpiod_if2), Int32, (Int32, UInt32, UInt32), p, handle, bVal)
end

#  i2c_read_byte_data           smbus read byte data
#  int i2c_read_byte_data(int pi, unsigned handle, unsigned i2c_reg)
#  Reads single byte from specified register of device with associated handle
function i2c_read_byte_data(p::Int32, handle::Int32, reg::Int)
    return ccall((:i2c_read_byte_data, libpigpiod_if2), Int32, (Int32, UInt32, UInt32), p, handle, reg)
end

#  i2c_write_byte_data          smbus write byte data
#  int i2c_write_byte_data(int pi, unsigned handle, unsigned i2c_reg, unsigned bVal)
#  Writes single byte to the specified register of the device associated with handle
function i2c_write_byte_data(p::Int32, handle::Int32, reg::Int, bVal::Int)
    return ccall((:i2c_write_byte_data, libpigpiod_if2), Int32, (Int32, UInt32, UInt32, UInt32), p, handle, reg, bVal)
end

#  i2c_read_word_data           smbus read word data
#  int i2c_read_word(int pi, unsigned handle, unsigned i2c_reg)
#  Reads single 16 bit word from specified register of device with associated handle
function i2c_read_word_data(p::Int32, handle::Int32, reg::Int)
    return ccall((:i2c_read_word_data, libpigpiod_if2), Int32, (Int32, UInt32, UInt32), p, handle, reg)
end

#  i2c_write_word_data          smbus write word data
#  int i2c_write_word_data(int pi, unsigned handle, unsigned i2c_reg, unsigned wVal)
#  Writes a single 16 bit word to specified register of device associated with handle
function i2c_write_word_data(p::Int32, handle::Int32, reg::Int, wVal::Int)
    return ccall((:i2c_write_word_data, libpigpiod_if2), Int32, (Int32, UInt32, UInt32, UInt32), p, handle, reg, wVal)
end

#  i2c_read_block_data          smbus read block data
#  int i2c_read_block_data(int pi, unsigned handle, unsigned i2c_reg, char *buf)
#  Reads block of up to 32 bytes from the specified register of the device associated with handle.
function i2c_read_block_data(p::Int32, handle::Int32, reg::Int, buf::Vector)
    return ccall((:i2c_read_block_data, libpigpiod_if2), Int32, (Int32, UInt32, UInt32, Ref{UInt8}), p, handle, reg, buf)
end

#  i2c_write_block_data         smbus write block data
#  int i2c_write_block_data(int pi, unsigned handle, unsigned i2c_reg, char *buf, unsigned count)
#  Writes up to 32 bytes to the specified register of the device associated with handle
function i2c_write_block_data(p::Int32, handle::Int32, reg::Int, buf::Vector, count::Int)
    return ccall((:i2c_write_block_data, libpigpiod_if2), Int32, (Int32, UInt32, UInt32, Ref{UInt8}, UInt32), p, handle, reg, buf, count)
end

#  i2c_read_i2c_block_data      smbus read I2C block data
#  int i2c_read_i2c_block_data(int pi, unsigned handle, unsigned i2c_reg, char *buf, unsigned count)
#  Reads count bytes from the specified register of the device associated with handle
function i2c_read_i2c_block_data(p::Int32, handle::Int32, reg::Int, buf::Vector, count::Int)
    return ccall((:i2c_read_i2c_block_data, libpigpiod_if2), Int32, (Int32, UInt32, UInt32, Ref{UInt8}, UInt32), p, handle, reg, buf, count)
end

#  i2c_write_i2c_block_data     smbus write I2C block data
#  int i2c_write_i2c_block_data(int pi, unsigned handle, unsigned i2c_reg, char *buf, unsigned count)
#  Writes count bytes from the specified register of the device associated with handle
function i2c_write_i2c_block_data(p::Int32, handle::Int32, reg::Int, buf::Vector, count::Int)
    return ccall((:i2c_write_i2c_block_data, libpigpiod_if2), Int32, (Int32, UInt32, UInt32, Ref{UInt8}, UInt32), p, handle, reg, buf, count)
end

#  i2c_read_device              Reads the raw I2C device
#  int i2c_read_device(int pi, unsigned handle, char *buf, unsigned count)
#  Reads count bytes from ray device into buf
function i2c_read_device(p::Int32, handle::Int32, buf::Vector, count::Int)
    return ccall((:i2c_read_device, libpigpiod_if2), Int32, (Int32, UInt32, Ref{UInt8}, UInt32), p, handle, buf, count)
end

#  i2c_write_device             Writes the raw I2C device
#  int i2c_write_device(int pi, unsigned handle, char *buf, unsigned count)
#  Writes count bytes from buf to raw device
function i2c_write_device(p::Int32, handle::Int32, buf::Vector, count::Int)
    return ccall((:i2c_write_device, libpigpiod_if2), Int32, (Int32, UInt32, Ref{UInt8}, UInt32), p, handle, buf, count)
end

#  i2c_process_call             smbus process call
#  int i2c_process_call(int pi, unsigned handle, unsigned i2c_reg, unsigned wVal)
#  Writes 2 byte word data to specified register of device with handle and reads 2 bytes of data in return
function i2c_process_call(p::Int32, handle::Int32, reg::Int, wVal::Int)
    return ccall((:i2c_process_call, libpigpiod_if2), Int32, (Int32, UInt32, UInt32, UInt32), p, handle, reg, wVal)
end

#  i2c_block_process_call       smbus block process call
#  int i2c_block_process_call(int pi, unsigned handle, unsigned i2c_reg, char *buf, unsigned count)
#  Writes data bytes to specific register of of device associated with handle and reads a device specified number of bytes in return
function i2c_block_process_call(p::Int32, handle::Int32, reg::Int, buf::Vector, count::Int)
    return ccall((:i2c_block_process_call, libpigpiod_if2), Int32, (Int32, UInt32, UInt32, Ref{UInt8}, UInt32), p, handle, reg, buf, count)
end

#  i2c_zip                      Performs multiple I2C transactions
#  int i2c_zip(int pi, unsigned handle, char *inBuf, unsigned inLen, char *outBuf, unsigned outLen)
#  This function executes a sequence of I2C operations. The operations to be performed are specified by the contents of inBuf which contains the concatenated command codes and associated data.
function i2c_zip(p::Int32, handle::Int32, inBuf::Vector, inLen::Int, outBuf::Vector, outLen::Int)
    return ccall((:i2c_zip, libpigpiod_if2), Int32, (Int32, UInt32, Ref{UInt8}, UInt32, Ref{UInt8}, UInt32), p, handle, inBuf, inLen, outBuf, outLen)
end

# I2C BIT BANG
#  bb_i2c_open          Opens GPIO for bit banging I2C
#  Sets a pair of GPIO for bit banging I2C at a specific baud rate
function bb_i2c_open(p::Int32, sda::Int, scl::Int, baud::Int)
    return ccall((:bb_i2c_open, libpigpiod_if2), Int32, (Int32, UInt32, UInt32, UInt32), p, sda, scl, baud)
end

#  bb_i2c_close         Closes GPIO for bit banging I2C
#  int bb_i2c_close(int pi, unsigned SDA)
#  Stops bit banging I2C on a pair of GPIO previously opened
function bb_i2c_close(p::Int32, sda::Int)
    return ccall((:bb_i2c_close, libpigpiod_if2), Int32, (Int32, UInt32), p, sda)
end

#  bb_i2c_zip           Performs bit banged I2C transactions
#  int bb_i2c_zip(int pi, unsigned SDA, char *inBuf, unsigned inLen, char *outBuf, unsigned outLen)
#  This function executes a sequence of bit banged I2C operations. The operations to be performed are specified by the contents of inBuf which contains the concatenated command codes and associated data.
function bb_i2c_zip(p::Int32, sda::Int, scl::Int, inBuf::Vector, inLen::Int, outBuf::Vector, outLen::Int)
    return ccall((:bb_i2c_zip, libpigpiod_if2), Int32, (Int32, UInt32, UInt32, Ref{UInt8}, UInt32, Ref{UInt8}, UInt32), p, sda, scl, inBuf, inLen, outBuf, outLen)
end

# I2C/SPI SLAVE
mutable struct bsc_xfer_t
    control::Int
    rxCnt::Int
    rxBuf::Vector{Int}
    txCnt::Int
    txBuf::Vector{Int}
end

#  bsc_xfer             I2C/SPI as slave transfer
#  int bsc_xfer(int pi, bsc_xfer_t *bscxfer)
#  This function provides a low-level interface to the SPI/I2C Slave peripheral on the BCM chip.
function bsc_xfer(p::Int32, bscxfer::bsc_xfer_t)
    return ccall((:bsc_xfer, libpigpiod_if2), Int32, (Int32, Ref{bsc_xfer_t}), p, bscxfer)
end

#  bsc_i2c              I2C as slave transfer
#  int bsc_i2c(int pi, int i2c_addr, bsc_xfer_t *bscxfer)
#  Allows Pi to act as a slace I2C device
function bsc_i2c(p::Int32, addr::Int32, bscxfer::bsc_xfer_t)
    return ccall((:bsc_i2c, libpigpiod_if2), Int32, (Int32, Int32, Ref{bsc_xfer_t}), p, addr, bscxfer)
end
