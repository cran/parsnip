% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/linear_reg_lmer.R
\name{details_linear_reg_lmer}
\alias{details_linear_reg_lmer}
\title{Linear regression via mixed models}
\description{
The \code{"lmer"} engine estimates fixed and random effect regression parameters
using maximum likelihood (or restricted maximum likelihood) estimation.
}
\details{
For this engine, there is a single mode: regression
\subsection{Tuning Parameters}{

This model has no tuning parameters.
}

\subsection{Translation from parsnip to the original package}{

The \strong{multilevelmod} extension package is required to fit this model.

\if{html}{\out{<div class="sourceCode r">}}\preformatted{library(multilevelmod)

linear_reg() |> 
  set_engine("lmer") |> 
  set_mode("regression") |> 
  translate()
}\if{html}{\out{</div>}}

\if{html}{\out{<div class="sourceCode">}}\preformatted{## Linear Regression Model Specification (regression)
## 
## Computational engine: lmer 
## 
## Model fit template:
## lme4::lmer(formula = missing_arg(), data = missing_arg(), weights = missing_arg())
}\if{html}{\out{</div>}}
}

\subsection{Predicting new samples}{

This model can use subject-specific coefficient estimates to make
predictions (i.e. partial pooling). For example, this equation shows the
linear predictor (\verb{\eta}) for a random intercept:

\if{html}{\out{<div class="sourceCode">}}\preformatted{\eta_\{i\} = (\beta_0 + b_\{0i\}) + \beta_1x_\{i1\}
}\if{html}{\out{</div>}}

where \code{i} denotes the \code{i}th independent experimental unit
(e.g. subject). When the model has seen subject \code{i}, it can use that
subject’s data to adjust the \emph{population} intercept to be more specific
to that subjects results.

What happens when data are being predicted for a subject that was not
used in the model fit? In that case, this package uses \emph{only} the
population parameter estimates for prediction:

\if{html}{\out{<div class="sourceCode">}}\preformatted{\hat\{\eta\}_\{i'\} = \hat\{\beta\}_0+ \hat\{\beta\}x_\{i'1\}
}\if{html}{\out{</div>}}

Depending on what covariates are in the model, this might have the
effect of making the same prediction for all new samples. The population
parameters are the “best estimate” for a subject that was not included
in the model fit.

The tidymodels framework deliberately constrains predictions for new
data to not use the training set or other data (to prevent information
leakage).
}

\subsection{Preprocessing requirements}{

There are no specific preprocessing needs. However, it is helpful to
keep the clustering/subject identifier column as factor or character
(instead of making them into dummy variables). See the examples in the
next section.
}

\subsection{Other details}{

The model can accept case weights.

With parsnip, we suggest using the formula method when fitting:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{library(tidymodels)
data("riesby")

linear_reg() |> 
  set_engine("lmer") |> 
  fit(depr_score ~ week + (1|subject), data = riesby)
}\if{html}{\out{</div>}}

When using tidymodels infrastructure, it may be better to use a
workflow. In this case, you can add the appropriate columns using
\code{add_variables()} then supply the typical formula when adding the model:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{library(tidymodels)

lmer_spec <- 
  linear_reg() |> 
  set_engine("lmer")

lmer_wflow <- 
  workflow() |> 
  # The data are included as-is using:
  add_variables(outcomes = depr_score, predictors = c(week, subject)) |> 
  add_model(lmer_spec, formula = depr_score ~ week + (1|subject))

fit(lmer_wflow, data = riesby)
}\if{html}{\out{</div>}}
}

\subsection{Case weights}{

This model can utilize case weights during model fitting. To use them,
see the documentation in \link{case_weights} and the examples
on \code{tidymodels.org}.

The \code{fit()} and \code{fit_xy()} arguments have arguments called
\code{case_weights} that expect vectors of case weights.
}

\subsection{References}{
\itemize{
\item J Pinheiro, and D Bates. 2000. \emph{Mixed-effects models in S and S-PLUS}.
Springer, New York, NY
\item West, K, Band Welch, and A Galecki. 2014. \emph{Linear Mixed Models: A
Practical Guide Using Statistical Software}. CRC Press.
\item Thorson, J, Minto, C. 2015, Mixed effects: a unifying framework for
statistical modelling in fisheries biology. \emph{ICES Journal of Marine
Science}, Volume 72, Issue 5, Pages 1245–1256.
\item Harrison, XA, Donaldson, L, Correa-Cano, ME, Evans, J, Fisher, DN,
Goodwin, CED, Robinson, BS, Hodgson, DJ, Inger, R. 2018. \emph{A brief
introduction to mixed effects modelling and multi-model inference in
ecology}. PeerJ 6:e4794.
\item DeBruine LM, Barr DJ. Understanding Mixed-Effects Models Through Data
Simulation. 2021. \emph{Advances in Methods and Practices in Psychological
Science}.
}
}
}
\keyword{internal}
