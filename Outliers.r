options(scipen=999)

#### ex: outliers exist
getwd()
d = read.csv("Taxi.csv",header=TRUE)	

dim(d)

## Plot Data(understand relationship)
plot(d$distance, d$fare)	## show relationship


## Divide Data

n = length(d$fare)	
n

train = sample(1:n,.7*n,replace=FALSE)	## choose 70% of data randomly
test = setdiff(1:n,train)			## what's left after choosing 70%

dtrn = d[train,]					## generate two data subsets
dtst = d[test,]

plot(dtrn$distance,dtrn$fare)	## show relationship

plot(dtst$distance,dtst$fare) ## because the training set is too large


## Method 1: Ignore

## Plot Training Set Data


fit1 = lm(dtrn$fare ~ dtrn$distance)			
summary(fit1)

## Method 2a: Remove outliers by Trimming/Percentile method 

q = quantile(dtrn$fare,c(.01,.99))
LB=q[1]
UB=q[2]

u = dtrn[which(dtrn$fare>=LB & dtrn$fare<=UB),]	## new dataset excluding outliers

fit2 = lm(u$fare ~ u$distance)
summary(fit2)


## Method 2b: Remove outliers by Trimming/IQR method

q = quantile(dtrn$fare,c(.25,.5,.75))
LB = q[1]-1.5*(q[3]-q[1])
UB = q[3]+1.5*(q[3]-q[1])


q = quantile(dtrn$fare,c(.25,.75))
LB = q[1]-1.5*(q[2]-q[1])
UB = q[2]+1.5*(q[2]-q[1])


t = dtrn[which(dtrn$fare>=LB & dtrn$fare<=UB),]	## new dataset excluding outliers

fit3 = lm(t$fare ~ t$distance)
summary(fit3)


## Method 3a: Reassigning outliers by Winsorizing/Percentile method 

q = quantile(dtrn$fare,c(.01,.99))
LB=q[1]
UB=q[2]

dtrn$fare[which(dtrn$fare<LB)] = LB		## new dataset, reassigning
dtrn$fare[which(dtrn$fare>UB)] = UB

fit4 = lm(dtrn$fare ~ dtrn$distance)
summary(fit4)


## Method 3b: Reassigning outliers by Winsorizing/Percentile method 

q = quantile(dtrn$fare,c(.25,.75))
LB = q[1]-1.5*(q[2]-q[1])
UB = q[2]+1.5*(q[2]-q[1])

dtrn$fare[which(dtrn$fare<LB)] = LB		## new dataset, reassigning
dtrn$fare[which(dtrn$fare>UB)] = UB

fit5 = lm(dtrn$fare ~ dtrn$distance)
summary(fit5)


## Compare Error Distributions

x = dtst$distance					

tstactual=dtst$fare

tstpred1 = fit1$coef[1] + fit1$coef[2]*x		## keep outliers
tstresid1 = tstactual - tstpred1
				
tstpred2 = fit2$coef[1] + fit2$coef[2]*x	## trim 1% on each side
tstresid2 = tstactual - tstpred2

tstpred3 = fit3$coef[1] + fit3$coef[2]*x	## IQR method
tstresid3 = tstactual - tstpred3

tstpred4 = fit4$coef[1] + fit4$coef[2]*x		## winsorize 1% on each side
tstresid4 = tstactual - tstpred4

tstpred5 = fit5$coef[1] + fit5$coef[2]*x		## winsorize 1% on each side
tstresid5 = tstactual - tstpred5


mean(abs(tstresid1))
mean(abs(tstresid2))
mean(abs(tstresid3))
mean(abs(tstresid4))
mean(abs(tstresid5))



