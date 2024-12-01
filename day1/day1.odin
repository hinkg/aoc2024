package aoc

import "core:slice"
import "core:strings"
import "core:strconv"
import "core:fmt"
import "core:unicode"
import "core:time"

part1 :: proc() -> int {
    input := string(#load("input"))
    lists := [2][dynamic]int { make([dynamic]int, 0, 1000), make([dynamic]int, 0, 1000) }

    for line in strings.split_lines_iterator(&input) {
        left, _ := strings.substring(line, 0, strings.index(line, " "))
        right, _ := strings.substring(line, strings.last_index(line, " ")+1, len(line))

        append(&lists.x, strconv.parse_int(left) or_break)
        append(&lists.y, strconv.parse_int(right) or_break)
    }

    slice.sort(lists.x[:])
    slice.sort(lists.y[:])

    sum := 0

    for left, idx in lists.x {
        right := lists.y[idx]
        
        sum += abs(left - right)
    }

    return sum
}

part2 :: proc() -> int {
    input := string(#load("input"))
    lists := [2][dynamic]int { make([dynamic]int, 0, 1000), make([dynamic]int, 0, 1000) }

    for line in strings.split_lines_iterator(&input) {
        left, _ := strings.substring(line, 0, strings.index(line, " "))
        right, _ := strings.substring(line, strings.last_index(line, " ")+1, len(line))

        append(&lists.x, strconv.parse_int(left) or_break)
        append(&lists.y, strconv.parse_int(right) or_break)
    }

    sum := 0

    for left in lists.x {
        sum += left * slice.count(lists.y[:], left)
    }

    return sum
}

main :: proc() {
    part1_start := time.tick_now()
    val1 := part1()
    elapsed1 := time.duration_milliseconds(time.tick_since(part1_start))
    fmt.printf("Part 1: %v, elapsed: %.3fms\n", val1, elapsed1)

    fmt.println()

    part2_start := time.tick_now()
    val2 := part2()
    elapsed2 := time.duration_milliseconds(time.tick_since(part2_start))
    fmt.printf("Part 2: %v, elapsed: %.3fms\n", val2, elapsed2)
}