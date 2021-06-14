const std = @import("std");

pub fn main() !void {
    const reset = "\u{001b}[0m\n";
    const spacer = "           ";
    const bar = "        ";
    const stdout = std.io.getStdOut().writer();

    try stdout.print("\n", .{});

    var i: u8 = 0;
    while (i < 14) {
        const colors = [_]u8{ 7, 3, 6, 2, 5, 1, 4 };
        try stdout.print(spacer, .{});

        var j: u8 = 0;
        while (j < 7) {
            try stdout.print("\u{001b}[4{d}m", .{colors[j]});
            try stdout.print(bar, .{});
            j += 1;
        }

        try stdout.print(reset, .{});
        i += 1;
    }

    i = 0;
    while (i < 2) {
        const colors = [_]u8{ 4, 0, 5, 0, 6, 0, 7 };
        try stdout.print(spacer, .{});
        var j: u8 = 0;
        while (j < 7) {
            try stdout.print("\u{001b}[4{d}m", .{colors[j]});
            try stdout.print(bar, .{});
            j += 1;
        }

        try stdout.print(reset, .{});
        i += 1;
    }

    i = 0;
    while (i < 5) {
        const colors = [_]u8{ 4, 4, 4, 4, 4, 7, 7, 7, 7, 7, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
        try stdout.print("{s}", .{spacer});
        var j: u8 = 0;
        while (j < 28) {
            try stdout.print("\u{001b}[4{d}m", .{colors[j]});
            try stdout.print("  ", .{});
            j += 1;
        }

        try stdout.print(reset, .{});
        i += 1;
    }
}
