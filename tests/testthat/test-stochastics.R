context("Stochastics")

test_that("generate_stochastics gives errors", {
  expect_error(generate_stochastics())
  expect_error(generate_stochastics(0))
  expect_error(generate_stochastics(3,0))
})


test_that("correlate_stochastics gives errors", {
  stochastics <- matrix(rep(1,12),nrow=4)
  corr <- matrix(c(1,0,0,0,1,0,0,0,1), nrow = 9)
  
  expect_error(correlate_stochastics(stochastics,corr))
  
  stochastics <- matrix(rep(1,12),nrow=3)
  corr <- matrix(c(1,0,0,0,1,0,0,0,1), nrow = 3)
  
  expect_error(correlate_stochastics(stochastics,corr))
})