% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/svm_poly_kernlab.R
\name{details_svm_poly_kernlab}
\alias{details_svm_poly_kernlab}
\title{Polynomial support vector machines (SVMs) via kernlab}
\description{
\code{\link[kernlab:ksvm]{kernlab::ksvm()}} fits a support vector machine model. For classification,
the model tries to maximize the width of the margin between classes.
For regression, the model optimizes a robust loss function that is only
affected by very large model residuals.
}
\details{
For this engine, there are multiple modes: classification and regression
\subsection{Tuning Parameters}{

This model has 4 tuning parameters:
\itemize{
\item \code{cost}: Cost (type: double, default: 1.0)
\item \code{degree}: Degree of Interaction (type: integer, default: 1L1)
\item \code{scale_factor}: Scale Factor (type: double, default: 1.0)
\item \code{margin}: Insensitivity Margin (type: double, default: 0.1)
}

Parsnip changes the default range for \code{cost} to \code{c(-10, 5)}.
}

\subsection{Translation from parsnip to the original package (regression)}{

\if{html}{\out{<div class="sourceCode r">}}\preformatted{svm_poly(
  cost = double(1),
  degree = integer(1),
  scale_factor = double(1), 
  margin = double(1)
) |>  
  set_engine("kernlab") |> 
  set_mode("regression") |> 
  translate()
}\if{html}{\out{</div>}}

\if{html}{\out{<div class="sourceCode">}}\preformatted{## Polynomial Support Vector Machine Model Specification (regression)
## 
## Main Arguments:
##   cost = double(1)
##   degree = integer(1)
##   scale_factor = double(1)
##   margin = double(1)
## 
## Computational engine: kernlab 
## 
## Model fit template:
## kernlab::ksvm(x = missing_arg(), data = missing_arg(), C = double(1), 
##     epsilon = double(1), kernel = "polydot", kpar = list(degree = ~integer(1), 
##         scale = ~double(1)))
}\if{html}{\out{</div>}}
}

\subsection{Translation from parsnip to the original package (classification)}{

\if{html}{\out{<div class="sourceCode r">}}\preformatted{svm_poly(
  cost = double(1),
  degree = integer(1),
  scale_factor = double(1)
) |> 
  set_engine("kernlab") |> 
  set_mode("classification") |> 
  translate()
}\if{html}{\out{</div>}}

\if{html}{\out{<div class="sourceCode">}}\preformatted{## Polynomial Support Vector Machine Model Specification (classification)
## 
## Main Arguments:
##   cost = double(1)
##   degree = integer(1)
##   scale_factor = double(1)
## 
## Computational engine: kernlab 
## 
## Model fit template:
## kernlab::ksvm(x = missing_arg(), data = missing_arg(), C = double(1), 
##     kernel = "polydot", prob.model = TRUE, kpar = list(degree = ~integer(1), 
##         scale = ~double(1)))
}\if{html}{\out{</div>}}

The \code{margin} parameter does not apply to classification models.

Note that the \code{"kernlab"} engine does not naturally estimate class
probabilities. To produce them, the decision values of the model are
converted to probabilities using Platt scaling. This method fits an
additional model on top of the SVM model. When fitting the Platt scaling
model, random numbers are used that are not reproducible or controlled
by R’s random number stream.
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

\subsection{Examples}{

The “Fitting and Predicting with parsnip” article contains
\href{https://parsnip.tidymodels.org/articles/articles/Examples.html#svm-poly-kernlab}{examples}
for \code{svm_poly()} with the \code{"kernlab"} engine.
}

\subsection{Saving fitted model objects}{

This model object contains data that are not required to make
predictions. When saving the model for the purpose of prediction, the
size of the saved object might be substantially reduced by using
functions from the \href{https://butcher.tidymodels.org}{butcher} package.
}

\subsection{References}{
\itemize{
\item Lin, HT, and R Weng. \href{https://www.csie.ntu.edu.tw/~cjlin/papers/plattprob.pdf}{“A Note on Platt’s Probabilistic Outputs for Support Vector Machines”}
\item Karatzoglou, A, Smola, A, Hornik, K, and A Zeileis. 2004. \href{https://www.jstatsoft.org/article/view/v011i09}{“kernlab - An S4 Package for Kernel Methods in R.”}, \emph{Journal of
Statistical Software}.
\item Kuhn, M, and K Johnson. 2013. \emph{Applied Predictive Modeling}. Springer.
}
}
}
\keyword{internal}
