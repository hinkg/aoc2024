package aoc

import "core:slice"
import "core:strings"
import "core:strconv"
import "core:fmt"
import "core:unicode"
import "core:time"

part1 :: proc() -> int {
    input := #load("input", string)

    lines := strings.split_lines(input)

    count := 0

    for line in lines {
        for i in 0..<len(line)-3 {
            str := line[i:i+4]

            if str == "XMAS" || str == "SAMX" {
                count += 1
            }
        }
    }

    for i in 0..<len(lines[0]) {
        for j in 0..<len(lines)-3 {
            str := [4]u8{
                lines[j+0][i],
                lines[j+1][i],
                lines[j+2][i],
                lines[j+3][i]
            }

            if str == { 'X', 'M', 'A', 'S' } || str == { 'S', 'A', 'M', 'X' } {
                count += 1
            }
        }
    }

    for i in 0..<len(lines[0])-3 {
        for j in 0..<len(lines)-3 {
            str := [4]u8{
                lines[j+0][i+0],
                lines[j+1][i+1],
                lines[j+2][i+2],
                lines[j+3][i+3]
            }

            if str == { 'X', 'M', 'A', 'S' } || str == { 'S', 'A', 'M', 'X' } {
                count += 1
            }
        }
    }

    for i in 0..<len(lines[0])-3 {
        for j in 0..<len(lines)-3 {
            str := [4]u8{
                lines[j+0][i+3],
                lines[j+1][i+2],
                lines[j+2][i+1],
                lines[j+3][i+0]
            }

            if str == { 'X', 'M', 'A', 'S' } || str == { 'S', 'A', 'M', 'X' } {
                count += 1
            }
        }
    }

    return count
}

part2 :: proc() -> int {
    input := #load("input", string)

    lines := strings.split_lines(input)

    count := 0

    for i in 0..<len(lines[0])-2 {
        for j in 0..<len(lines)-2 {
            str0 := [3]u8{
                lines[j+0][i+2],
                lines[j+1][i+1],
                lines[j+2][i+0],
            }

            str1 := [3]u8{
                lines[j+0][i+0],
                lines[j+1][i+1],
                lines[j+2][i+2],
            }

            if (str0 == { 'M', 'A', 'S' } || str0 == { 'S', 'A', 'M' }) && (str1 == { 'M', 'A', 'S' } || str1 == { 'S', 'A', 'M' }) {
                count += 1
            }
        }
    }

    return count
}

//
//
//

@(optimization_mode="none")
main :: proc() {
    start := time.tick_now()
    val1 := #force_no_inline part1()
    elapsed1 := time.tick_since(start)

    fmt.printf("Part 1: %v, elapsed: %.5fms\n", val1, time.duration_milliseconds(elapsed1))

    fmt.println()

    start = time.tick_now()
    val2 := #force_no_inline part2()
    elapsed2 := time.tick_since(start)

    fmt.printf("Part 2: %v, elapsed: %.5fms\n", val2, time.duration_milliseconds(elapsed2))
}