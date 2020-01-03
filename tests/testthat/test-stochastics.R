context("Stochastics")

test_that("generate_stochastics gives errors", {
  expect_error(generate_stochastics())
  expect_error(generate_stochastics(0))
  expect_error(generate_stochastics(3,0))
})


test_that("correlate_stochastics gives errors", {
  stochastics <- matrix(rep(1,12),nrow=3)
  corr <- matrix(c(1,0,0,0,1,0,0,0,1), nrow = 3)
  
  expect_error(correlate_stochastics(stochastics,corr))
  
  stochastics <- matrix(rep(1,12),nrow=4)
  corr <- matrix(c(1,0,0,0,1,0,0,0,1), nrow = 1)
  
  expect_error(correlate_stochastics(stochastics,corr))
})

test_that("generate_stochastics creates matrix", {
  tst <- generate_stochastics(4,3)
  
  expect_is(tst, "matrix")
  expect_equal(dim(tst)[1], 4)
  expect_equal(dim(tst)[2], 3)
  
  tst <- generate_stochastics(4)
  
  expect_is(tst, "matrix")
  expect_equal(dim(tst)[1], 4)
  expect_equal(dim(tst)[2], 3)
})

test_that("correlate_stochastics creates correlated matrix", {
  ones <- matrix(rep(1,9),nrow=3)
  corr <- matrix(c(1,0.5,0,0.5,1,0,0,0,1),nrow=3)
  
  expect_equal(correlate_stochastics(ones,corr), matrix(c(rep(1,3),rep(1.366025,3),rep(1,3)),nrow=3), tolerance=1e-06)
})