const std = @import("std");
const print = std.debug.print;

pub fn find_first_even(nums: []const i32) ?i32 {
    for (nums) |n| {
        if (@mod(n, 2) == 0) return n;
    }
    return null;
}

pub fn main() !void {
    const odds = [_]i32{ 1, 3, 5 };
    const mixed = [_]i32{ 1, 4, 7 };

    if (find_first_even(&mixed)) |even| {
        print("found even: {d}\n", .{even});
    } else {
        print("no even found\n", .{});
    }

    const none = find_first_even(&odds) orelse -1;
    print("orelse fallback: {d}\n", .{none});
}

test "optional payload capture" {
    try std.testing.expectEqual(@as(?i32, 4), find_first_even(&.{ 1, 4, 7 }));
}

test "optional null" {
    try std.testing.expect(find_first_even(&.{ 1, 3 }) == null);
    try std.testing.expectEqual(@as(i32, -1), find_first_even(&.{}) orelse -1);
}
