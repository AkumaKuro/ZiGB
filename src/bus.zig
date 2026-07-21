const std = @import("std");

pub const Bus = struct {
    rom: []const u8,
    vram: [0x2000]u8 = std.mem.zeroes([0x2000]u8),
    wram: [0x2000]u8 = std.mem.zeroes([0x2000]u8),
    oam: [0xA0]u8 = std.mem.zeroes([0xA0]u8),
    io: [0x80]u8 = std.mem.zeroes([0x80]u8),
    hram: [0x7F]u8 = std.mem.zeroes([0x7F]u8),
    ie_register: u8 = 0,

    pub fn read8(self: *Bus, addr: u16) u8 {
        return switch (addr) {
            0x0000...0x7FFF => self.rom[addr], // ROM bank 0 + bank N (no MBC yet)
            0x8000...0x9FFF => self.vram[addr - 0x8000],
            0xA000...0xBFFF => 0xFF, // TODO cartridge RAM
            0xC000...0xDFFF => self.wram[addr - 0xC000],
            0xE000...0xFDFF => self.wram[addr - 0xE000], // echo RAM mirrors WRAM
            0xFE00...0xFE9F => self.oam[addr - 0xFE00],
            0xFEA0...0xFEFF => 0xFF, // unusable
            0xFF00...0xFF7F => self.io[addr - 0xFF00],
            0xFF80...0xFFFE => self.hram[addr - 0xFF80],
            0xFFFF => self.ie_register,
        };
    }
    pub fn write8(self: *Bus, addr: u16, value: u8) void {
        switch (addr) {
            0x0000...0x7FFF => {}, // TODO writes to ROM (MBC bank-switch write intercepts)
            0x8000...0x9FFF => self.vram[addr - 0x8000] = value,
            0xA000...0xBFFF => {}, // TODO cartridge RAM
            0xC000...0xDFFF => self.wram[addr - 0xC000] = value,
            0xE000...0xFDFF => self.wram[addr - 0xE000] = value,
            0xFE00...0xFE9F => self.oam[addr - 0xFE00] = value,
            0xFEA0...0xFEFF => {}, // unusable
            0xFF00...0xFF7F => {
                self.io[addr - 0xFF00] = value;
                if (addr == 0xFF02 and value == 0x81) {
                    const byte = self.io[0xFF01 - 0xFF00];
                    std.debug.print("{c}", .{byte});
                }
            },
            0xFF80...0xFFFE => self.hram[addr - 0xFF80] = value,
            0xFFFF => self.ie_register = value,
        }
    }
};
