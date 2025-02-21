
library(lme4)

data(ChickWeight)
head(ChickWeight)

grouped <- groupedData(weight ~ Time | Chick, ChickWeight)
plot(grouped, outer=~Diet)

model <- lmer(weight ~ Time + Diet + (1 | Chick), data = ChickWeight)
summary(model)
