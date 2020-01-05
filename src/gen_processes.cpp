// Generate processes
#include <Rcpp.h>
using namespace Rcpp;

//' Generate processes.
//'
//' @return A matrix with rows; 1 = log of long rate, 2 = difference (long - short), 3 = log of long rate volatility
//'
//' @export
//'
// [[Rcpp::export]]
NumericMatrix generate_processes(const NumericMatrix N,
                            const double short_rate=0.0263,
                            const double long_rate=0.0287,
                             const double beta_i=0.00509,
                             const double beta_alpha=0.02685,
                             const double beta_nu=0.04001,
                             const double tau_i=0.0350,
                             const double tau_alpha=0.01,
                             const double tau_nu=0.0287,
                             const double sigma_i=0.0287,
                             const double sigma_alpha=0.04148,
                             const double sigma_nu=0.11489,
                             const double phi=0.0002,
                             const double psi=0.25164,
                             const double theta=1.0) {
  
  NumericMatrix z(3,N.cols() + 1);
  z(0,0) = log(long_rate);
  z(1,0) = long_rate  - short_rate;
  z(2,0) = log(sigma_i);
  for(int j = 1; j <= N.cols(); j++){
    z(2,j) = (1.0 - beta_nu) * z(2,j-1) + beta_nu * log(tau_nu) + sigma_nu * N(2,j-1);
    z(1,j) = (1.0 - beta_alpha) * z(1,j-1) + beta_alpha * tau_alpha + phi * (z(0,j-1) - log(tau_i)) + sigma_alpha * N(1,j-1) * pow(exp(z(0,j-1)),theta);
    z(0,j) = (1.0 - beta_i) * z(0,j-1) + beta_i * log(tau_i) + psi * (tau_alpha - z(1,j-1)) + N(0,j-1) * exp(z(2,j));
  }

  return z ;
}

//' Generate rates based on processes
//' 
//' @return A 2xn matrix with rows: 1 = short rate, 2 = long rate.
//'
//' @export
//'
// [[Rcpp::export]]
NumericMatrix generate_rates(const NumericMatrix N){
  NumericMatrix out(2,N.cols());
  
  for(int j=0;j<N.cols();j++){
    out(0,j) = exp(N(0,j)) - N(1,j);
    out(1,j) = exp(N(0,j));
  }
  
  return out;
}
