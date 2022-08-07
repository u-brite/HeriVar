library(ggplot2)

# read in results from pc analysis
data <- read.table("pc_results.eigenvec", header = FALSE)
head(data)
ggplot(data, aes(x = V2, y = V3)) + geom_point()

# read in ethnicity labels for data
data2 <- read.table("integrated_call_samples_v3.20130502.ALL.panel",
    header = TRUE)
head(data2)

# combine analysis results and labels
data3 <- merge(data, data2, by.x = "V1", by.y = "sample")
head(data3)

# for aesthetics
theme_set(theme_bw())

# plot pc1 vs pc2
# columns from data are misaligned, so V2 column actually corresponds to V1
ggplot(data3, aes(x = V2, y = V3, color = super_pop)) +
    geom_point(alpha = .5) +
    labs(x = "Principal Component 1", y = "Principal Component 2") +
    theme(legend.title = element_blank())
ggsave("pc1_vs_pc2.png", dpi = 600, width = 5, height = 5)

# plot pc1 vs pc3
ggplot(data3, aes(x = V2, y = V4, color = super_pop)) +
    geom_point(alpha = .5) +
    labs(x = "Principal Component 1", y = "Principal Component 3") +
    theme(legend.title = element_blank())
ggsave("pc1_vs_pc3.png", dpi = 600, width = 5, height = 5)

# includes subpopulations, didn't use
ggplot(data3, aes(x = V2, y = V3, color = pop, shape = super_pop)) +
    geom_point() +
    labs(x = "Principal Component 1", y = "Principal Component 2") +
    theme(legend.title = element_blank())
