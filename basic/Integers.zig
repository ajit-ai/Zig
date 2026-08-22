const std = @import("std");
const print = std.debug.print;

const a: u8 = 1;
const b: u32 = 10;
const c: i64 = 100;
const d: isize = 1_000;

const e: u21 = 10_000;
const f: i42 = 100_000;

const g: comptime_int = 1_000_000;
const h = 10_000_000;
const i = '💯';

pub fn hundred_point() u21 {
    return i;
}

pub fn fits_in_u8(x: comptime_int) bool {
    return x >= 0 and x <= 255;
}

pub fn main() !void {
    print("integer: {d}\n", .{i});
    print("unicode: {u}\n", .{i});
    print("h fits in u8: {}\n", .{fits_in_u8(h)});
}

test "arbitrary width types hold values" {
    try std.testing.expectEqual(@as(i64, 100), c);
    try std.testing.expectEqual(@as(isize, 1_000), d);
    try std.testing.expectEqual(@as(i42, 100_000), f);
}

test "unicode codepoint literal" {
    try std.testing.expectEqual(@as(u21, 128_175), hundred_point());
}

test "comptime_int digit separators" {
    try std.testing.expectEqual(1_000_000, g);
    try std.testing.expect(fits_in_u8(100));
    try std.testing.expect(!fits_in_u8(g));
}
