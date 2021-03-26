library(tidyverse)

mpg

ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg)

dim(mpg)

?mpg

ggplot(data = mpg) +
    geom_point(mapping = aes(x = cyl, y = hwy))

ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, color = class))

ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy, size = class))

ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy, shape = class))

ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
    facet_wrap(~ class, nrow = 2)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
    facet_grid(drv ~ cyl)

ggplot(data = mpg) + 
    geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) + 
    geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))
              
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))
    
ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = FALSE)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
    geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
    geom_smooth()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
    geom_smooth()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
    geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
    geom_smooth(se = FALSE)

ggplot(data = diamonds) + 
    geom_bar(mapping = aes(x = cut))

ggplot(data = diamonds) + 
    stat_count(mapping = aes(x = cut))

ggplot(data = diamonds) + 
    geom_bar(mapping = aes(x = cut, y = stat(prop), group = 1))

ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )

ggplot(data = diamonds) + 
  stat_summary(mapping = aes(x = cut, y = depth))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut))
ggplot(data = diamonds) + 
    geom_bar(mapping = aes(x = cut, fill = cut))

ggplot(data = diamonds) + 
    geom_bar(mapping = aes(x = cut, fill = clarity))

ggplot(data = diamonds) + 
    geom_bar(mapping = aes(x = cut, fill = clarity),
             position = "fill")

ggplot(data = diamonds) + 
    geom_bar(mapping = aes(x = cut, fill = clarity),
             position = "dodge")

ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy),
               position = "jitter")

ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot()
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
    coord_flip()

nz <- map_data("nz")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap()

bar <- ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar()

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() + 
  geom_abline() +
  coord_fixed()
