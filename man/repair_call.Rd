% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/repair_call.R
\name{repair_call}
\alias{repair_call}
\title{Repair a model call object}
\usage{
repair_call(x, data)
}
\arguments{
\item{x}{A fitted parsnip model. An error will occur if the underlying model
does not have a \code{call} element.}

\item{data}{A data object that is relevant to the call. In most cases, this
is the data frame that was given to parsnip for the model fit (i.e., the
training set data). The name of this data object is inserted into the call.}
}
\value{
A modified \code{parsnip} fitted model.
}
\description{
When the user passes a formula to \code{fit()} \emph{and} the underlying model function
uses a formula, the call object produced by \code{fit()} may not be usable by
other functions. For example, some arguments may still be quosures and the
\code{data} portion of the call will not correspond to the original data.
}
\details{
\code{repair_call()} call can adjust the model objects call to be usable by other
functions and methods.
}
\examples{
\dontshow{if (!parsnip:::is_cran_check()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}

fitted_model <-
  linear_reg() |>
  set_engine("lm", model = TRUE) |>
  fit(mpg ~ ., data = mtcars)

# In this call, note that `data` is not `mtcars` and the `model = ~TRUE`
# indicates that the `model` argument is an rlang quosure.
fitted_model$fit$call

# All better:
repair_call(fitted_model, mtcars)$fit$call
\dontshow{\}) # examplesIf}
}
