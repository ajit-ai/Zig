const std = @import("std");

pub fn greeting() []const u8 {
    return "Hello, World!";
}

pub fn main() !void {
    std.debug.print("{s}\n", .{greeting()});
}

test "greeting text" {
    try std.testing.expectEqualStrings("Hello, World!", greeting());
}
