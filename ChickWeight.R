
library(lme4)
library(nlme)

data(ChickWeight)
head(ChickWeight)

grouped <- groupedData(weight ~ Time | Chick, ChickWeight)
plot(grouped, outer=~Diet, par.settings = list(superpose.symbol = list(col = NA)))

ggplot(ChickWeight, aes(x = Time, y = weight, group = Chick, color = factor(Diet))) +
  geom_line() +
  geom_point(pch=1) +
  facet_wrap(~Diet,
             nrow=1,
             labeller = labeller(Diet = function(x) paste0("Diet ", x))) +
  theme(legend.position = "none") +  # Remove legend
  labs(x = "Time (days)", y = "Weight (grams)", title = "Chick Weight Growth by Diet")
ggsave("website_projects/ChickWeight_analysis/figures/plot_growthbydiet.png",
       width=12, height=4)


table(ChickWeight$Diet)
table(ChickWeight$Time)
table(ChickWeight$Time, ChickWeight$Diet)

model <- lmer(weight ~ Time + Diet + (1 | Chick), data = ChickWeight)
summary(model)
