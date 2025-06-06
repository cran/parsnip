% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/boost_tree_h2o.R
\name{details_boost_tree_h2o}
\alias{details_boost_tree_h2o}
\title{Boosted trees via h2o}
\description{
\code{\link[h2o:h2o.xgboost]{h2o::h2o.xgboost()}} creates a series of decision trees
forming an ensemble. Each tree depends on the results of previous trees.
All trees in the ensemble are combined to produce a final prediction.
}
\details{
For this engine, there are multiple modes: classification and regression
\subsection{Tuning Parameters}{

This model has 8 tuning parameters:
\itemize{
\item \code{trees}: # Trees (type: integer, default: 50)
\item \code{tree_depth}: Tree Depth (type: integer, default: 6)
\item \code{min_n}: Minimal Node Size (type: integer, default: 1)
\item \code{learn_rate}: Learning Rate (type: double, default: 0.3)
\item \code{sample_size}: # Observations Sampled (type: integer, default: 1)
\item \code{mtry}: # Randomly Selected Predictors (type: integer, default: 1)
\item \code{loss_reduction}: Minimum Loss Reduction (type: double, default: 0)
\item \code{stop_iter}: # Iterations Before Stopping (type: integer, default: 0)
}

\code{min_n} represents the fewest allowed observations in a terminal node,
\code{\link[h2o:h2o.xgboost]{h2o::h2o.xgboost()}} allows only one row in a leaf
by default.

\code{stop_iter} controls early stopping rounds based on the convergence of
the engine parameter \code{stopping_metric}. By default,
\code{\link[h2o:h2o.xgboost]{h2o::h2o.xgboost()}} does not use early stopping.
When \code{stop_iter} is not 0, \code{\link[h2o:h2o.xgboost]{h2o::h2o.xgboost()}}
uses logloss for classification, deviance for regression and anonomaly
score for Isolation Forest. This is mostly useful when used alongside
the engine parameter \code{validation}, which is the \strong{proportion} of
train-validation split, parsnip will split and pass the two data frames
to h2o. Then \code{\link[h2o:h2o.xgboost]{h2o::h2o.xgboost()}} will evaluate
the metric and early stopping criteria on the validation set.
}

\subsection{Translation from parsnip to the original package (regression)}{

\code{\link[agua:h2o_train]{agua::h2o_train_xgboost()}} is a wrapper
around \code{\link[h2o:h2o.xgboost]{h2o::h2o.xgboost()}}.

The \strong{agua} extension package is required to fit this model.

\if{html}{\out{<div class="sourceCode r">}}\preformatted{boost_tree(
  mtry = integer(), trees = integer(), tree_depth = integer(), 
  learn_rate = numeric(), min_n = integer(), loss_reduction = numeric(), stop_iter = integer()
) |>
  set_engine("h2o") |>
  set_mode("regression") |>
  translate()
}\if{html}{\out{</div>}}

\if{html}{\out{<div class="sourceCode">}}\preformatted{## Boosted Tree Model Specification (regression)
## 
## Main Arguments:
##   mtry = integer()
##   trees = integer()
##   min_n = integer()
##   tree_depth = integer()
##   learn_rate = numeric()
##   loss_reduction = numeric()
##   stop_iter = integer()
## 
## Computational engine: h2o 
## 
## Model fit template:
## agua::h2o_train_xgboost(x = missing_arg(), y = missing_arg(), 
##     weights = missing_arg(), validation_frame = missing_arg(), 
##     col_sample_rate = integer(), ntrees = integer(), min_rows = integer(), 
##     max_depth = integer(), learn_rate = numeric(), min_split_improvement = numeric(), 
##     stopping_rounds = integer())
}\if{html}{\out{</div>}}
}

\subsection{Translation from parsnip to the original package (classification)}{

The \strong{agua} extension package is required to fit this model.

\if{html}{\out{<div class="sourceCode r">}}\preformatted{boost_tree(
  mtry = integer(), trees = integer(), tree_depth = integer(), 
  learn_rate = numeric(), min_n = integer(), loss_reduction = numeric(), stop_iter = integer()
) |> 
  set_engine("h2o") |> 
  set_mode("classification") |> 
  translate()
}\if{html}{\out{</div>}}

\if{html}{\out{<div class="sourceCode">}}\preformatted{## Boosted Tree Model Specification (classification)
## 
## Main Arguments:
##   mtry = integer()
##   trees = integer()
##   min_n = integer()
##   tree_depth = integer()
##   learn_rate = numeric()
##   loss_reduction = numeric()
##   stop_iter = integer()
## 
## Computational engine: h2o 
## 
## Model fit template:
## agua::h2o_train_xgboost(x = missing_arg(), y = missing_arg(), 
##     weights = missing_arg(), validation_frame = missing_arg(), 
##     col_sample_rate = integer(), ntrees = integer(), min_rows = integer(), 
##     max_depth = integer(), learn_rate = numeric(), min_split_improvement = numeric(), 
##     stopping_rounds = integer())
}\if{html}{\out{</div>}}
}

\subsection{Preprocessing}{

This engine does not require any special encoding of the predictors.
Categorical predictors can be partitioned into groups of factor levels
(e.g. \verb{\{a, c\}} vs \verb{\{b, d\}}) when splitting at a node. Dummy variables
are not required for this model.

Non-numeric predictors (i.e., factors) are internally converted to
numeric. In the classification context, non-numeric outcomes (i.e.,
factors) are also internally converted to numeric.
}

\subsection{Interpreting \code{mtry}}{

The \code{mtry} argument denotes the number of predictors that will be
randomly sampled at each split when creating tree models.

Some engines, such as \code{"xgboost"}, \code{"xrf"}, and \code{"lightgbm"}, interpret
their analogue to the \code{mtry} argument as the \emph{proportion} of predictors
that will be randomly sampled at each split rather than the \emph{count}. In
some settings, such as when tuning over preprocessors that influence the
number of predictors, this parameterization is quite
helpful—interpreting \code{mtry} as a proportion means that \verb{[0, 1]} is
always a valid range for that parameter, regardless of input data.

parsnip and its extensions accommodate this parameterization using the
\code{counts} argument: a logical indicating whether \code{mtry} should be
interpreted as the number of predictors that will be randomly sampled at
each split. \code{TRUE} indicates that \code{mtry} will be interpreted in its
sense as a count, \code{FALSE} indicates that the argument will be
interpreted in its sense as a proportion.

\code{mtry} is a main model argument for
\code{\link[=boost_tree]{boost_tree()}} and
\code{\link[=rand_forest]{rand_forest()}}, and thus should not have an
engine-specific interface. So, regardless of engine, \code{counts} defaults
to \code{TRUE}. For engines that support the proportion interpretation
(currently \code{"xgboost"} and \code{"xrf"}, via the rules package, and
\code{"lightgbm"} via the bonsai package) the user can pass the
\code{counts = FALSE} argument to \code{set_engine()} to supply \code{mtry} values
within \verb{[0, 1]}.
}

\subsection{Initializing h2o}{

To use the h2o engine with tidymodels, please run \code{h2o::h2o.init()}
first. By default, This connects R to the local h2o server. This needs
to be done in every new R session. You can also connect to a remote h2o
server with an IP address, for more details see
\code{\link[h2o:h2o.init]{h2o::h2o.init()}}.

You can control the number of threads in the thread pool used by h2o
with the \code{nthreads} argument. By default, it uses all CPUs on the host.
This is different from the usual parallel processing mechanism in
tidymodels for tuning, while tidymodels parallelizes over resamples, h2o
parallelizes over hyperparameter combinations for a given resample.

h2o will automatically shut down the local h2o instance started by R
when R is terminated. To manually stop the h2o server, run
\code{h2o::h2o.shutdown()}.
}

\subsection{Saving fitted model objects}{

Models fitted with this engine may require native serialization methods
to be properly saved and/or passed between R sessions. To learn more
about preparing fitted models for serialization, see the bundle package.
}
}
\keyword{internal}
