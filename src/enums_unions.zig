const std = @import("std");
const print = std.debug.print;

const Color = enum(u8) {
    red,
    green,
    blue,

    pub fn name(self: Color) []const u8 {
        return switch (self) {
            .red => "red",
            .green => "green",
            .blue => "blue",
        };
    }
};

const Shape = union(enum) {
    circle: f64,
    rect: struct { w: f64, h: f64 },

    pub fn area(self: Shape) f64 {
        return switch (self) {
            .circle => |radius| std.math.pi * radius * radius,
            .rect => |r| r.w * r.h,
        };
    }
};

pub fn main() !void {
    print("{s} has ordinal {d}\n", .{ Color.green.name(), @intFromEnum(Color.green) });

    const shapes = [_]Shape{
        .{ .circle = 1 },
        .{ .rect = .{ .w = 2, .h = 3 } },
    };
    for (shapes) |s| print("area={d:.3}\n", .{s.area()});
}

test "enum ordinal and name" {
    try std.testing.expectEqual(@as(u8, 1), @intFromEnum(Color.green));
    try std.testing.expectEqualStrings("blue", Color.blue.name());
}

test "tagged union area" {
    const sq: Shape = .{ .rect = .{ .w = 2, .h = 5 } };
    try std.testing.expect(sq.area() == 10.0);

    const unit: Shape = .{ .circle = 1 };
    try std.testing.expectApproxEqAbs(@as(f64, std.math.pi), unit.area(), 0.0001);
}
