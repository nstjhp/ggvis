#' Modify a ggvis layer object by adding new components
#'
#' This operator lets you add objects to a ggvis layer object.
#'
#' You can add the following types of objects to a layer object:
#' \itemize{
#'   \item \code{mark}
#'   \item \code{layer}
#'   \item \code{scale}
#'   \item \code{guide_legend}
#'   \item \code{guide_axis}
#'   \item \code{props}
#'   \item \code{opts}
#' }
#'
#' @param e1 A layer object.
#' @param e2 Another object, of a type listed above.
#'
#' @export
`+.layer` <- function(e1, e2){
  e2name <- deparse(substitute(e2))

  # Separate function is needed for S3 dispatch - providing methods for the +
  # operator doesn't work if an object is a match for more than one method.
  ggvis_add(e1, e2, e2name)
}


ggvis_add <- function(e1, e2, e2name) UseMethod("ggvis_add")

#' @export
ggvis_add.ggvis <- function(e1, e2, e2name) {

  # Bare list: recurse over children
  if (is.list(e2) && !is.object(e2)) {
    return(Reduce(ggvis_add, e2, init = e1))
  }

  type <- component_type(e2)

  # Top-level ggvis objects can add many kinds of objects
  switch(type,
    children = e1$children <- c(e1$children, list(e2)),
    scales   = e1$scales <- scales(.scales = c(e1$scales, list(e2))),
    legends  = e1$legends <- c(e1$legends, list(e2)),
    axes     = e1$axes <- c(e1$axes, list(e2)),
    props    = e1$props <- merge_props(e1$props, e2),
    opts     = e1$opts <- list(merge_opts(e1$opts[[1]], e2)),
    handlers = e1$handlers <- c(e1$handlers, list(e2)),
    stop("Don't know how to add object ", e2name, " of type ", type,
      " to ggvis object.")
  )
  e1
}

#' @export
ggvis_add.mark <- function(e1, e2, e2name) {
  type <- component_type(e2)

  # Mark objects can only add props
  switch(type,
    props = e1$props <- merge_props(e1$props, e2),
    stop("Don't know how to add object ", e2name, " of type ", type,
      " to mark object.")
  )
  e1
}

#' @export
ggvis_add.layer <- function(e1, e2, e2name) {
  type <- component_type(e2)

  # Layer objects can add children and props
  switch(type,
    children = e1$children <- c(e1$children, list(e2)),
    props    = e1$props <- merge_props(e1$props, e2),
    stop("Don't know how to add object ", e2name, " of type ", type,
      " to layer object.")
  )
  e1
}
