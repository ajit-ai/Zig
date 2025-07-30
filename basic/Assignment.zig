const print = std.debug.print;
const std = @import("std");

pub fn main() !void {
    const c: bool = true;

    var v: bool = false;
    v = true;

    const inferred = true;

    var u: bool = undefined;
    u = true;

    _ = c;
    _ = inferred;

    //print the value of each constant
    print("c: {}", c);
    print("v: {}", v);
    print("inferred: {}", inferred);
}
