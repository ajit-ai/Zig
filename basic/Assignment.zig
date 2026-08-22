const print = std.debug.print;
const std = @import("std");

pub fn reassigned_v() bool {
    var v: bool = false;
    v = true;
    return v;
}

pub fn flip(b: bool) bool {
    return !b;
}

pub fn main() !void {
    const c: bool = true;

    const inferred = true;

    var u: bool = undefined;
    u = true;

    //print the value of each constant
    print("c: {}\n", .{c});
    print("v: {}\n", .{reassigned_v()});
    print("inferred: {}\n", .{inferred});
    print("flip(u): {}\n", .{flip(u)});
}

test "var can be reassigned" {
    try std.testing.expect(reassigned_v());
}

test "flip negates" {
    try std.testing.expectEqual(false, flip(true));
    try std.testing.expectEqual(true, flip(false));
}
