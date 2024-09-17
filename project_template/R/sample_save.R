set.seed(123)
n <- 100
x <- rnorm(n)
y <- 2 * x + rnorm(n)

sim <- data.frame(x = x, y = y)
plot <- ggplot(sim, aes(x = x, y = y)) +
    geom_point() +
    geom_smooth(method = "lm", col = "red") +
    theme_minimal()

model <- lm(y ~ x, data = sim)
table <- stargazer(model, type = "latex")

save_plot(plot, "sample_figure")
save_model(model, "sample_model")
save_table(table, "sample_table")