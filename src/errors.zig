const std = @import("std");
const print = std.debug.print;

const ParseError = error{
    TooLarge,
    Negative,
};

fn to_u8(input: i32) ParseError!u8 {
    if (input < 0) return error.Negative;
    if (input > 255) return error.TooLarge;
    return @intCast(input);
}

fn load_setting(raw: i32) u8 {
    return to_u8(raw) catch |err| blk: {
        print("using fallback after error: {s}\n", .{@errorName(err)});
        break :blk 42;
    };
}

pub fn main() !void {
    const ok = try to_u8(200);
    print("try succeeded: {d}\n", .{ok});

    print("catch fallback: {d}\n", .{load_setting(999)});
}

test "error set success" {
    try std.testing.expectEqual(@as(u8, 200), try to_u8(200));
}

test "error propagation" {
    try std.testing.expectError(error.TooLarge, to_u8(300));
    try std.testing.expectError(error.Negative, to_u8(-1));
}

test "catch with fallback" {
    try std.testing.expectEqual(@as(u8, 42), load_setting(-5));
}
