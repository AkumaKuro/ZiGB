pub const Registers = struct {
    a: u8 = 0,
    f: u8 = 0, // flags register, only top 4 bits used
    b: u8 = 0,
    c: u8 = 0,
    d: u8 = 0,
    e: u8 = 0,
    h: u8 = 0,
    l: u8 = 0,
    sp: u16 = 0,
    pc: u16 = 0,
};
