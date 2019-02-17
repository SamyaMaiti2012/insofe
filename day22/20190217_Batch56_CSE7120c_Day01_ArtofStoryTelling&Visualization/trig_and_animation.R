# 
library(tidyverse)
library(plotly)
tibble(x = -360:360,
           sinx = sin(x*pi/180),
           cosx = cos(x*pi/180)) %>%
  gather(-1,key = trig,value = value) %>% 
  ggplot(aes(x = x, y = value)) + 
  geom_line() +
  geom_vline(xintercept = c(-360,-270,-180,-90,0,90, 180,270,360), color = "red") + 
  facet_wrap(~ trig, ncol = 1) + 
  theme_grey() -> viz 

viz %>% ggplotly()
