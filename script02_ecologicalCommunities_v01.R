########################################################################################################
# install libraries (only once on your computer)
install.packages("codep")

# load libraries (every time you open a new R session)
library(codep) # contains the ecological data we'll be exploring

# load the ecological data; composed of three matrices
data(Doubs)

# have a look at each matrix
Doubs.fish # counts of 27 species collected at 30 sites
Doubs.env  # 9 in-stream environmental variables measured at 30 sites
Doubs.geo  # 4 geographic variables measured at 30 sites

#note that these are matrices and not dataframes... what does this mean?
is.matrix(Doubs.fish)
is.data.frame(Doubs.fish)

# for simplicity let's convert the count data to presence-absence data
Doubs.fish.PA <- ifelse(Doubs.fish > 0, 1, 0)

# The site by species matrix is a fundamental dataset in ecology; answer basic questions about biodiversity
# 1) Which species are common and which are rare?
incidence <- apply(Doubs.fish.PA, 2, sum)
incidence
sort(incidence)
hist(incidence)              # visualize with a histogram
hist(incidence, breaks = 10) # visualize with a histogram

# 2) How many species occur in one place versus another?
richness <- apply(Doubs.fish.PA, 1, sum)
richness
summary(richness)            # summarize numerically
hist(richness)               # visualize with a histogram
hist(richness, breaks = 10)  # visualize with a histogram

# 3) How does the environment affect species richness?
# first, combine all three datasets
Doubs.all <- data.frame(Doubs.geo, Doubs.env, richness)

# visualize a few bivariate relationships
plot(Doubs.all$Alt, Doubs.all$richness)  # elevation
plot(Doubs.all$flo, Doubs.all$richness)  # discharge
plot(Doubs.all$pH, Doubs.all$richness)   # pH

# quantify the relationships using correlation analyses
cor(Doubs.all$Alt, Doubs.all$richness)   # elevation
cor(Doubs.all$flo, Doubs.all$richness)   # discharge
cor(Doubs.all$pH, Doubs.all$richness)    # pH

########################################################################################################
########################################################################################################
########################################################################################################
# install libraries (only once on your computer)
install.packages("ggplot2")

# load libraries (every time you open a new R session)
library(ggplot2)

########################################################################################################
# make publication-quality plot
plot_01 <- ggplot(NULL) + 
  theme_bw() +
  labs(x = "Meters above sea level",      # customize your axis labels
       y = "Number of species") +         # customize your axis labels
  geom_point(aes(x = Alt, y = richness),  Doubs.all, size = 3, shape = 16, alpha = 0.5) +
  geom_smooth(aes(x = Alt, y = richness), Doubs.all, method = "lm")

print(plot_01)

# save as a high-resolution jpeg
ggsave("<<YOUR_DIRECTORY_HERE>>plot_01.jpg",
       plot = plot_01,
       width = 5.00,
       height = 3.25,
       units = "in",
       dpi = 600)

########################################################################################################
# copy and paste the above ggplot code chunk here;
# plot relationship between *flow* and richness

########################################################################################################
# copy and paste the above ggplot code chunk here;
# plot relationship between *pH* and richness

########################################################################################################
# There are *many* other ways to quantify biodiversity patterns
# See open-source book: Numerical Ecology with R
# https://link.springer.com/content/pdf/10.1007%2F978-1-4419-7976-6.pdf
