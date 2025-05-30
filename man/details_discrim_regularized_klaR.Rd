% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/discrim_regularized_klaR.R
\name{details_discrim_regularized_klaR}
\alias{details_discrim_regularized_klaR}
\title{Regularized discriminant analysis via klaR}
\description{
\code{\link[klaR:rda]{klaR::rda()}} fits a a model that estimates a multivariate
distribution for the predictors separately for the data in each class. The
structure of the model can be LDA, QDA, or some amalgam of the two. Bayes'
theorem is used to compute the probability of each class, given the
predictor values.
}
\details{
For this engine, there is a single mode: classification
\subsection{Tuning Parameters}{

This model has 2 tuning parameter:
\itemize{
\item \code{frac_common_cov}: Fraction of the Common Covariance Matrix (type:
double, default: (see below))
\item \code{frac_identity}: Fraction of the Identity Matrix (type: double,
default: (see below))
}

Some special cases for the RDA model:
\itemize{
\item \code{frac_identity = 0} and \code{frac_common_cov = 1} is a linear discriminant
analysis (LDA) model.
\item \code{frac_identity = 0} and \code{frac_common_cov = 0} is a quadratic
discriminant analysis (QDA) model.
}
}

\subsection{Translation from parsnip to the original package}{

The \strong{discrim} extension package is required to fit this model.

\if{html}{\out{<div class="sourceCode r">}}\preformatted{library(discrim)

discrim_regularized(frac_identity = numeric(0), frac_common_cov = numeric(0)) |> 
  set_engine("klaR") |> 
  translate()
}\if{html}{\out{</div>}}

\if{html}{\out{<div class="sourceCode">}}\preformatted{## Regularized Discriminant Model Specification (classification)
## 
## Main Arguments:
##   frac_common_cov = numeric(0)
##   frac_identity = numeric(0)
## 
## Computational engine: klaR 
## 
## Model fit template:
## klaR::rda(formula = missing_arg(), data = missing_arg(), lambda = numeric(0), 
##     gamma = numeric(0))
}\if{html}{\out{</div>}}
}

\subsection{Preprocessing requirements}{

Factor/categorical predictors need to be converted to numeric values
(e.g., dummy or indicator variables) for this engine. When using the
formula method via \code{\link[=fit.model_spec]{fit()}}, parsnip will
convert factor columns to indicators.

Variance calculations are used in these computations within each outcome
class. For this reason, \emph{zero-variance} predictors (i.e., with a single
unique value) within each class should be eliminated before fitting the
model.
}

\subsection{Case weights}{

The underlying model implementation does not allow for case weights.
}

\subsection{References}{
\itemize{
\item Friedman, J (1989). Regularized Discriminant Analysis. \emph{Journal of the
American Statistical Association}, 84, 165-175.
\item Kuhn, M, and K Johnson. 2013. \emph{Applied Predictive Modeling}. Springer.
}
}
}
\keyword{internal}
