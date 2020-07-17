#' @export
notes <- function() {
 
  check_xfun()

  remote_file <- "https://r-workshop.mindsci.net/Archive.zip"
  dest_file <- file.path(find.package("teachingtools"), "notes/Archive.zip")
  notes_dir <- file.path(find.package("teachingtools"), "notes")
  if (dir.exists(notes_dir)) unlink(notes_dir, recursive = T)

  dir.create(notes_dir)

  download.file(
    url = remote_file,
    dest = dest_file
  )

  xfun::pkg_attach2("servr")
  unzip(zipfile = dest_file, exdir = notes_dir)

  ifelse(length(servr::daemon_list()) == 0, 1, servr::daemon_stop(servr::daemon_list()))

  servr::httd(notes_dir)
}



check_xfun <- function() {
  installed_packages <- utils::installed.packages()

  check_package <- function(x) {
    x == "xfun"
  }
  has_xfun <- sum(unlist(base::lapply(installed_packages, FUN = check_package)), na.rm = T)
  if (!has_xfun) {
    install.packages("xfun")
  }
}
