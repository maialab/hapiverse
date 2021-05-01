core <- c("gwasrapidd", "quincunx")

#' hapiverse packages
#'
#' This function returns the packages that are part of the hapiverse. Contrast
#' with \code{\link[hapiverse]{hapiverse_dependencies}}, which returns all
#' package dependencies.
#'
#' @return A character vector of the names of packages included in the hapiverse.
#'
#' @export
hapiverse_packages <- function() {
  core
}

core_unattached <- function() {
  search <- paste0("package:", core)
  core[!search %in% search()]
}

# Attach the package from the same package library it was
# loaded from before. https://github.com/tidyverse/tidyverse/issues/171
same_library <- function(pkg) {
  loc <- if (pkg %in% loadedNamespaces()) dirname(getNamespaceInfo(pkg, "path"))
  do.call(
    "library",
    list(pkg, lib.loc = loc, character.only = TRUE, warn.conflicts = FALSE)
  )
}

hapiverse_attach <- function() {
  to_load <- core_unattached()
  if (length(to_load) == 0)
    return(invisible())

  msg(
    cli::rule(
      left = crayon::bold("Attaching packages"),
      right = paste0("hapiverse ", package_version("hapiverse"))
    ),
    startup = TRUE
  )

  versions <- vapply(to_load, package_version, character(1))
  packages <- paste0(
    crayon::green(cli::symbol$tick), " ", crayon::blue(format(to_load)), " ",
    crayon::col_align(versions, max(crayon::col_nchar(versions)))
  )

  if (length(packages) %% 2 == 1) {
    packages <- append(packages, "")
  }
  col1 <- seq_len(length(packages) / 2)
  info <- paste0(packages[col1], "     ", packages[-col1])

  msg(paste(info, collapse = "\n"), startup = TRUE)

  suppressPackageStartupMessages(
    lapply(to_load, same_library)
  )

  invisible()
}

#' Pretty package version string
#'
#' This function takes the name of a package, finds its version, and generates a
#' string where the fourth and subsequent fields are coloured in red (uses the
#' crayon package).
#'
#' @param x The name of an installed package, a character string. NB: the
#'   function is not vectorised on this argument.
#'
#' @return A stylised character string of the package version.
#' @keywords internal
package_version <- function(x) {
  version <- as.character(unclass(utils::packageVersion(x))[[1]])

  if (length(version) > 3) {
    version[4:length(version)] <- crayon::red(as.character(version[4:length(version)]))
  }
  paste0(version, collapse = ".")
}
