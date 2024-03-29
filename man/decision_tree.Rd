% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/decision_tree.R
\name{decision_tree}
\alias{decision_tree}
\title{Decision trees}
\usage{
decision_tree(
  mode = "unknown",
  engine = "rpart",
  cost_complexity = NULL,
  tree_depth = NULL,
  min_n = NULL
)
}
\arguments{
\item{mode}{A single character string for the prediction outcome mode.
Possible values for this model are "unknown", "regression",
"classification", or "censored regression".}

\item{engine}{A single character string specifying what computational engine
to use for fitting.}

\item{cost_complexity}{A positive number for the the cost/complexity
parameter (a.k.a. \code{Cp}) used by CART models (specific engines only).}

\item{tree_depth}{An integer for maximum depth of the tree.}

\item{min_n}{An integer for the minimum number of data points
in a node that are required for the node to be split further.}
}
\description{
\code{decision_tree()} defines a model as a set of \verb{if/then} statements that
creates a tree-based structure. This function can fit classification,
regression, and censored regression models.

\Sexpr[stage=render,results=rd]{parsnip:::make_engine_list("decision_tree")}

More information on how \pkg{parsnip} is used for modeling is at
\url{https://www.tidymodels.org/}.
}
\details{
This function only defines what \emph{type} of model is being fit. Once an engine
is specified, the \emph{method} to fit the model is also defined. See
\code{\link[=set_engine]{set_engine()}} for more on setting the engine, including how to set engine
arguments.

The model is not trained or fit until the \code{\link[=fit.model_spec]{fit()}} function is used
with the data.

Each of the arguments in this function other than \code{mode} and \code{engine} are
captured as \link[rlang:topic-quosure]{quosures}. To pass values
programmatically, use the \link[rlang:injection-operator]{injection operator} like so:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{value <- 1
decision_tree(argument = !!value)
}\if{html}{\out{</div>}}
}
\examples{
\dontshow{if (!parsnip:::is_cran_check()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
show_engines("decision_tree")

decision_tree(mode = "classification", tree_depth = 5)
\dontshow{\}) # examplesIf}
}
\references{
\url{https://www.tidymodels.org}, \href{https://www.tmwr.org/}{\emph{Tidy Modeling with R}}, \href{https://www.tidymodels.org/find/parsnip/}{searchable table of parsnip models}
}
\seealso{
\Sexpr[stage=render,results=rd]{parsnip:::make_seealso_list("decision_tree")}
}
