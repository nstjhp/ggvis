\name{input_checkbox}
\alias{input_checkbox}
\title{Create an interactive checkbox.}
\usage{
input_checkbox(value = FALSE, label = "", id = rand_id("checkbox_"),
  map = identity)
}
\arguments{
  \item{value}{Initial value (\code{TRUE} or
  \code{FALSE}).}

  \item{label}{Display label for the control.}

  \item{id}{a unique identifier for this interactive input
  - used to de-duplicate the controls when the same input
  is used in multiple places in a visualisation}

  \item{map}{a function with a singe argument that takes
  the value returned from the input control and converts it
  to an argument useful for ggvis.  Defaults to
  \code{identity}, leaving the output unchanged.}
}
\description{
Create an interactive checkbox.
}
\examples{
input_checkbox(label = "Confidence interval")
input_checkbox(label = "Confidence interval", value = TRUE)

# Used in a layer_smooth
layer_smooth(se = input_checkbox(label = "Confidence interval"))

# Used with a map function, to convert the boolean to another type of value
model_type <- input_checkbox(label = "Use flexible curve",
  map = function(val) if(val) "loess" else "lm")
layer_smooth(method = model_type)
}
\seealso{
Other interactive input: \code{\link{input_checkboxgroup}},
\code{\link{input_radiobuttons}},
\code{\link{input_select}}; \code{\link{input_numeric}},
\code{\link{input_text}}; \code{\link{input_slider}}
}

