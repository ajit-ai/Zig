const std = @import("std");
const print = std.debug.print;

pub fn narrow(x: u32) !u8 {
    if (x > 255) return error.Overflow;
    return @intCast(x);
}

pub fn main() !void {
    const big: i32 = 300;
    const small: u16 = @truncate(@as(u32, @bitCast(big)));
    print("bitCast/truncate: {d}\n", .{small});

    const f: f64 = 3.99;
    print("float->int: {d}\n", .{@as(i32, @intFromFloat(f))});
    print("int->float: {d:.1}\n", .{@as(f64, @floatFromInt(7))});

    var x: u8 = 200;
    x +%= 100;
    print("wrapping add: {d}\n", .{x});

    const bits: u8 = 0b1010_0000;
    print("popCount={d} clz={d} ctz={d}\n", .{ @popCount(bits), @clz(bits), @ctz(bits) });

    print("sizeOf(u64)={d} typeName={s}\n", .{ @sizeOf(u64), @typeName(Point) });
}

const Point = struct { x: f32 = 0, y: f32 = 0 };

test "safe narrowing" {
    try std.testing.expectEqual(@as(u8, 42), try narrow(42));
    try std.testing.expectError(error.Overflow, narrow(256));
}

test "casting builtins" {
    const a: u32 = 0xFFFF_FFFF;
    const as_i32: i32 = @bitCast(a);
    try std.testing.expectEqual(@as(i32, -1), as_i32);

    const approx: i32 = @intFromFloat(@as(f64, 9.9));
    try std.testing.expectEqual(@as(i32, 9), approx);
}

test "bit counting" {
    const bits: u16 = 0b0000_0000_0010_0100;
    try std.testing.expectEqual(2, @popCount(bits));
    try std.testing.expectEqual(10, @clz(bits));
    try std.testing.expectEqual(2, @ctz(bits));
}
