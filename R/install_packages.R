install_engine_packages <- function(extension = TRUE, extras = TRUE,
                                    ignore_pkgs = c("stats", "liquidSVM",
                                                    "parsnip")) {
  bio_pkgs <- c()

  if (extension) {
    extensions_packages <- extensions()
    repositories <- glue::glue("tidymodels/{extensions_packages}")

    remotes::install_github(repositories)

    extensions_packages <- extensions()
    purrr::walk(extensions_packages, library, character.only = TRUE)
    bio_pkgs <- c(bio_pkgs, "mixOmics")
  }

  engine_packages <- purrr::map(
    ls(envir = get_model_env(), pattern = "_pkgs$"),
    get_from_env
  ) %>%
    purrr::list_rbind() %>%
    dplyr::pull(pkg) %>%
    unlist() %>%
    unique() %>%
    setdiff(ignore_pkgs) %>%
    setdiff(bio_pkgs)

  if (extension) {
    engine_packages <- setdiff(engine_packages, extensions_packages)
  }

  if (extras) {
    rmd_pkgs <- c("tidymodels", "broom.mixed", "glmnet", "Cubist", "xrf", "ape",
                  "rmarkdown")
    engine_packages <- unique(c(engine_packages, rmd_pkgs))
  }

  remotes::install_cran(engine_packages)

  remotes::install_bioc(bio_pkgs)
}
