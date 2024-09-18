effect_sizes <- seq(0.1, 1, by = 0.1)
ns <- seq(100, 1500, by = 100)

table <- expand.grid(effect_size = effect_sizes, n = ns) %>%
    mutate(
        powers = pwr.t.test(d = effect_size, n = n, sig.level = 0.05, power = NULL, type = "two.sample")$power
    )

ggplot(table, aes(x = effect_size, y = n, fill = powers)) +
    geom_tile() +
    scale_fill_gradient2(low = "red", mid = "yellow", high = "green", midpoint = 0.8, limits = c(0, 1)) +
    labs(title = "Power Analysis Heatmap", x = "Effect Size", y = "Sample Size (n)", fill = "Power") +
    theme_minimal()