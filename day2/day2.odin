package aoc

import "core:slice"
import "core:strings"
import "core:strconv"
import "core:fmt"
import "core:unicode"
import "core:time"

part1 :: proc() -> int {
    input := #load("input", string)

    num_safe := 0

    for line in strings.split_lines_iterator(&input) {
        l := line
        last_num := -1
        sign := 0

        is_safe := false

        for word in strings.split_iterator(&l, " ") {
            num, got_num := strconv.parse_int(word, 10)
            if !got_num do continue

            if last_num != -1 {
                diff := num - last_num
                is_safe = true

                if sign == 0 {
                    sign = diff < 0 ? -1 : +1
                } else if (sign != (diff < 0 ? -1 : +1)) {
                    is_safe = false
                    break
                }

                if diff == 0 || abs(diff) > 3 {
                    is_safe = false
                    break
                }
            }

            last_num = num
        }

        num_safe += is_safe ? 1 : 0
    }

    return num_safe
}

part2 :: proc() -> int {
    input := #load("input", string)

    num_safe := 0

    for line in strings.split_lines_iterator(&input) {
        l := line
        last_num := -1
        sign := 0

        safety_level := 1

        for word in strings.split_iterator(&l, " ") {
            num, got_num := strconv.parse_int(word, 10)
            if !got_num do continue

            if last_num != -1 {
                diff := num - last_num
                
                if sign == 0 {
                    sign = diff < 0 ? -1 : +1
                } else if (sign != (diff < 0 ? -1 : +1)) {
                    safety_level -= 1
                }

                if diff == 0 || abs(diff) > 3 {
                    safety_level -= 1
                }
            }

            last_num = num
        }

        num_safe += safety_level >= 0 ? 1 : 0
    }

    return num_safe
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