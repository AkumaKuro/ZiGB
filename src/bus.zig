const std = @import("std");

pub const Bus = struct {
    rom: []const u8,
    vram: [0x2000]u8 = std.mem.zeroes([0x2000]u8),
    wram: [0x2000]u8 = std.mem.zeroes([0x2000]u8),
    oam: [0xA0]u8 = std.mem.zeroes([0xA0]u8),
    io: [0x80]u8 = std.mem.zeroes([0x80]u8),
    hram: [0x7F]u8 = std.mem.zeroes([0x7F]u8),
    ie_register: u8 = 0,
};
