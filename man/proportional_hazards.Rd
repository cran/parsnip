% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/proportional_hazards.R
\name{proportional_hazards}
\alias{proportional_hazards}
\title{General Interface for Proportional Hazards Models}
\usage{
proportional_hazards(
  mode = "censored regression",
  penalty = NULL,
  mixture = NULL
)
}
\arguments{
\item{mode}{A single character string for the type of model.
Possible values for this model are "unknown", or "censored regression".}

\item{penalty}{A non-negative number representing the total
amount of regularization (\code{glmnet}, \code{keras}, and \code{spark} only).
For \code{keras} models, this corresponds to purely L2 regularization
(aka weight decay) while the other models can be a combination
of L1 and L2 (depending on the value of \code{mixture}; see below).}

\item{mixture}{A number between zero and one (inclusive) that is the
proportion of L1 regularization (i.e. lasso) in the model. When
\code{mixture = 1}, it is a pure lasso model while \code{mixture = 0} indicates that
ridge regression is being used. (\code{glmnet} and \code{spark} only).}
}
\description{
\code{proportional_hazards()} is a way to generate a \emph{specification} of a model
before fitting and allows the model to be created using different packages
in R. The main arguments for the model are:
\itemize{
\item \code{penalty}: The total amount of regularization
in the model. Note that this must be zero for some engines.
\item \code{mixture}: The mixture amounts of different types of
regularization (see below). Note that this will be ignored for some engines.
}
These arguments are converted to their specific names at the
time that the model is fit. Other options and arguments can be
set using \code{set_engine()}. If left to their defaults
here (\code{NULL}), the values are taken from the underlying model
functions. If parameters need to be modified, \code{update()} can be used
in lieu of recreating the object from scratch.
}
\details{
Proportional hazards models include the Cox model.
For \code{proportional_hazards()}, the mode will always be "censored regression".
}
\examples{
show_engines("proportional_hazards")
}
\seealso{
\code{\link[=fit]{fit()}}, \code{\link[=set_engine]{set_engine()}}, \code{\link[=update]{update()}}
}
\keyword{internal}
