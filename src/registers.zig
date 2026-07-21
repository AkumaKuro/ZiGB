const std = @import("std");

pub const Flags = struct {
    pub const ZERO: u8 = 0b1000_0000;
    pub const SUBTRACT: u8 = 0b0100_0000;
    pub const HALF_CARRY: u8 = 0b0010_0000;
    pub const CARRY: u8 = 0b0001_0000;
};

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

    pub fn getAF(self: *Registers) u16 {
        return (@as(u16, self.a) << 8) | @as(u16, self.f);
    }

    pub fn setAF(self: *Registers, value: u16) void {
        self.b = @truncate(value >> 8);
        self.c = @truncate(value & 0xFF);
    }

    pub fn getBC(self: *Registers) u16 {
        return (@as(u16, self.b) << 8) | @as(u16, self.c);
    }

    pub fn setBC(self: *Registers, value: u16) void {
        self.b = @truncate(value >> 8);
        self.c = @truncate(value & 0xFF);
    }

    pub fn getDE(self: *Registers) u16 {
        return (@as(u16, self.d) << 8) | @as(u16, self.e);
    }

    pub fn setDE(self: *Registers, value: u16) void {
        self.d = @truncate(value >> 8);
        self.e = @truncate(value & 0xFF);
    }

    pub fn getHL(self: *Registers) u16 {
        return (@as(u16, self.h) << 8) | @as(u16, self.l);
    }

    pub fn setHL(self: *Registers, value: u16) void {
        self.h = @truncate(value >> 8);
        self.l = @truncate(value & 0xFF);
    }
};
