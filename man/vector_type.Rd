\name{vector_type}
\alias{vector_type}
\title{Determine the "type" of a vector}
\usage{
vector_type(x)
}
\arguments{
  \item{x}{a vector}
}
\description{
The \code{vector_type} collapses down the class of base
vectors into something useful more for visualisation,
yielding one of "datetime", "numeric", "ordinal", "nominal"
or "logical".
}
\seealso{
\code{default_scale}, which uses this when picking the
default scale.
}

