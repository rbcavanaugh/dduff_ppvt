# packages

library(shiny)
library(waiter)
library(ggplot2)
library(dplyr)
library(tidyr)
library(tibble)
library(faux)
library(shinipsum)


dat <- rnorm_multi(
  n = 100,
  mu = c(50, 0, 0),
  sd = c(10, 1, 1),
  r = c(.6, .5, .4),
  varnames = c("vocab_Est", "PPVT1", "PPVT2"),
  empirical = F,
)

mod <- lm(vocab_Est~PPVT1 + PPVT2,
          data = dat)

get_vocab_estimate <- function(values) {
  
 pred =  
   as_tibble(
   predict(
          object = mod,
          interval = "confidence",
          newdata = tibble(
            PPVT1 = values$subtest1,
            PPVT2 = values$subtest2
          )
            )
   ) %>%
   mutate(
     sd = (upr-fit)/2
   )
  
 return(pred)
  
  
}


get_vocab_plot <- function(preds){
  
  tmp <- preds
  p = tibble(
    x= rnorm(
        500,
        mean = tmp$fit,
        sd = tmp$sd
        ),
    ) %>%
    ggplot(aes(x = x)) +
    geom_density(fill = "blue", alpha = .3, adjust = 3) +
    theme_minimal(base_size = 16) +
    scale_x_continuous(breaks = seq(20,80,10), labels = seq(20,80,10), limits = c(20,80)) +
    labs(x = "Outcome variable")

  return(p)
    
}

