module pigpiod_if2

using Libdl
using pigpiod_if2_jll

export PI_INPUT, PI_OUTPUT
export PI_PUD_UP, PI_PUD_OFF, PI_PUD_DOWN

@enum PIN_MODES begin
    PI_INPUT = 0
    PI_OUTPUT = 1
    PI_ALT0 = 4
    PI_ALT1 = 5
    PI_ALT2 = 6
    PI_ALT3 = 7
    PI_ALT4 = 3
    PI_ALT5 = 2
end

@enum PUD_MODES begin
    PI_PUD_OFF = 0
    PI_PUD_DOWN = 1
    PI_PUD_UP = 2
end

end # module
