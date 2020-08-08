plot(Rectum_mean_rel$relchange, DIL_mean_rel$relchange)

x_Rectum_mean_rel <- Rectum_mean_rel$relchange
y_DIL_mean_rel <- DIL_mean_rel$relchange

linearregression_rectum_DIL <- lm(y_DIL_mean_rel ~ x_Rectum_mean_rel)
lm(formula = y_DIL_mean_rel ~ x_Rectum_mean_rel)

fitted.values(linearregression_rectum_DIL)

residuals(linearregression_rectum_DIL)

summary(linearregression_rectum_DIL)

plot(x_Rectum_mean_rel, y_DIL_mean_rel)
abline(linearregression_rectum_DIL, col = "red")
