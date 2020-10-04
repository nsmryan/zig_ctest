const std = @import("std");

const ctest = @cImport({
    @cInclude("test.h");
});

const zigtest = @import("test.zig");

pub fn main() void {
    std.debug.print("Trying Zig:\n", .{});
    try_iterate_zigimport();

    std.debug.print("\n\n", .{});

    std.debug.print("Trying C:\n", .{});
    try_iterate_cimport();
}

/// Iterate through the types in a Zig file, showing that structures can be
/// instatiated this way.
pub fn try_iterate_zigimport() void {
    // instantiate the struct normally as a test
    const test_struct = zigtest.TestStruct{ .field0 = 1, .field1 = 2, .field2 = 3 };
    std.debug.print("field0 = {}\n", .{test_struct.field0});
    std.debug.print("field1 = {}\n", .{test_struct.field1});
    std.debug.print("field2 = {}\n", .{test_struct.field2});

    // describe the zig import zigtest
    std.debug.print("zigtest type is {}\n", .{@typeName(zigtest)});
    std.debug.print("zigtest typeInfo tag is {}\n", .{@tagName(@typeInfo(zigtest))});

    std.debug.print("zigtest type info {}\n", .{@typeInfo(zigtest)});

    std.debug.print("zigtest decls {}\n", .{@typeInfo(zigtest).Struct.decls});

    // look through zig import and instantiate the struct without naming it directly
    inline for (@typeInfo(zigtest).Struct.decls) |decl| {
        std.debug.print("decl name = {}\n", .{decl.name});
        std.debug.print("decl tag = {}\n", .{@tagName(@typeInfo(@TypeOf(decl)))});

        const test_struct2 = decl.data.Type{ .field0 = 1, .field1 = 2, .field2 = 3 };
        std.debug.print("field0 = {}\n", .{test_struct2.field0});
        std.debug.print("field1 = {}\n", .{test_struct2.field1});
        std.debug.print("field2 = {}\n", .{test_struct2.field2});
    }
}

pub fn try_iterate_cimport() void {
    // we can instantiate this struct directly
    const test_struct = ctest.TestStruct{ .field0 = 1, .field1 = 2, .field2 = 3 };

    std.debug.print("field0 = {}\n", .{test_struct.field0});
    std.debug.print("field1 = {}\n", .{test_struct.field1});
    std.debug.print("field2 = {}\n", .{test_struct.field2});

    // the cimport appears as a struct according to the typeinfo, although
    // its type is cimport
    std.debug.print("ctest type is {}\n", .{@typeName(ctest)});
    std.debug.print("ctest typeInfo tag is {}\n", .{@tagName(@typeInfo(ctest))});

    // This causes a core dump with a TODO note:
    //std.debug.print("ctest type info {}\n", .{@typeInfo(ctest)});

    // This also causes a core dump with a TODO note:
    //std.debug.print("ctest decls {}\n", .{@typeInfo(ctest).Struct.decls});
}
