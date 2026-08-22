const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    var arena_state = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena_state.deinit();
    const allocator = arena_state.allocator();

    var scores = std.StringHashMap(i32).init(allocator);
    defer scores.deinit();

    try scores.put("alice", 90);
    try scores.put("bob", 75);

    if (scores.getPtr("bob")) |v| v.* += 5;

    var it = scores.iterator();
    while (it.next()) |entry| {
        print("{s}: {d}\n", .{ entry.key_ptr.*, entry.value_ptr.* });
    }
    print("size={d}\n", .{scores.count()});
}

fn word_counts(allocator: std.mem.Allocator, text: []const u8) !std.StringHashMap(u32) {
    var counts = std.StringHashMap(u32).init(allocator);

    var iter = std.mem.tokenizeAny(u8, text, " \n");
    while (iter.next()) |word| {
        const gop = try counts.getOrPut(word);
        if (!gop.found_existing) gop.value_ptr.* = 0;
        gop.value_ptr.* += 1;
    }
    return counts;
}

test "hashmap put/get/update" {
    var map = std.StringHashMap(i32).init(std.testing.allocator);
    defer map.deinit();

    try map.put("a", 1);
    try map.put("b", 2);
    if (map.getPtr("b")) |v| v.* += 40;

    try std.testing.expectEqual(@as(i32, 42), map.get("b").?);
    try std.testing.expect(map.get("missing") == null);
}

test "word counting" {
    var counts = try word_counts(std.testing.allocator, "zig is fun and zig is fast");
    defer counts.deinit();

    try std.testing.expectEqual(@as(u32, 2), counts.get("zig").?);
    try std.testing.expectEqual(@as(u32, 2), counts.get("is").?);
    try std.testing.expectEqual(@as(u32, 1), counts.get("fast").?);
}
