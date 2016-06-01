context("Labelled")

test_that("labelled return an object of class labelled",{
  x <- labelled(c(1,2,3), c(yes = 1, maybe = 2, no = 3))
  expect_that(is.labelled(x), is_true())
  expect_equal(class(x), "labelled")
})

test_that("x must be numeric or character", {
  expect_error(labelled(TRUE), "must be either numeric or a character vector")
})

test_that("x and labels must be compatible", {
  expect_error(labelled(1, "a"), "must be same type")
  expect_error(labelled(1, c(female = 2L, male = 1L)), NA)
  expect_error(labelled(1L, c(female = 2, male = 1)), NA)
})

test_that("labels must have names", {
  expect_error(labelled(1, 1), "must be a named vector")
})

# methods -----------------------------------------------------------------

test_that("printed output is stable", {
  x <- labelled(1:5, c("Good" = 1, "Bad" = 5))
  var_label(x) <- "Variable label"
  expect_output_file(print(x), "labelled-output.txt")
})

# remove_labels --------------------------------------------------------------

test_that("remove_labels strips labelled attributes", {
  var <- labelled(c(1L, 98L, 99L),  c(not_answered = 98L, not_applicable = 99L))
  exp <- c(1L,98L,99L)
  expect_equal(remove_labels(var), exp)
})

test_that("remove_labels returns variables not of class('labelled') unmodified", {
  var <- c(1L, 98L, 99L)
  expect_equal(remove_labels(var), var)
})






