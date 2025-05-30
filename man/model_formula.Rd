% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/model_formula.R
\name{model_formula}
\alias{model_formula}
\title{Formulas with special terms in tidymodels}
\description{
In R, formulas provide a compact, symbolic notation to specify model terms.
Many modeling functions in R make use of \link[stats:terms.formula]{"specials"},
or nonstandard notations used in formulas. Specials are defined and handled as
a special case by a given modeling package. For example, the mgcv package,
which provides support for
\link[=gen_additive_mod]{generalized additive models} in R, defines a
function \code{s()} to be in-lined into formulas. It can be used like so:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{mgcv::gam(mpg ~ wt + s(disp, k = 5), data = mtcars)
}\if{html}{\out{</div>}}

In this example, the \code{s()} special defines a smoothing term that the mgcv
package knows to look for when preprocessing model input.

The parsnip package can handle most specials without issue. The analogous
code for specifying this generalized additive model
\link[=details_gen_additive_mod_mgcv]{with the parsnip "mgcv" engine}
looks like:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{gen_additive_mod() |>
  set_mode("regression") |>
  set_engine("mgcv") |>
  fit(mpg ~ wt + s(disp, k = 5), data = mtcars)
}\if{html}{\out{</div>}}

However, parsnip is often used in conjunction with the greater tidymodels
package ecosystem, which defines its own pre-processing infrastructure and
functionality via packages like hardhat and recipes. The specials defined
in many modeling packages introduce conflicts with that infrastructure.

To support specials while also maintaining consistent syntax elsewhere in
the ecosystem, \strong{tidymodels delineates between two types of formulas:
preprocessing formulas and model formulas}. Preprocessing formulas specify
the input variables, while model formulas determine the model structure.
}
\section{Example}{


To create the preprocessing formula from the model formula, just remove
the specials, retaining references to input variables themselves. For example:

\if{html}{\out{<div class="sourceCode">}}\preformatted{model_formula <- mpg ~ wt + s(disp, k = 5)
preproc_formula <- mpg ~ wt + disp
}\if{html}{\out{</div>}}

\itemize{
\item \strong{With parsnip,} use the model formula:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{model_spec <-
  gen_additive_mod() |>
  set_mode("regression") |>
  set_engine("mgcv")

model_spec |>
  fit(model_formula, data = mtcars)
}\if{html}{\out{</div>}}

\item \strong{With recipes}, use the preprocessing formula only:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{library(recipes)

recipe(preproc_formula, mtcars)
}\if{html}{\out{</div>}}

The recipes package supplies a large variety of preprocessing techniques
that may replace the need for specials altogether, in some cases.

\item \strong{With workflows,} use the preprocessing formula everywhere, but
pass the model formula to the \code{formula} argument in \code{add_model()}:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{library(workflows)

wflow <-
  workflow() |>
  add_formula(preproc_formula) |>
  add_model(model_spec, formula = model_formula)

fit(wflow, data = mtcars)
}\if{html}{\out{</div>}}

The workflow will then pass the model formula to parsnip, using the
preprocessor formula elsewhere. We would still use the preprocessing
formula if we had added a recipe preprocessor using \code{add_recipe()}
instead a formula via \code{add_formula()}.

}
}

