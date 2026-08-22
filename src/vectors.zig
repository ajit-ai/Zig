const std = @import("std");
const print = std.debug.print;

pub fn dot(a: @Vector(4, f32), b: @Vector(4, f32)) f32 {
    return @reduce(.Add, a * b);
}

pub fn main() !void {
    const a: @Vector(4, f32) = .{ 1, 2, 3, 4 };
    const b: @Vector(4, f32) = .{ 10, 20, 30, 40 };

    print("a+b={any}\n", .{a + b});
    print("dot={d}\n", .{dot(a, b)});
}

test "vector arithmetic" {
    const a: @Vector(4, i32) = .{ 1, 2, 3, 4 };
    const b: @Vector(4, i32) = .{ 1, 1, 1, 1 };
    const sum = a + b;
    try std.testing.expectEqual(@as(i32, 2), sum[0]);
    try std.testing.expectEqual(@as(i32, 5), sum[3]);
}

test "vector reduce" {
    const v: @Vector(4, i32) = .{ 1, 2, 3, 4 };
    try std.testing.expectEqual(10, @reduce(.Add, v));
    try std.testing.expectEqual(4, @reduce(.Max, v));
}

test "float dot product" {
    const r = dot(.{ 1, 0, 0, 1 }, .{ 2, 5, 5, 3 });
    try std.testing.expect(r == 5.0);
}
