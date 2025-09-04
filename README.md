# Simple Regression and Causal Inference

While correlation is symmetric, regression is not, even with one predictor.
Let’s consider regressing y on x: 
 y =  𝛼 + 𝛽.x + 𝜀

And regressing x on y: 
 x = 𝛾 + 𝛿.y + 𝜂

Since  𝛽 = Cov(x,y) / Var(x) 
, and  𝛿 = Cov(x,y) / Var(y) 
, hence  𝛽.𝛿 =  𝜌² 
, which means  𝛽 ≠ 1/𝛿  unless x and y are perfectly correlated ( 𝜌 = 1). 

However, the p-values for 𝛽 and 𝛿 are the same. This is because the t-statistic depends only on the correlation (𝜌) and the sample size (n): 

 t = 𝜌 . sqrt(n-2) / sqrt(1- 𝜌²)

Moreover, since R² = 𝜌² and F = t² , they also remain unchanged between the regressions. 

This means that if one regression finds a significant relationship, so will the other. This results in equivalent hypothesis testing outcomes, which allows flexibility in model setup in exploratory research when you are not sure which variable is dependent and which is independent. (By "allows", I mean you may get away with it!)

Nevertheless, when adding control or other independent variables, the choice of which variable to regress on the others becomes crucial. The decision is no longer arbitrary because it should be based on which variable’s variance can be explained by the others. This should be determined by the underlying plausible causal relationships and temporal precedence among the variables. 

Temporal precedence is necessary (but not sufficient) for causal inference. It refers to the logical ordering of events, where the cause must precede the effect. The variables believed to cause the effect should be treated as the independent variables. 

For example, it would be appropriate to regress income on demographic factors like age and gender to test if demographics can explain the variance in income in a population. That is because demographic characteristics are plausible antecedents (causes) for income. But income cannot plausibly influence a person’s gender unless you are studying particularly expensive surgeries! 
