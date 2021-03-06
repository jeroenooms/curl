.onLoad <- function(libname, pkgname){
  if (!grepl("mingw", R.Version()$platform))
    return()

  # Enable SSL on Windows if CA bundle is available (R >= 3.2.0)
  bundle <- Sys.getenv("CURL_CA_BUNDLE",
    file.path(R.home("etc"), "curl-ca-bundle.crt"))
  if (bundle != "" && file.exists(bundle)) {
    set_bundle(bundle)
  }
}

.onAttach <- function(libname, pkgname){
  if (grepl("mingw", R.Version()$platform) && !file.exists(get_bundle())){
    warning("No CA bundle found. SSL validation disabled.", call. = FALSE)
  }
  ssl <- sub("\\(.*\\)\\W*", "", curl_version()$ssl_version)
  msg <- paste("Using libcurl", curl_version()$version, "with", ssl)
  packageStartupMessage(msg)
}

#' @useDynLib curl R_set_bundle
set_bundle <- function(path){
  .Call(R_set_bundle, path)
}

#' @useDynLib curl R_get_bundle
get_bundle <- function(){
  .Call(R_get_bundle)
}
