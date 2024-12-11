const std = @import("std");
const print = std.debug.print;
const window = @import("window.zig");

pub fn init(windows: *std.ArrayList(window.Window)) !void {
    print("INITIALIZING GMUX\n", .{});

    try window.init_window(windows);
}
