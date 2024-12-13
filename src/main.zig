const std = @import("std");
const gmux = @import("gmux.zig");
const w = @import("window.zig");
const ArrayList = std.ArrayList;
const allocator = std.heap.page_allocator;

pub fn main() !void {
    var windows = ArrayList(w.Window).init(allocator);

    var state = try gmux.init(&windows);

    try gmux.spawn_sh(&windows, "New sh", 1);

    gmux.update_status(&state);

    defer windows.deinit();
}
