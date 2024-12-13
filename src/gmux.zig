const std = @import("std");
const print = std.debug.print;
const window = @import("window.zig");

pub const Mode = enum { GMUX, LEADER };
pub const State = struct {
    windows: *std.ArrayList(window.Window),
    mode: Mode,
    current_window: i32,
};

pub fn init(windows: *std.ArrayList(window.Window)) !State {
    print("INITIALIZING GMUX\n", .{});

    const state = State{
        .windows = windows,
        .mode = Mode.GMUX,
        .current_window = 1,
    };

    try window.init_window(windows);

    return state;
}

pub fn spawn_sh(windows: *std.ArrayList(window.Window), name: []const u8, index: i32) !void {

    // default to fish for now
    const shell_cmd = "/usr/bin/fish";

    var cmd = std.process.Child.init(&[_][]const u8{shell_cmd}, std.heap.page_allocator);

    try cmd.spawn();

    try windows.append(window.Window{
        .name = name,
        .active = true,
        .index = index,
    });

    print("Spawned window {s} at index {}\n", .{ name, index });

    // in a real application you'd not want to ignore the status here probably
    _ = try cmd.wait();
}

pub fn update_status(state: *State) void {
    const mode_str = switch (state.mode) {
        Mode.GMUX => "GMUX",
        Mode.LEADER => "LEADER",
    };

    const window_count = 9; // TODO: Figure out how to get the length of ArrayList
    const curr_window = state.current_window;

    const status_line = "Mode: {s} | Window: {d} | Total: {d} windows";

    print(status_line, .{ mode_str, curr_window, window_count });
}
