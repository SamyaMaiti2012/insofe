library(gapminder)
library(gganimate)

# source : https://github.com/thomasp85/gganimate

gapminder %>% 
ggplot(aes(x = gdpPercap,
           y = lifeExp, 
           size = pop, 
           colour = country)) +
  geom_point(alpha = 0.7, show.legend = FALSE) +
  scale_colour_manual(values = country_colors) +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  facet_wrap(~continent) +
  # Here comes the gganimate specific bits
  labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy') +
  transition_time(year) +
  ease_aes('linear')

anim_save("gapminder_animation.gif", animation = last_animation(), width = 11, height = 8, unit = "in")
