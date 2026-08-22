const std = @import("std");
const print = std.debug.print;

pub fn max_of(comptime T: type, a: T, b: T) T {
    return if (a > b) a else b;
}

pub fn fib(comptime n: usize) usize {
    if (n < 2) return n;
    return fib(n - 1) + fib(n - 2);
}

pub fn Stack(comptime T: type) type {
    return struct {
        const Self = @This();

        items: [16]T = undefined,
        len: usize = 0,

        pub fn push(self: *Self, v: T) !void {
            if (self.len >= self.items.len) return error.Overflow;
            self.items[self.len] = v;
            self.len += 1;
        }

        pub fn pop(self: *Self) !T {
            if (self.len == 0) return error.Underflow;
            self.len -= 1;
            return self.items[self.len];
        }
    };
}

pub fn main() !void {
    print("max_of(3, 7)={d} max_of(2.5, 1.5)={d:.1}\n", .{ max_of(i32, 3, 7), max_of(f64, 2.5, 1.5) });
    print("comptime fib(10)={d}\n", .{fib(10)});

    var stack: Stack(u8) = .{};
    try stack.push('z');
    const top = try stack.pop();
    print("popped: {c}\n", .{top});
}

test "generic max" {
    try std.testing.expectEqual(@as(i32, 7), max_of(i32, 3, 7));
    try std.testing.expect(max_of(f64, 2.5, 1.5) == 2.5);
}

test "comptime evaluation" {
    const result = comptime fib(10);
    try std.testing.expectEqual(55, result);
}

test "generic stack push/pop" {
    var s: Stack(i32) = .{};
    try s.push(10);
    try s.push(20);
    try std.testing.expectEqual(@as(i32, 20), try s.pop());
    try std.testing.expectEqual(@as(i32, 10), try s.pop());
    try std.testing.expectError(error.Underflow, s.pop());
}
