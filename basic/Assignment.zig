const print = std.debug.print;
const std = @import("std");

pub fn main() !void {
    const c: bool = true;

    var v: bool = false;
    v = true;

    const inferred = true;

    var u: bool = undefined;
    u = true;

    //print the value of each constant
    print("c: {}\n", .{c});
    print("v: {}\n", .{v});
    print("inferred: {}\n", .{inferred});
}
