const std = @import("std");
const print = std.debug.print;

const Point = struct {
    x: f32 = 0,
    y: f32 = 0,

    pub fn distance(self: Point, other: Point) f32 {
        const dx = self.x - other.x;
        const dy = self.y - other.y;
        return @sqrt(dx * dx + dy * dy);
    }
};

const Counter = struct {
    count: u32 = 0,

    pub fn bump(self: *Counter) void {
        self.count += 1;
    }
};

pub fn main() !void {
    const p = Point{ .x = 3, .y = 4 };
    const origin = Point{};
    print("distance={d:.2}\n", .{p.distance(origin)});

    var c = Counter{};
    c.bump();
    c.bump();
    c.bump();
    print("count={d}\n", .{c.count});
}

test "struct methods" {
    const p = Point{ .x = 3, .y = 4 };
    try std.testing.expectApproxEqAbs(@as(f32, 5), p.distance(.{}), 0.001);
}

test "default field values" {
    const p = Point{};
    try std.testing.expect(p.x == 0 and p.y == 0);
}

test "pointer receiver mutates" {
    var c = Counter{};
    c.bump();
    c.bump();
    try std.testing.expectEqual(@as(u32, 2), c.count);
}
