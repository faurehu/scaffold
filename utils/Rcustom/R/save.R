save_plot <- function(plot, name) {
    ggsave(get_fig_path(name, ".pdf"), plot)
}

save_model <- function(model, name) {
    save(model, file = get_obj_path(name, ".RData"))
}

save_table <- function(table, name) {
    writeLines(table, get_tab_path(name, ".tex"))
}