const std = @import("std");
const print = std.debug.print;

pub const Window = struct {
    name: []const u8,
    active: bool,
    index: i32,
};

pub fn init_window(TotalWindows: *std.ArrayList(Window)) !void {
    const example = Window{ .name = "Example", .active = true, .index = 1 };

    try TotalWindows.append(example);

    print("name {s} - active {} - index: {}\n", .{ example.name, example.active, example.index });
}

pub fn close_window() !void {}

fn set_window_name() !void {}
