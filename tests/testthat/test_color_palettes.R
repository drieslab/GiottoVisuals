test_that("getColors: error thrown when too few colors requested", {
    error_pattern <- "colors wanted must be at least 1"
    expect_error(getColors(n = 0.5),
        regexp = error_pattern
    )
    expect_error(getDistinctColors(0.5),
        regexp = error_pattern
    )
})

test_that("getColors: n is coerced to integer", {
    expect_length(getColors(n = 4.2), n = 4L)
    expect_length(getDistinctColors(4.2), n = 4L)
})

test_that("imported palettes work", {
    expect_no_condition(getColors(n = 4)) # hcl
    expect_no_condition(getColors("YlOrRd", 4)) # RColorBrewer)
})
