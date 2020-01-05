#' Generate Stochastics
#'
#' @importFrom stats rnorm
#'
#' @param months An integer of the number of projection months.
#' @param processes Defaults to three stochastic processes.
#'
#' @return An MxN matrix of stochastic random variables where M = months and N = processes
#' @export
#'
#' @examples
#' generate_stochastics(360,3)
generate_stochastics <- function(months, processes=3){
  if (months < 1) stop(paste0("The number of projection months must be greater than 0; Not ",months,"."), call. = FALSE) 
  if (processes < 1) stop(paste0("The number of stochastic processes must be greater than 0; Not ",processes,"."), call. = FALSE) 
  
  Matrix::Matrix(rnorm(processes * months), nrow = processes)
}

#' Correlate Stochastics
#' 
#' Takes an MxN matrix A of randomly generated values and multiplies by the cholesky of an NxN matrix X, a correlation matrix.
#'
#' @param stochastics A matrix
#' @param correlation A square matrix with size the number of processes in the stochastic matrix.
#'
#' @return A MxN matrix of correlated stochastic random variables
#' @export
#'
correlate_stochastics <- function(stochastics, correlation){
  stochastics <- as.matrix(stochastics)
  correlation <- as.matrix(correlation)
  
  if (nrow(stochastics) != nrow(correlation)) stop("correlation must have the same number of columns as stochastic processes.")
  if (nrow(correlation) != ncol(correlation)) stop("correlation must be a square matrix.")
  
  correlation %*% stochastics
}