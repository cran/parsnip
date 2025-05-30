% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bag_mlp_nnet.R
\name{details_bag_mlp_nnet}
\alias{details_bag_mlp_nnet}
\title{Bagged neural networks via nnet}
\description{
\code{\link[baguette:bagger]{baguette::bagger()}} creates a collection of neural networks forming an
ensemble. All trees in the ensemble are combined to produce a final prediction.
}
\details{
For this engine, there are multiple modes: classification and regression
\subsection{Tuning Parameters}{

This model has 3 tuning parameters:
\itemize{
\item \code{hidden_units}: # Hidden Units (type: integer, default: 10L)
\item \code{penalty}: Amount of Regularization (type: double, default: 0.0)
\item \code{epochs}: # Epochs (type: integer, default: 1000L)
}

These defaults are set by the \code{baguette} package and are different than
those in \code{\link[nnet:nnet]{nnet::nnet()}}.
}

\subsection{Translation from parsnip to the original package (classification)}{

The \strong{baguette} extension package is required to fit this model.

\if{html}{\out{<div class="sourceCode r">}}\preformatted{library(baguette)

bag_mlp(penalty = double(1), hidden_units = integer(1)) |> 
  set_engine("nnet") |> 
  set_mode("classification") |> 
  translate()
}\if{html}{\out{</div>}}

\if{html}{\out{<div class="sourceCode">}}\preformatted{## Bagged Neural Network Model Specification (classification)
## 
## Main Arguments:
##   hidden_units = integer(1)
##   penalty = double(1)
## 
## Computational engine: nnet 
## 
## Model fit template:
## baguette::bagger(formula = missing_arg(), data = missing_arg(), 
##     weights = missing_arg(), size = integer(1), decay = double(1), 
##     base_model = "nnet")
}\if{html}{\out{</div>}}
}

\subsection{Translation from parsnip to the original package (regression)}{

The \strong{baguette} extension package is required to fit this model.

\if{html}{\out{<div class="sourceCode r">}}\preformatted{library(baguette)

bag_mlp(penalty = double(1), hidden_units = integer(1)) |> 
  set_engine("nnet") |> 
  set_mode("regression") |> 
  translate()
}\if{html}{\out{</div>}}

\if{html}{\out{<div class="sourceCode">}}\preformatted{## Bagged Neural Network Model Specification (regression)
## 
## Main Arguments:
##   hidden_units = integer(1)
##   penalty = double(1)
## 
## Computational engine: nnet 
## 
## Model fit template:
## baguette::bagger(formula = missing_arg(), data = missing_arg(), 
##     weights = missing_arg(), size = integer(1), decay = double(1), 
##     base_model = "nnet")
}\if{html}{\out{</div>}}
}

\subsection{Preprocessing requirements}{

Factor/categorical predictors need to be converted to numeric values
(e.g., dummy or indicator variables) for this engine. When using the
formula method via \code{\link[=fit.model_spec]{fit()}}, parsnip will
convert factor columns to indicators.

Predictors should have the same scale. One way to achieve this is to
center and scale each so that each predictor has mean zero and a
variance of one.
}

\subsection{Case weights}{

The underlying model implementation does not allow for case weights.
}

\subsection{References}{
\itemize{
\item Breiman L. 1996. “Bagging predictors”. Machine Learning. 24 (2):
123-140
\item Kuhn, M, and K Johnson. 2013. \emph{Applied Predictive Modeling}. Springer.
}
}
}
\keyword{internal}
