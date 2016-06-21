context("Labelled")

test_that("labelled return an object of class labelled",{
  x <- labelled(c(1,2,3), c(yes = 1, maybe = 2, no = 3))
  expect_that(is.labelled(x), is_true())
  expect_equal(class(x), "labelled")
})

test_that("x must be numeric or character", {
  expect_error(labelled(TRUE))
})

test_that("x and labels must be compatible", {
  expect_error(labelled(1, "a"))
  expect_error(labelled(1, c(female = 2L, male = 1L)), NA)
  expect_error(labelled(1L, c(female = 2, male = 1)), NA)
})

test_that("labels must have names", {
  expect_error(labelled(1, 1))
})

test_that("labelled preserves variable label", {
  x <- 1:3
  var_label(x) <- "test"
  x <- labelled(x, c(yes = 1))
  expect_equal(attr(x, "label", exact = TRUE), "test")
})

# var_labels and var_label ------------------------------------------------

test_that("var_labels preserved variable label", {
  x <- 1:3
  var_label(x) <- "test"
  val_labels(x) <- c(yes = 1, no = 2)
  expect_equal(attr(x, "label", exact = TRUE), "test")

  val_labels(x) <- NULL
  expect_equal(attr(x, "label", exact = TRUE), "test")
})

test_that("var_label preserved variable label", {
  x <- 1:3
  var_label(x) <- "test"
  val_label(x, 1) <- "yes"
  expect_equal(attr(x, "label", exact = TRUE), "test")

  val_label(x, 1) <- NULL
  expect_equal(attr(x, "label", exact = TRUE), "test")
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

# to_factor --------------------------------------------------------------------

test_that("to_factor preserves variable label", {
  x <- labelled(c(1, 1, 2), c(yes = 1, no = 2))
  var_label(x) <- "yes/no"
  expect_equal(var_label(to_factor(x)), var_label(x))
})


# to_character --------------------------------------------------------------------

test_that("to_character produce an appropriate character vector", {
  x <- labelled(c(1, 1, 2), c(yes = 1, no = 2))
  expect_equal(class(to_character(x)), "character")
  expect_equal(to_character(x), c("yes", "yes", "no"))
})


test_that("to_character preserves variable label", {
  x <- labelled(c(1, 1, 2), c(yes = 1, no = 2))
  var_label(x) <- "yes/no"
  expect_equal(var_label(to_character(x)), var_label(x))
})


# set_value_labels and add_value_labels ----------------------------------------------

test_that("set_value_labels replaces all value labels", {
  df <- data.frame(s1 = c("M", "M", "F"), s2 = c(1, 1, 2), stringsAsFactors = FALSE)
  df <- set_value_labels(df, s1 = c(Male = "M", Female = "F"), s2 = c(Yes = 1, No = 2))
  expect_equal(val_labels(df$s1), c(Male = "M", Female = "F"))
  expect_equal(val_labels(df$s2), c(Yes = 1, No = 2))
  df <- set_value_labels(df, s2 = c(Yes = 1, Unknown = 9))
  expect_equal(val_labels(df$s2), c(Yes = 1, Unknown = 9))
})

test_that("add_value_labels and remove_value_labels updates the list of value labels", {
  df <- data.frame(s1 = c("M", "M", "F"), s2 = c(1, 1, 2), stringsAsFactors = FALSE)
  df <- set_value_labels(df, s1 = c(Male = "M", Female = "F"), s2 = c(Yesss = 1, No = 2))
  df <- add_value_labels(df, s2 = c(Yes = 1, Unknown = 9))
  expect_equal(val_labels(df$s2), c(Yes = 1, No = 2, Unknown = 9))
  df <- remove_value_labels(df, s2 = 9)
  expect_equal(val_labels(df$s2), c(Yes = 1, No = 2))
})

# set_variable_labels  --------------------------------------------------------------

test_that("set_variable_labels updates variable labels", {
  df <- data.frame(s1 = c("M", "M", "F"), s2 = c(1, 1, 2), stringsAsFactors = FALSE)
  df <- set_variable_labels(df, s1 = "Sex", s2 = "Question")
  expect_equal(var_label(df$s1), "Sex")
  df <- set_variable_labels(df, s2 = NULL)
  expect_null(var_label(df$s2))
})
