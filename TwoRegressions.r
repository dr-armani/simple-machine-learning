# Setting seed for reproducibility
set.seed(1)


# Model parameters
n <- 1000 # number of data points
rho <- 0.5  # underlying correlation between x and y
intercept <- 5  # true intercept for the y on x regression
slope <- 10  # true slope for the y on x regression


# Generate x from a normal distribution
x <- rnorm(n, mean = 0, sd = 1)

# Generate the error term so as to create the desired correlation
error <- rnorm(n, mean = 0, sd = slope*sqrt(1 / rho^2 - 1))

# Generate y as a function of the random numbers
y <- intercept + slope * x + error

# Estimate the correlation between x and y
rho_hat <- cor(x, y)
print(paste("Estimated correlation (rho):", rho_hat))

# Regress y on x
reg_y_on_x <- lm(y ~ x)
summary(reg_y_on_x)

# Regress x on y
reg_x_on_y <- lm(x ~ y)
summary(reg_x_on_y)

# Scatter plot 
plot(x, y, main = "Scatter plot with Regression Lines",
     xlab = "x", ylab = "y", pch = 19, col = rgb(0.2, 0.4, 0.6, 0.4))

legend("topleft", legend = c("y on x", "x on y"),
       col = c("blue", "red"), lwd = 2)


# Add regression line for y on x
abline(reg_y_on_x, col = "blue", lwd = 2)

# Add regression line for x on y (inverted to match the original plot)
abline(a = -coef(reg_x_on_y)[1] / coef(reg_x_on_y)[2], 
       b = 1 / coef(reg_x_on_y)[2], col = "red", lwd = 2)
