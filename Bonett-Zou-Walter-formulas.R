

# Calculating sample size for reliability studies
# Paper formulas
# Feb, 2022

#### Inputs
k = 2 # Number of repeats
p = 0.9 # The anticipated *true* intraclass correlation coefficient
z = 1.96 # Alpha level
z2 = 0.84 # Assurance or power
w = 0.1 # Entire width of the confidence interval
pnull = 0.8 # Null intraclass correlation coefficient

#### Estimation approach
# Bonnet (2002)
nb = 1+(8*z**2*(1-p)**2*(1+(k-1)*p)**2)/(k*(k-1)*w**2)
round(ifelse(k==2 & p>=0.7, nb+5*p, nb), digits = 0)

# Zou (2012)
num = 2*(z*(1-p)*(1+(k-1)*p) + sqrt(z**2*(1-p)**2*(1+(k-1)*p)**2+2*w*z*z2*(1-p)*(1+(k-1)*p)*abs((k-2+2*p-2*k*p))))**2
den = k*(k-1)*w**2
nz = 1+num/den
round(nz, digits = 0)

#### Hypothesis testing approach
# Walter (1998)
num = (2*k*(z+z2)**2)
null = pnull/(1-pnull)
alt = p/(1-p)
den = (log((1+k*null)/(1+k*alt)))**2
nw = 1+num/((k-1)*den)
round(nw, digits = 0)



#### End

