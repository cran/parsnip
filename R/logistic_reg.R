#' Logistic regression
#'
#' @description
#' [logistic_reg()] defines a generalized linear model for binary outcomes. A
#' linear combination of the predictors is used to model the log odds of an
#' event. This function can fit classification models.
#'
#' \Sexpr[stage=render,results=rd]{parsnip:::make_engine_list("logistic_reg")}
#'
#' More information on how \pkg{parsnip} is used for modeling is at
#' \url{https://www.tidymodels.org/}.
#'
#' @param mode A single character string for the type of model.
#'  The only possible value for this model is "classification".
#' @param engine A single character string specifying what computational engine
#'  to use for fitting. Possible engines are listed below. The default for this
#'  model is `"glm"`.
#' @param penalty A non-negative number representing the total
#'  amount of regularization (specific engines only).
#'  For `keras` models, this corresponds to purely L2 regularization
#'  (aka weight decay) while the other models can be either or a combination
#'  of L1 and L2 (depending on the value of `mixture`).
#' @param mixture A number between zero and one (inclusive) giving the
#'  proportion of L1 regularization (i.e. lasso) in the model.
#'
#'  * `mixture = 1` specifies a pure lasso model,
#'  * `mixture = 0`  specifies a ridge regression model, and
#'  * `0 < mixture < 1` specifies an elastic net model, interpolating lasso and ridge.
#'
#'  Available for specific engines only. For `LiblineaR` models, `mixture` must
#'  be exactly 1 or 0 only.
#'
#' @templateVar modeltype logistic_reg
#' @template spec-details
#'
#' @details This model fits a classification model for binary outcomes; for
#' multiclass outcomes, see [multinom_reg()].
#'
#' @template spec-references
#'
#' @seealso \Sexpr[stage=render,results=rd]{parsnip:::make_seealso_list("logistic_reg")}
#'
#' @examplesIf !parsnip:::is_cran_check()
#' show_engines("logistic_reg")
#'
#' logistic_reg()
#' @export
logistic_reg <-
  function(mode = "classification",
           engine = "glm",
           penalty = NULL,
           mixture = NULL) {

    args <- list(
      penalty = enquo(penalty),
      mixture = enquo(mixture)
    )

    new_model_spec(
      "logistic_reg",
      args = args,
      eng_args = NULL,
      mode = mode,
      user_specified_mode = !missing(mode),
      method = NULL,
      engine = engine,
      user_specified_engine = !missing(engine)
    )
  }

#' @export
translate.logistic_reg <- function(x, engine = x$engine, ...) {
  x <- translate.default(x, engine, ...)

  # slightly cleaner code using
  arg_vals <- x$method$fit$args
  arg_names <- names(arg_vals)

  if (engine == "glmnet") {
    # See https://parsnip.tidymodels.org/reference/glmnet-details.html
    .check_glmnet_penalty_fit(x)
    x <- set_glmnet_penalty_path(x)
    # Since the `fit` information is gone for the penalty, we need to have an
    # evaluated value for the parameter.
    x$args$penalty <- rlang::eval_tidy(x$args$penalty)
  }

  if (engine == "LiblineaR") {
    # convert parameter arguments
    new_penalty <- rlang::eval_tidy(x$args$penalty)
    if (is.numeric(new_penalty))
      arg_vals$cost <- rlang::new_quosure(1 / new_penalty, env = rlang::empty_env())

    if (any(arg_names == "type")) {
      if (is.numeric(quo_get_expr(arg_vals$type)))
        if (quo_get_expr(x$args$mixture) == 0) {
          arg_vals$type <- 0      ## ridge
        } else if (quo_get_expr(x$args$mixture) == 1) {
          arg_vals$type <- 6      ## lasso
        } else {
          rlang::abort("For the LiblineaR engine, mixture must be 0 or 1.")
        }
    }
    x$method$fit$args <- arg_vals
  }
  x
}

# ------------------------------------------------------------------------------

#' @method update logistic_reg
#' @rdname parsnip_update
#' @export
update.logistic_reg <-
  function(object,
           parameters = NULL,
           penalty = NULL, mixture = NULL,
           fresh = FALSE, ...) {

    args <- list(
      penalty = enquo(penalty),
      mixture = enquo(mixture)
    )

    update_spec(
      object = object,
      parameters = parameters,
      args_enquo_list = args,
      fresh = fresh,
      cls = "logistic_reg",
      ...
    )
  }

# ------------------------------------------------------------------------------

#' @export
check_args.logistic_reg <- function(object) {

  args <- lapply(object$args, rlang::eval_tidy)

  if (all(is.numeric(args$penalty)) && any(args$penalty < 0))
    rlang::abort("The amount of regularization should be >= 0.")
  if (is.numeric(args$mixture) && (args$mixture < 0 | args$mixture > 1))
    rlang::abort("The mixture proportion should be within [0,1].")
  if (is.numeric(args$mixture) && length(args$mixture) > 1)
    rlang::abort("Only one value of `mixture` is allowed.")

  if (object$engine == "LiblineaR") {
    if(is.numeric(args$mixture) && !args$mixture %in% 0:1)
      rlang::abort(c("For the LiblineaR engine, mixture must be 0 or 1.",
                     "Choose a pure ridge model with `mixture = 0`.",
                     "Choose a pure lasso model with `mixture = 1`.",
                     "The Liblinear engine does not support other values."))
    if(all(is.numeric(args$penalty)) && !all(args$penalty > 0))
      rlang::abort("For the LiblineaR engine, penalty must be > 0.")
  }

  invisible(object)
}

# ------------------------------------------------------------------------------

prob_to_class_2 <- function(x, object) {
  x <- ifelse(x >= 0.5, object$lvl[2], object$lvl[1])
  unname(x)
}

# ------------------------------------------------------------------------------

liblinear_preds <- function(results, object) {
  results$predictions
}

liblinear_probs <- function(results, object) {
  as_tibble(results$probabilities)
}
