package aoc

import "core:slice"
import "core:strings"
import "core:strconv"
import "core:fmt"
import "core:unicode"
import "core:time"

part1 :: proc() -> uint {
    input := #load("input", string)
    search := input[:]

    sum: uint

    mul_search: for {
        offset := strings.index(search, "mul(")
        if offset == -1 do break
        search = search[offset+4:]

        end := strings.index_rune(search[:len("999,999)")], ')')
        if end == -1 do continue

        sep := strings.index_rune(search[:end], ',')
        if sep == -1 do continue

        for r in search[:end] {
            if !unicode.is_digit(r) && r != ',' do continue mul_search
        }

        num0, num0_ok := strconv.parse_uint(search[:sep], 10)
        num1, num1_ok := strconv.parse_uint(search[sep+1:end], 10)
        
        sum += num0 * num1
    }

    return sum
}

part2 :: proc() -> uint {
    input := #load("input", string)
    search := input[:]

    sum: uint

    do_mul := true

    mul_search: for {
        offset := strings.index(search, "mul(")
        if offset == -1 do break
        
        do_idx   := strings.last_index(search[:offset], "do()")
        dont_idx := strings.last_index(search[:offset], "don't()")

        if do_idx != -1 && do_idx > dont_idx {
            do_mul = true
        } else if dont_idx != -1 && dont_idx > do_idx {
            do_mul = false
        }

        search = search[offset+4:]
        if !do_mul do continue
        
        end := strings.index_rune(search[:len("999,999)")], ')')
        if end == -1 do continue

        sep := strings.index_rune(search[:end], ',')
        if sep == -1 do continue

        for r in search[:end] {
            if !unicode.is_digit(r) && r != ',' do continue mul_search
        }

        num0, num0_ok := strconv.parse_uint(search[:sep], 10)
        num1, num1_ok := strconv.parse_uint(search[sep+1:end], 10)
        
        sum += num0 * num1
    }

    return sum
}

//
//
//

BENCH_ITER :: 1000 when #config(DO_BENCH, false) else 1

@(optimization_mode="none")
main :: proc() {
    elapsed1: time.Duration
    val1: any

    for i in 0..<BENCH_ITER {
        start := time.tick_now()
        val1 = #force_no_inline part1()
        elapsed1 += time.tick_since(start)
    }
    
    fmt.printf("Part 1: %v, elapsed: %.5fms\n", val1, time.duration_milliseconds(elapsed1 / BENCH_ITER))

    fmt.println()

    elapsed2: time.Duration
    val2: any

    for i in 0..<BENCH_ITER {
        start := time.tick_now()
        val2 = #force_no_inline part2()
        elapsed2 += time.tick_since(start)
    }

    fmt.printf("Part 2: %v, elapsed: %.5fms\n", val2, time.duration_milliseconds(elapsed2 / BENCH_ITER))
}