#############################################################################
#############################################################################
#  Demo file for "Empirical Frequency Band Analysis of Nonstationary Time Series"
#  by Bruce, Tang, Hall, and Krafty (2019)
#
#  Author: Scott A. Bruce
#
#  Date: June 16, 2019
#
#  Description:
#  Simulates data corresponding to three time series processes described in the
#  paper (1: white noise (1 band), 2: linear time-varying dynamics (3 bands),
#  3: sinusoidal time-varying dynamics (3 bands)), conducts an empirical
#  frequency band analysis using the FRESH statistic and search algorithm,
#  and produces summary tables and plots of the results.
#############################################################################
#############################################################################

library(momentchi2)
library(fields)
library(viridis)
library(signal)
library(fossil)

###Select the script entitled ''EBA_functions.R'' when prompted below to load all necessary functions
source(file.choose())
# can probs take this out of the vingette since they will have to install and lib(pkg) to use the vingette
source("~/Bruce_Scott_Research /EBAtimeSeries/R/EBA-master/EBA_functions.R")

###Simulate data for all simulated data settings described in paper
set.seed(823819); #if you change the seed, you will get different results
T <- 50000; #total length of time series
X <- eba.simdata(T=T);

###Run search algorithm using FRESH statistic
##Input parameters
N <- 500; #number of observations per approximately stationary block
K <- 15; #number of tapers to use in multitaper spectral estimator
alpha <- 0.05; #significance level to use for testing partition points using FRESH statistic
std <- FALSE; #should the variance of each stationary block be set to one across all blocks? (TRUE or FALSE)

##Call search algorithm using FRESH statistic
ebaout.wn <- eba.search(X=X$wn,N=N,K=K,std=std,alpha=alpha);
ebaout.bL <- eba.search(X=X$bL,N=N,K=K,std=std,alpha=alpha);
ebaout.bS <- eba.search(X=X$bS,N=N,K=K,std=std,alpha=alpha);

##See final partition of frequency space
ebaout.wn$part.final; #one single band
ebaout.bL$part.final; #three bands estimated
ebaout.bS$part.final; #three bands estimated

##Check p-values for each tested partition point
ebaout.wn$log;
#first partition point tested insignificant, so algorithm stopped

ebaout.bL$log;
#3 partition points tested in total, 2 determined to be significant

ebaout.bS$log;
#3 partition points tested in total, 2 determined to be significant

##Plot multitaper spectral estimates along with estimated frequency partition points
par(mfrow=c(3,1),oma=c(0,0,2,0),mar=c(4,4,1.5,2)+0.1);
image.plot(x=ebaout.wn$mtspec$t,y=ebaout.wn$mtspec$f,z=t(ebaout.wn$mtspec$mtspec),
           axes = TRUE, col = inferno(256),zlim=c(0,10),
           xlab='Time',ylab='Hz',xaxs="i");
abline(h=ebaout.wn$part.final[c(-1,-length(ebaout.wn$part.final))],col='green');
image.plot(x=ebaout.bL$mtspec$t,y=ebaout.bL$mtspec$f,z=t(ebaout.bL$mtspec$mtspec),
           axes = TRUE, col = inferno(256), zlim=c(0,10),
           xlab='Time',ylab='Hz',xaxs="i");
abline(h=ebaout.bL$part.final[c(-1,-length(ebaout.bL$part.final))],col='green');
image.plot(x=ebaout.bS$mtspec$t,y=ebaout.bS$mtspec$f,z=t(ebaout.bS$mtspec$mtspec),
           axes = TRUE, col = inferno(256), zlim=c(0,10),
           xlab='Time',ylab='Hz',xaxs="i");
abline(h=ebaout.bS$part.final[c(-1,-length(ebaout.bS$part.final))],col='green');
mtext("Multitaper Spectrogram for White Noise(top) Linear(middle) and Sinusoidal(bottom)", outer = TRUE, cex = 1);

##Check p-values for flat spectrum for each segment
ebaout.wn$flat;
#p-value 0.47 fails to reject hypothesis of flat spectrum

ebaout.bL$flat
#p-value for band (0.150,0.344] fails to reject hypothesis of flat spectrum
#p-values for other frequency bands reject flat spectrum hypothesis

ebaout.bS$flat
#p-values for all frequency bands reject flat spectrum hypothesis
