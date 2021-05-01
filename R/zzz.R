.onAttach <- function(...) {
  needed <- core[!is_attached(core)]
  if (length(needed) == 0)
    return()

  crayon::num_colors(TRUE)
  hapiverse_attach()

  x <- hapiverse_conflicts()
  msg(hapiverse_conflict_message(x), startup = TRUE)

  if (!"package:conflicted" %in% search()) {
    same_library('conflicted')
  }

}

is_attached <- function(x) {
  paste0("package:", x) %in% search()
}
