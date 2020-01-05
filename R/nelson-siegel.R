#' Beta_1 Regressor
#'
#' @param maturity A number. Should be represented as years, e.g. 3 months = 0.25 years.
#' @param lambda A number between 0 and 1. Defaults to 0.4 as is given by the Academy's generator.
#'
#' @return A numeric vector giving the Beta_1 regressor for the Nelson-Siegel Yield Curve interpolation.
#' @export
#'
#' @examples
#' beta1_regressor(1)
#' beta1_regressor(1,0.5)
#' beta1_regressor(c(1,20))
beta1_regressor <- function(maturity, lambda=0.4){
  (1-exp(-lambda*maturity))/(lambda*maturity)  
}

#' Nelson-Siegel Regressors
#'
#' @param maturities A number or numeric vector. Should be represented as years, e.g. 3 months = 0.25 years.
#'
#' @return A matrix with length as number of maturities of Nelson-Siegel regressors.
#' @export
#'
#' @examples
#' ns_regressors(c(0.25,0.5,1,5,10,20,30))
ns_regressors <- function(maturities){
  cbind(1, beta1_regressor(maturities))
}

#' Get Nelson-Siegel Factors
#'
#' The AIRG assumes a short rate maturity of one year and a long rate maturity of twenty years.
#'
#' @param short_rate The one year interest rate.
#' @param long_rate The twenty year interest rate.
#'
#' @return b_0 and b_1 factors are calculated by solving A*x=b for x.
#' @export
#'
#' @examples
#' get_factors(0.0263,0.0287)
fit_parameters <- function(b,A){
  solve(A, b)
}

#' Get Rates
#'
#' @param factors A matrix.
#' @param regressors A matrix.
#'
#' @return A matrix of interest rates
#' @export
#'
#' @examples
#' get_rates(matrix(c(0.029128892,-0.003432289),nrow=2),matrix(c(1,1,0.8241999,0.1249581),nrow=2))
interpolate_rates <- function(factors, regressors){
  regressors %*% factors
}