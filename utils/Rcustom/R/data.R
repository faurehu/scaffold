get_proj_data <- function() {
    file_list <- list.files(path = get_data_path(), pattern = "\\.csv$", full.names = TRUE)
    data_csv_path <- get_data_path("data", ".csv")

    if (data_csv_path %in% file_list) {
        df <- read.csv(data_csv_path)
    } else if (length(file_list) == 1) {
        df <- read.csv(file_list[1])
    } else {
        df_list <- list()
        for (file in file_list) {
            df <- read.csv(file)
            # TODO: Convert the list into a dict to get filenames.
            df_list <- append(df_list, list(df))
        }
        df_list
    }
}