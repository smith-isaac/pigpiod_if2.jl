using pigpiod_if2_jll
include("./constants.jl")
#  SPI
#  spi_open	Opens a SPI device
#  int spi_open(int pi, unsigned spi_channel, unsigned baud, unsigned spi_flags)
#  This function returns a handle for the SPI device on the channel.
#  Data will be transferred at baud bits per second.
#  The flags may be used to modify the default behaviour of 4-wire operation, mode 0, active low chip select.
function spi_open(p::Int32, channel::Int, baud::Int, flags::Int)
    return ccall((:spi_open, libpigpiod_if2), Int32, (Int32, UInt32, UInt32, UInt32), p, channel, baud, flags)
end

#  spi_close	Closes a SPI device
#  int spi_close(int pi, unsigned handle)
#  This functions closes the SPI device identified by the handle.
function spi_close(p::Int32, handle::Int32)
    return ccall((:spi_close, libpigpiod_if2), Int32, (Int32, UInt32), p, handle)
end

#  spi_read	Reads bytes from a SPI device
#  int spi_read(int pi, unsigned handle, char *buf, unsigned count)
#  This function reads count bytes of data from the SPI device associated with the handle.
function spi_read(p::Int32, handle::Int32, buf::Vector{Int}, count::Int)
    return ccall((:spi_read, libpigpiod_if2), Int32, (Int32, UInt32, Ref{UInt8}, UInt32), p, handle, buf, count)
end

#  spi_write	Writes bytes to a SPI device
#  int spi_write(int pi, unsigned handle, char *buf, unsigned count)
#  This function writes count bytes of data from buf to the SPI device associated with the handle.
function spi_write(p::Int32, handle::Int32, buf::Vector{Int}, count::Int)
    return ccall((:spi_write, libpigpiod_if2), Int32, (Int32, UInt32, Ref{UInt8}, UInt32), p, handle, buf, count)
end

#  spi_xfer	Transfers bytes with a SPI device
#  int spi_xfer(int pi, unsigned handle, char *txBuf, char *rxBuf, unsigned count)
#  This function transfers count bytes of data from txBuf to the SPI device associated with the handle. Simultaneously count bytes of data are read from the device and placed in rxBuf.
function spi_xfer(p::Int32, handle::Int32, txBuf::Vector{Int}, rxBuf::Vector{Int}, count::Int)
    return ccall((:spi_xfer, libpigpiod_if2), Int32, (Int32, UInt32, Ref{UInt8}, Ref{UInt8}, UInt32), p, handle, txBuf, rxBuf, count)
end

#  SPI BIT BANG
#  bb_spi_open	Opens GPIO for bit banging SPI
#  int bb_spi_open(int pi, unsigned CS, unsigned MISO, unsigned MOSI, unsigned SCLK, unsigned baud, unsigned spi_flags)
#  This function selects a set of GPIO for bit banging SPI at a specified baud rate.
function bb_spi_open(p::Int32, cs::Int, miso::Int, mosi::Int, sclk::Int, baud::Int, flags::Int)
    return ccall((:bb_spi_open, libpigpiod_if2), Int32, (Int32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32), p, cs, miso, mosi, sclk, baud, flags)
end

#  bb_spi_close	Closes GPIO for bit banging SPI
#  int bb_spi_close(int pi, unsigned CS)
#  This function stops bit banging SPI on a set of GPIO opened with bbSPIOpen.
function bb_spi_close(p::Int32, cs::Int)
    return ccall((:bb_spi_close, libpigpiod_if2), Int32, (Int32, UInt32), p, cs)
end

#  bb_spi_xfer	Transfers bytes with bit banging SPI
#  int bb_spi_xfer(int pi, unsigned CS, char *txBuf, char *rxBuf, unsigned count)
#  This function executes a bit banged SPI transfer.
function bb_spi_xfer(p::Int32, cs::Int, txBuf::Vector{Int}, rxBuf::Vector{Int}, count::Int)
    return ccall((:bb_spi_xfer, libpigpiod_if2), Int32, (Int32, UInt32, Ref{UInt8}, Ref{UInt8}, UInt32), p, cs, txBuf, rxBuf, count)
end
