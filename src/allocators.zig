const std = @import("std");
const print = std.debug.print;

pub fn squares_up_to(n: u32, allocator: std.mem.Allocator) ![]u32 {
    var list: std.ArrayList(u32) = .empty;
    errdefer list.deinit(allocator);

    for (0..n) |i| {
        const v: u32 = @intCast(i);
        try list.append(allocator, v * v);
    }
    return list.toOwnedSlice(allocator);
}

pub fn main() !void {
    var arena_state = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena_state.deinit();
    const arena = arena_state.allocator();

    const squares = try squares_up_to(6, arena);
    defer arena.free(squares);

    var total: u64 = 0;
    for (squares) |v| total += v;
    print("squares={any} sum={d}\n", .{ squares, total });
}

test "arena allocated slice" {
    var arena_state = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena_state.deinit();

    const got = try squares_up_to(4, arena_state.allocator());
    try std.testing.expectEqualSlices(u32, &.{ 0, 1, 4, 9 }, got);
}

test "leak-checked with testing allocator" {
    const xs = try squares_up_to(3, std.testing.allocator);
    defer std.testing.allocator.free(xs);
    try std.testing.expectEqual(@as(usize, 3), xs.len);
}
