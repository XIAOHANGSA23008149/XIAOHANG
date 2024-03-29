# pak_info.R

# Check if tidyverse is installed and install if not
if (!require(tidyverse)) {
  install.packages("tidyverse")
  library(tidyverse)
} else {
  message("tidyverse is already installed.")
}

# Access a package's functions
# Example: View a brief description of the ggplot2 function from the tidyverse
help(package = "ggplot2")

# Get help on a specific function
# Example: Get help on the ggplot function from ggplot2
?ggplot

# You can also use help() function
# help(ggplot)

# To list all functions in tidyverse, uncomment the line below
# ls("package:tidyverse")