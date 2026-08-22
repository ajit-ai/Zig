const std = @import("std");
const print = std.debug.print;

pub fn concat(a: [3]i32, b: [3]i32) [6]i32 {
    return a ++ b;
}

pub fn repeated(a: [3]i32) [6]i32 {
    return a ** 2;
}

pub fn sum(items: []const i32) i32 {
    var total: i32 = 0;
    for (items) |x| total += x;
    return total;
}

pub fn main() !void {
    const a = [3]i32{ 1, 2, 3 };

    const b = [_]i32{ 4, 5, 6 };

    const c: [3]i32 = .{ 7, 8, 9 };

    var d: [3]i32 = undefined;
    d[0] = 10;
    d[1] = 11;
    d[2] = 12;

    print("len: {}\n", .{c.len});

    print("repeat: {any}\n", .{repeated(a)});

    print("concat: {any}\n", .{concat(a, b)});

    for (d) |elem| {
        print("elem: {}\n", .{elem});
    }
}

test "array concatenation" {
    const a = [3]i32{ 1, 2, 3 };
    const b = [_]i32{ 4, 5, 6 };
    try std.testing.expectEqualSlices(i32, &.{ 1, 2, 3, 4, 5, 6 }, &concat(a, b));
}

test "array repetition" {
    const a = [3]i32{ 1, 2, 3 };
    try std.testing.expectEqualSlices(i32, &.{ 1, 2, 3, 1, 2, 3 }, &repeated(a));
}

test "sum of mutable array" {
    var d: [3]i32 = undefined;
    d[0] = 10;
    d[1] = 11;
    d[2] = 12;
    try std.testing.expectEqual(@as(i32, 33), sum(&d));
}
