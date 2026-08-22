const std = @import("std");
const print = std.debug.print;

pub fn count_vowels(s: []const u8) usize {
    var n: usize = 0;
    for (s) |c| switch (c) {
        'a', 'e', 'i', 'o', 'u' => n += 1,
        else => {},
    };
    return n;
}

pub fn reversed(buf: []u8, src: []const u8) []u8 {
    var i: usize = 0;
    while (i < src.len) : (i += 1) buf[i] = src[src.len - 1 - i];
    return buf[0..src.len];
}

pub fn main() !void {
    const s = "hello, zig!";

    print("text: {s}\n", .{s});
    print("len={d} vowels={d}\n", .{ s.len, count_vowels(s) });

    var buf: [32]u8 = undefined;
    print("upper: {s}\n", .{std.ascii.upperString(buf[0..s.len], s)});
    print("reversed: {s}\n", .{reversed(&buf, s)});
}

test "count vowels" {
    try std.testing.expect(count_vowels("zig is fun") == 3);
    try std.testing.expect(count_vowels("") == 0);
    try std.testing.expect(count_vowels("xyz") == 0);
}

test "reverse" {
    var buf: [4]u8 = undefined;
    try std.testing.expectEqualStrings("cba", reversed(&buf, "abc"));
}
