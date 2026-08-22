# Zig Examples

A learning repository of idiomatic [Zig](https://ziglang.org) examples,
organized feature-by-feature, each with runnable demos and unit tests.

## Requirements

- Zig 0.15.x / 0.16-dev (`zig version`)
- No third-party dependencies

## Quick start

```sh
zig build              # build every example into zig-out/bin
zig build test         # run ALL unit tests across every module
zig build run-vectors  # run one specific example (run-<name>)
zig test src/strings.zig   # or test a single file directly
```

## Examples index

| Module | Topic |
| --- | --- |
| `basic/Hello.zig` | Hello world, entry point |
| `basic/Assignment.zig` | const/var, booleans, undefined |
| `basic/Integers.zig` | Arbitrary-width ints, comptime_int, unicode literals |
| `basic/Arrays.zig` | Arrays, repeat `**`, concat `++` |
| `src/strings.zig` | Slices, string literals, std.ascii helpers |
| `src/structs.zig` | Structs, methods, pointer receivers, defaults |
| `src/enums_unions.zig` | Enums, tagged unions, switch exhaustiveness |
| `src/optionals.zig` | `?T`, orelse, payload capture |
| `src/errors.zig` | Error sets, try/catch, error names |
| `src/comptime_generics.zig` | comptime params, generics via `type`, comptime fib |
| `src/allocators.zig` | ArenaAllocator, ArrayList, testing allocator leak checks |
| `src/hashmaps.zig` | StringHashMap, getOrPut, iterators |
| `src/builtins_casting.zig` | @intCast/@bitCast/@truncate, bit counting builtins |
| `src/vectors.zig` | @Vector SIMD ops, @reduce |

## Layout

```
basic/   # beginner snippets (original examples)
src/     # feature-focused modules with unit tests
```

## Testing style

Every module embeds `test` blocks using `std.testing`
(`expectEqual`, `expectEqualStrings`, `expectError`,
`testing.allocator` leak detection, ...). `zig build test` compiles and runs
them all in one command.
