const std = @import("std");

const examples = [_][]const u8{
    "basic/Hello.zig",
    "basic/Assignment.zig",
    "basic/Arrays.zig",
    "basic/Integers.zig",
    "src/strings.zig",
    "src/structs.zig",
    "src/enums_unions.zig",
    "src/optionals.zig",
    "src/errors.zig",
    "src/comptime_generics.zig",
    "src/allocators.zig",
    "src/hashmaps.zig",
    "src/builtins_casting.zig",
    "src/vectors.zig",
};

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const test_step = b.step("test", "Run all unit tests");

    inline for (examples) |path| {
        const name = comptime stem(path);

        const exe = b.addExecutable(.{
            .name = name,
            .root_module = b.createModule(.{
                .root_source_file = b.path(path),
                .target = target,
                .optimize = optimize,
            }),
        });
        b.installArtifact(exe);

        const run_cmd = b.addRunArtifact(exe);
        if (b.args) |args| run_cmd.addArgs(args);
        const run_step = b.step(b.fmt("run-{s}", .{name}), b.fmt("Run {s} example", .{name}));
        run_step.dependOn(&run_cmd.step);

        const unit_tests = b.addTest(.{
            .root_module = b.createModule(.{
                .root_source_file = b.path(path),
                .target = target,
            }),
        });
        test_step.dependOn(&b.addRunArtifact(unit_tests).step);
    }
}

fn stem(comptime path: []const u8) []const u8 {
    const base = path[std.mem.lastIndexOfScalar(u8, path, '/').? + 1 ..];
    return base[0..std.mem.lastIndexOfScalar(u8, base, '.').?];
}
