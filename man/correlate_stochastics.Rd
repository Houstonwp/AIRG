% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/stochastics.R
\name{correlate_stochastics}
\alias{correlate_stochastics}
\title{Correlate Stochastics}
\usage{
correlate_stochastics(stochastics, correlation)
}
\arguments{
\item{stochastics}{A matrix}

\item{correlation}{A square matrix with size the number of processes in the stochastic matrix.}
}
\value{
A MxN matrix of correlated stochastic random variables
}
\description{
Takes an MxN matrix A of randomly generated values and multiplies by the cholesky of an NxN matrix X, a correlation matrix.
}
