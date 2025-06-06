


For this engine, there is a single mode: classification

## Tuning Parameters

This model has no tuning parameters.

## Translation from parsnip to the original package

The **multilevelmod** extension package is required to fit this model.


``` r
library(multilevelmod)

logistic_reg() |> 
  set_engine("glmer") |> 
  translate()
```

```
## Logistic Regression Model Specification (classification)
## 
## Computational engine: glmer 
## 
## Model fit template:
## lme4::glmer(formula = missing_arg(), data = missing_arg(), weights = missing_arg(), 
##     family = binomial)
```


## Predicting new samples

This model can use subject-specific coefficient estimates to make predictions (i.e. partial pooling). For example, this equation shows the linear predictor (`\eta`) for a random intercept: 

```
\eta_{i} = (\beta_0 + b_{0i}) + \beta_1x_{i1}
```

where `i` denotes the `i`th independent experimental unit (e.g. subject). When the model has seen subject `i`, it can use that subject's data to adjust the _population_ intercept to be more specific to that subjects results. 

What happens when data are being predicted for a subject that was not used in the model fit? In that case, this package uses _only_ the population parameter estimates for prediction: 

```
\hat{\eta}_{i'} = \hat{\beta}_0+ \hat{\beta}x_{i'1}
```

Depending on what covariates are in the model, this might have the effect of making the same prediction for all new samples. The population parameters are the "best estimate" for a subject that was not included in the model fit.  

The tidymodels framework deliberately constrains predictions for new data to not use the training set or other data (to prevent information leakage). 


## Preprocessing requirements

There are no specific preprocessing needs. However, it is helpful to keep the clustering/subject identifier column as factor or character (instead of making them into dummy variables). See the examples in the next section. 

## Other details

The model can accept case weights. 

With parsnip, we suggest using the formula method when fitting: 

```r
library(tidymodels)
data("toenail", package = "HSAUR3")

logistic_reg() |> 
  set_engine("glmer") |> 
  fit(outcome ~ treatment * visit + (1 | patientID), data = toenail)
```

When using tidymodels infrastructure, it may be better to use a workflow. In this case, you can add the appropriate columns using `add_variables()` then supply the typical formula when adding the model: 

```r
library(tidymodels)

glmer_spec <- 
  logistic_reg() |> 
  set_engine("glmer")

glmer_wflow <- 
  workflow() |> 
  # The data are included as-is using:
  add_variables(outcomes = outcome, predictors = c(treatment, visit, patientID)) |> 
  add_model(glmer_spec, formula = outcome ~ treatment * visit + (1 | patientID))

fit(glmer_wflow, data = toenail)
```

## Case weights


This model can utilize case weights during model fitting. To use them, see the documentation in [case_weights] and the examples on `tidymodels.org`. 

The `fit()` and `fit_xy()` arguments have arguments called `case_weights` that expect vectors of case weights. 

## References

 - 	J Pinheiro, and D Bates. 2000. _Mixed-effects models in S and S-PLUS_. Springer, New York, NY
 
 - West, K, Band Welch, and A Galecki. 2014. _Linear Mixed Models: A Practical Guide Using Statistical Software_. CRC Press.
 
  - Thorson, J, Minto, C. 2015, Mixed effects: a unifying framework for statistical modelling in fisheries biology. _ICES Journal of Marine Science_, Volume 72, Issue 5, Pages 1245–1256.
  
  - Harrison, XA, Donaldson, L, Correa-Cano, ME, Evans, J, Fisher, DN, Goodwin, CED, Robinson, BS, Hodgson, DJ, Inger, R. 2018. _A brief introduction to mixed effects modelling and multi-model inference in ecology_. PeerJ 6:e4794. 
  
  - DeBruine LM, Barr DJ. Understanding Mixed-Effects Models Through Data Simulation. 2021. _Advances in Methods and Practices in Psychological Science_.   
  
