# package management script

# install R packages for packaging
# install.packages(c("devtools", "usethis", "roxygen2"))
library(usethis)
library(devtools)
library(roxygen2)
library(desc)

# install.packages(c("momentchi2", "fields", "viridis", "signal", "fossil"))
library(momentchi2)
library(fields)
library(viridis)
library(signal)
library(fossil)

# ignored files
use_build_ignore(c("packageManagementScript.R", "EBA-master", "fEBA-main", "mEBA-main"))

# add author and manager

# add Dr. Bruce
use_author(
  given = "Scott",
  family = "Bruce",
  role = c("aut", "cre"),
  email = "sabruce@tamu.edu"
)

# add Matt Byrom
use_author(
  given = "Matt",
  family = "Byrom",
  role = c("cre"),
  email = "matthew.james.byrom@tamu.edu"
)

# add Dylan Ward
use_author(
  given = "Dylan",
  family = "Ward",
  role = c("cre"),
)

# add Mohit Chhaparia
use_author(
  given = "Mohit",
  family = "Chhaparia",
  role = c("cre"),
)

# add GPL 3 liscense
usethis::use_gpl3_license()
usethis::use_mit_license()

# create cpp infrastructure




# package dependencies for EBA
usethis::use_package("momentchi2", type = "Imports")
usethis::use_package("fields", type = "Imports")
usethis::use_package("viridis", type = "Imports")
usethis::use_package("signal", type = "Imports")
usethis::use_package("fossil", type = "Imports")


