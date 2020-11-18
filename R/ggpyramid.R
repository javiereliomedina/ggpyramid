#' Function for plotting population pyramids with ggplot2
#'
#' @param data    Data frame with population data by age and gender
#' @param age     Column with the age groups
#' @param pop     Column with population counts
#' @param gender  Column with gender data
#' @param men     How males are define in "gender" (default = "Men")
#' @param women   How females are defined in "gender" (default = "Women")
#' @param fill    Fill bars based on another variable (default = gender)
#'
#' @return population pyramid
#'
#' @examples
#' library(tidyverse)
#' library(ggpyramid)
#' library(danstat)
#'
#' # Load data from Denmark using (danstat)
#' var_input <- list(list(code = "OMRÅDE", values = "000"),
#'                   list(code = "KØN", values = c(1, 2)),
#'                   list(code = "ALDER", values = seq(0, 125, 1)),
#'                   list(code = "tid", values = "2020K4"))
#'
#' get_data("FOLK1A", variables = var_input) %>%
#'   rename(country = OMRÅDE,
#'          gender = KØN,
#'          age = ALDER,
#'          year = TID,
#'          pop = INDHOLD) %>%
#'   mutate(age = parse_number(age),
#'          age = as.integer(age)) -> df
#'
#' df %>%
#'   ggpyramid(pop = pop, fill = gender) +
#'   scale_fill_manual(name = "Gender", values = c("#0072B2", "#F0E442")) +
#'   labs(title = "Population pyramith of Denmark",
#'        caption = "Source: Statistics Denmark")
#'
#' @export

ggpyramid <- function(data = data,
                      age = age,
                      pop = pop,
                      gender = gender,
                      men = "Men",
                      women = "Women",
                      fill = gender) {
 ggplot() +
    geom_bar(data = subset( {{ data }}, {{ gender }} == women ),
             aes(x = {{ age }},
                 y = {{ pop }},
                 fill = {{ fill }}),
             stat = "identity",
             width = 1) +
    geom_bar(data = subset( {{ data }}, {{ gender }} == men ),
             aes(x = {{ age }},
                 y = - {{ pop }},
                 fill = {{ fill }}),
             stat = "identity",
             width = 1) +
    geom_hline(yintercept = 0, colour = "grey10") +
    scale_x_discrete(name = "Age") +
    coord_flip()
  }
