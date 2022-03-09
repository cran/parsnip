#' Ensembles of decision trees
#'
#' @description
#'
#' `bag_tree()` defines an ensemble of decision trees. This function can fit
#'  classification, regression, and censored regression models.
#'
#' \Sexpr[stage=render,results=rd]{parsnip:::make_engine_list("bag_tree")}
#'
#' More information on how \pkg{parsnip} is used for modeling is at
#' \url{https://www.tidymodels.org/}.
#'
#' @inheritParams decision_tree
#' @param class_cost A non-negative scalar for a class cost (where a cost of 1
#' means no extra cost). This is useful for when the first level of the outcome
#' factor is the minority class. If this is not the case, values between zero
#' and one can be used to bias to the second level of the factor.
#'
#' @template spec-details
#'
#' @template spec-references
#'
#' @seealso \Sexpr[stage=render,results=rd]{parsnip:::make_seealso_list("bag_tree")}
#' @export
bag_tree <-
  function(mode = "unknown",
           cost_complexity = 0,
           tree_depth = NULL,
           min_n = 2,
           class_cost = NULL,
           engine = "rpart") {
    args <- list(
      cost_complexity   = enquo(cost_complexity),
      tree_depth  = enquo(tree_depth),
      min_n  = enquo(min_n),
      class_cost = enquo(class_cost)
    )

    new_model_spec(
      "bag_tree",
      args = args,
      eng_args = NULL,
      mode = mode,
      method = NULL,
      engine = engine
    )
  }

#' @export
print.bag_tree <- function(x, ...) {
  cat("Bagged Decision Tree Model Specification (", x$mode, ")\n\n", sep = "")
  model_printer(x, ...)

  if (!is.null(x$method$fit$args)) {
    cat("Model fit template:\n")
    print(show_call(x))
  }
  invisible(x)
}

# ------------------------------------------------------------------------------

#' @method update bag_tree
#' @rdname parsnip_update
#' @inheritParams decision_tree
#' @inheritParams bag_tree
#' @export
update.bag_tree <-
  function(object,
           parameters = NULL,
           cost_complexity = NULL, tree_depth = NULL, min_n = NULL,
           class_cost = NULL,
           fresh = FALSE, ...) {
    update_dot_check(...)

    if (!is.null(parameters)) {
      parameters <- check_final_param(parameters)
    }
    args <- list(
      cost_complexity   = enquo(cost_complexity),
      tree_depth  = enquo(tree_depth),
      min_n  = enquo(min_n),
      class_cost = enquo(class_cost)
    )

    args <- update_main_parameters(args, parameters)

    if (fresh) {
      object$args <- args
    } else {
      null_args <- map_lgl(args, null_value)
      if (any(null_args))
        args <- args[!null_args]
      if (length(args) > 0)
        object$args[names(args)] <- args
    }

    new_model_spec(
      "bag_tree",
      args = object$args,
      eng_args = object$eng_args,
      mode = object$mode,
      method = NULL,
      engine = object$engine
    )
  }


# ------------------------------------------------------------------------------

check_args.bag_tree <- function(object) {
  if (object$engine == "C5.0" && object$mode == "regression")
    stop("C5.0 is classification only.", call. = FALSE)
  invisible(object)
}


# ------------------------------------------------------------------------------

set_new_model("bag_tree")
set_model_mode("bag_tree", "classification")
set_model_mode("bag_tree", "regression")
set_model_mode("bag_tree", "censored regression")