const std = @import("std");
const gmux = @import("gmux.zig");
const w = @import("window.zig");
const ArrayList = std.ArrayList;
const allocator = std.heap.page_allocator;

pub fn main() !void {
    var windows = ArrayList(w.Window).init(allocator);

    try gmux.init(&windows);

    defer windows.deinit();
}
