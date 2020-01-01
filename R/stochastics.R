#' Generate Stochastics
#'
#' @param months An integer of the number of projection months.
#' @param processes Defaults to three stochastic processes.
#'
#' @return An MxN matrix of stochastic random variables
#' @export
#'
#' @examples
#' generate_stochastics(3,360)
generate_stochastics <- function(months, processes=3){
  matrix(rnorm(processes * months), nrow = months, ncol = processes)
}

#' Correlate Stochastics
#'
#' @param stochastics 
#' @param correlation 
#'
#' @return A correlated MxN matrix of stochastic random variables
#' @export
#'
correlate_stochastics <- function(stochastics, correlation){
  stochastics %*% chol(correlation)
}