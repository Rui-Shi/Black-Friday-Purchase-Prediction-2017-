library(readr)
train <- read_csv("C:/Users/shiru/Desktop/train.csv", 
                  col_types = cols(Marital_Status = col_number(), 
                                   Occupation = col_number(), Product_Category_1 = col_number(), 
                                   Product_Category_2 = col_number(), 
                                   Product_Category_3 = col_number(), 
                                   Purchase = col_number()))

mm=10000
# Replace the missing values by zero which should be reasonable in this case.
train[is.na(train)]=0 
# Select the first 10000 observations to fit models.
train=train[1:mm,] 

Gender=rep(0,c(mm))
Age=rep(0,c(mm))
City_CategoryA=rep(0,c(mm))
City_CategoryB=rep(0,c(mm))

# Construct dummy variable vector for "Gender".
for(i in 1:mm){
  if(train$Gender[i]=="F") Gender[i]=1
}

# Construct the "age" scores vector by 1 to 7 from the youngest intervals to the oldest intervals.
for(i in 1:mm){
  if(train$Age[i]=="0-17")
    Age[i]=1
  else if(train$Age[i]=="18-25")
    Age[i]=2
  else if(train$Age[i]=="26-35")
    Age[i]=3
  else if(train$Age[i]=="36-45")
    Age[i]=4
  else if(train$Age[i]=="46-50")
    Age[i]=5
  else if(train$Age[i]=="51-55")
    Age[i]=6
  else 
    Age[i]=7
}

# Construct 2 dummy variable vector for "City_Category"
for(i in 1:mm){
  if(train$City_Category[i]=="A")
    City_CategoryA[i]=1
  else if(train$City_Category[i]=="B")
    City_CategoryB[i]=1
  else 0
}

# Construct the score vector for "Stay_In_Current_City_Years".
for(i in 1:mm){
  if(train$Stay_In_Current_City_Years[i]=="4+")
    train$Stay_In_Current_City_Years[i]="4"
}
train$Stay_In_Current_City_Years=as.numeric(train$Stay_In_Current_City_Years)

# Replacement of the orginal data variables.
head(as.numeric(train$Gender))
train$Gender=Gender
head(as.numeric(train$Age))
train$Age=Age

trainm=as.data.frame(cbind(as.matrix(train[,3:5]),as.matrix(City_CategoryA),
            as.matrix(City_CategoryB),as.matrix(train[,7:12])))
names(trainm)[4:5]=c("City_CategoryA","City_CategoryB")

# Construct 20 dummy variables vectors for "Occupation" 
# since there are 21 occupations.
Occupation0<-rep(0,10000)
Occupation1<-rep(0,10000)
Occupation2<-rep(0,10000)
Occupation3<-rep(0,10000)
Occupation4<-rep(0,10000)
Occupation5<-rep(0,10000)
Occupation6<-rep(0,10000)
Occupation7<-rep(0,10000)
Occupation8<-rep(0,10000)
Occupation9<-rep(0,10000)
Occupation10<-rep(0,10000)
Occupation11<-rep(0,10000)
Occupation12<-rep(0,10000)
Occupation13<-rep(0,10000)
Occupation14<-rep(0,10000)
Occupation15<-rep(0,10000)
Occupation16<-rep(0,10000)
Occupation17<-rep(0,10000)
Occupation18<-rep(0,10000)
Occupation19<-rep(0,10000)
for(i in 1:10000){
  if(trainm$Occupation[i]==0) 
    Occupation0[i]=1
  else if (trainm$Occupation[i]==1)
    Occupation1[i]=1
  else if (trainm$Occupation[i]==2)
    Occupation2[i]=1
  else if (trainm$Occupation[i]==3)
    Occupation3[i]=1
  else if (trainm$Occupation[i]==4)
    Occupation4[i]=1
  else if (trainm$Occupation[i]==5)
    Occupation5[i]=1
  else if (trainm$Occupation[i]==6)
    Occupation6[i]=1
  else if (trainm$Occupation[i]==7)
    Occupation7[i]=1
  else if (trainm$Occupation[i]==8)
    Occupation8[i]=1
  else if (trainm$Occupation[i]==9)
    Occupation9[i]=1
  else if (trainm$Occupation[i]==10)
    Occupation10[i]=1
  else if (trainm$Occupation[i]==11)
    Occupation11[i]=1
  else if (trainm$Occupation[i]==12)
    Occupation12[i]=1
  else if (trainm$Occupation[i]==13)
    Occupation13[i]=1
  else if (trainm$Occupation[i]==14)
    Occupation14[i]=1
  else if (trainm$Occupation[i]==15)
    Occupation15[i]=1
  else if (trainm$Occupation[i]==16)
    Occupation16[i]=1
  else if (trainm$Occupation[i]==17)
    Occupation17[i]=1
  else if (trainm$Occupation[i]==18)
    Occupation18[i]=1
  else if (trainm$Occupation[i]==19)
    Occupation19[i]=1
  else 
    0
}

# Construct 17 dummy variables vectors for "Product_Category_1" 
# since there are 18 categorys in "Product_Category_1".
Product_Category_11=rep(0,10000)
Product_Category_12=rep(0,10000)
Product_Category_13=rep(0,10000)
Product_Category_14=rep(0,10000)
Product_Category_15=rep(0,10000)
Product_Category_16=rep(0,10000)
Product_Category_17=rep(0,10000)
Product_Category_18=rep(0,10000)
Product_Category_19=rep(0,10000)
Product_Category_110=rep(0,10000)
Product_Category_111=rep(0,10000)
Product_Category_112=rep(0,10000)
Product_Category_113=rep(0,10000)
Product_Category_114=rep(0,10000)
Product_Category_115=rep(0,10000)
Product_Category_116=rep(0,10000)
Product_Category_117=rep(0,10000)
for(i in 1:10000){
  if(trainm$Product_Category_1[i]==1)
    Product_Category_11[i]=1
  else if(trainm$Product_Category_1[i]==2)
    Product_Category_12[i]=1
  else if(trainm$Product_Category_1[i]==3)
    Product_Category_13[i]=1
  else if(trainm$Product_Category_1[i]==4)
    Product_Category_14[i]=1
  else if(trainm$Product_Category_1[i]==5)
    Product_Category_15[i]=1
  else if(trainm$Product_Category_1[i]==6)
    Product_Category_16[i]=1
  else if(trainm$Product_Category_1[i]==7)
    Product_Category_17[i]=1
  else if(trainm$Product_Category_1[i]==8)
    Product_Category_18[i]=1
  else if(trainm$Product_Category_1[i]==9)
    Product_Category_19[i]=1
  else if(trainm$Product_Category_1[i]==10)
    Product_Category_110[i]=1
  else if(trainm$Product_Category_1[i]==11)
    Product_Category_111[i]=1
  else if(trainm$Product_Category_1[i]==12)
    Product_Category_112[i]=1
  else if(trainm$Product_Category_1[i]==13)
    Product_Category_113[i]=1
  else if(trainm$Product_Category_1[i]==14)
    Product_Category_114[i]=1
  else if(trainm$Product_Category_1[i]==15)
    Product_Category_115[i]=1
  else if(trainm$Product_Category_1[i]==16)
    Product_Category_116[i]=1
  else if(trainm$Product_Category_1[i]==17)
    Product_Category_117[i]=1
  else
    0
}

# Construct 18 dummy variables vectors for "Product_Category_2" 
# since there are 19 categorys in "Product_Category_2".
Product_Category_20=rep(0,10000)
Product_Category_21=rep(0,10000)
Product_Category_22=rep(0,10000)
Product_Category_23=rep(0,10000)
Product_Category_24=rep(0,10000)
Product_Category_25=rep(0,10000)
Product_Category_26=rep(0,10000)
Product_Category_27=rep(0,10000)
Product_Category_28=rep(0,10000)
Product_Category_29=rep(0,10000)
Product_Category_210=rep(0,10000)
Product_Category_211=rep(0,10000)
Product_Category_212=rep(0,10000)
Product_Category_213=rep(0,10000)
Product_Category_214=rep(0,10000)
Product_Category_215=rep(0,10000)
Product_Category_216=rep(0,10000)
Product_Category_217=rep(0,10000)
for(i in 1:10000){
  if(trainm$Product_Category_2[i]==0)
    Product_Category_20[i]=1
  else if(trainm$Product_Category_2[i]==1)
    Product_Category_21[i]=1
  else if(trainm$Product_Category_2[i]==2)
    Product_Category_22[i]=1 
  else if(trainm$Product_Category_2[i]==3)
    Product_Category_23[i]=1
  else if(trainm$Product_Category_2[i]==4)
    Product_Category_24[i]=1 
  else if(trainm$Product_Category_2[i]==5)
    Product_Category_25[i]=1
  else if(trainm$Product_Category_2[i]==6)
    Product_Category_26[i]=1 
  else if(trainm$Product_Category_2[i]==7)
    Product_Category_27[i]=1
  else if(trainm$Product_Category_2[i]==8)
    Product_Category_28[i]=1
  else if(trainm$Product_Category_2[i]==9)
    Product_Category_29[i]=1
  else if(trainm$Product_Category_2[i]==10)
    Product_Category_210[i]=1 
  else if(trainm$Product_Category_2[i]==11)
    Product_Category_211[i]=1
  else if(trainm$Product_Category_2[i]==12)
    Product_Category_212[i]=1 
  else if(trainm$Product_Category_2[i]==13)
    Product_Category_213[i]=1
  else if(trainm$Product_Category_2[i]==14)
    Product_Category_214[i]=1 
  else if(trainm$Product_Category_2[i]==15)
    Product_Category_215[i]=1
  else if(trainm$Product_Category_2[i]==16)
    Product_Category_216[i]=1
  else if(trainm$Product_Category_2[i]==17)
    Product_Category_217[i]=1
  else
    0
}

# Construct 18 dummy variables vectors for "Product_Category_3" 
# since there are 19 categorys in "Product_Category_3".
Product_Category_30=rep(0,10000)
Product_Category_31=rep(0,10000)
Product_Category_32=rep(0,10000)
Product_Category_33=rep(0,10000)
Product_Category_34=rep(0,10000)
Product_Category_35=rep(0,10000)
Product_Category_36=rep(0,10000)
Product_Category_37=rep(0,10000)
Product_Category_38=rep(0,10000)
Product_Category_39=rep(0,10000)
Product_Category_310=rep(0,10000)
Product_Category_311=rep(0,10000)
Product_Category_312=rep(0,10000)
Product_Category_313=rep(0,10000)
Product_Category_314=rep(0,10000)
Product_Category_315=rep(0,10000)
Product_Category_316=rep(0,10000)
Product_Category_317=rep(0,10000)
for(i in 1:10000){
  if(trainm$Product_Category_3[i]==0)
    Product_Category_30[i]=1
  else if(trainm$Product_Category_3[i]==1)
    Product_Category_31[i]=1
  else if(trainm$Product_Category_3[i]==2)
    Product_Category_32[i]=1 
  else if(trainm$Product_Category_3[i]==3)
    Product_Category_33[i]=1
  else if(trainm$Product_Category_3[i]==4)
    Product_Category_34[i]=1 
  else if(trainm$Product_Category_3[i]==5)
    Product_Category_35[i]=1
  else if(trainm$Product_Category_3[i]==6)
    Product_Category_36[i]=1 
  else if(trainm$Product_Category_3[i]==7)
    Product_Category_37[i]=1
  else if(trainm$Product_Category_3[i]==8)
    Product_Category_38[i]=1
  else if(trainm$Product_Category_3[i]==9)
    Product_Category_39[i]=1
  else if(trainm$Product_Category_3[i]==10)
    Product_Category_310[i]=1 
  else if(trainm$Product_Category_3[i]==11)
    Product_Category_311[i]=1
  else if(trainm$Product_Category_3[i]==12)
    Product_Category_312[i]=1 
  else if(trainm$Product_Category_3[i]==13)
    Product_Category_313[i]=1
  else if(trainm$Product_Category_3[i]==14)
    Product_Category_314[i]=1 
  else if(trainm$Product_Category_3[i]==15)
    Product_Category_315[i]=1
  else if(trainm$Product_Category_3[i]==16)
    Product_Category_316[i]=1
  else if(trainm$Product_Category_3[i]==17)
    Product_Category_317[i]=1
  else
    0
}

# New dataframe after processing.
trainm=data.frame(cbind(as.matrix(trainm[,1:2]),Occupation0,Occupation1,Occupation2,Occupation3,
                         Occupation4,Occupation5,Occupation6,Occupation7,Occupation8,Occupation9,
                         Occupation10,Occupation11,Occupation12,Occupation13,Occupation14,Occupation15,
                         Occupation16,Occupation17,Occupation18,Occupation19,as.matrix(trainm[4:7]),
                         Product_Category_11,Product_Category_12,Product_Category_13,Product_Category_14,
                         Product_Category_15,Product_Category_16,Product_Category_17,Product_Category_18,
                         Product_Category_19,Product_Category_110,Product_Category_111,Product_Category_112,
                         Product_Category_113,Product_Category_114,Product_Category_115,Product_Category_116,
                         Product_Category_117,Product_Category_20,Product_Category_21,Product_Category_22,
                         Product_Category_23,Product_Category_24,Product_Category_25,Product_Category_26,
                         Product_Category_27,Product_Category_28,Product_Category_29,Product_Category_210,
                         Product_Category_211,Product_Category_212,Product_Category_213,Product_Category_214,
                         Product_Category_215,Product_Category_216,Product_Category_217,Product_Category_30,
                         Product_Category_31,Product_Category_32,Product_Category_33,Product_Category_34,
                         Product_Category_35,Product_Category_36,Product_Category_37,Product_Category_38,
                         Product_Category_39,Product_Category_310,Product_Category_311,Product_Category_312,
                         Product_Category_313,Product_Category_314,Product_Category_315,Product_Category_316,
                         Product_Category_317,as.matrix(trainm[,11])))
head(trainm)

# Fit linear regression model first.
xx<-as.matrix(trainm[,1:79])
y<-as.matrix(trainm[,80])
out=lm(y~xx)
summary(out)

par(cex=0.7)
# Plot standardized residuals against fitted values.
plot(out$fitted.values,rstandard(out))
# QQ plot.
plot(out,2)

# Remove the variables which are zero in all observations.
xx<-xx[,-c(45,63,64,69)]

# Make log transformation to y.
ylog=log(y)
out.full=lm(ylog~.,data=as.data.frame(xx)) 
# Standardized residuals plot become acceptable.
plot(out.full$fitted.values,rstandard(out.full))
plot(out.full,2)

# try Box-Cox method.
library(MASS)
boxcox(out,lambda=seq(0.4,0.5,1/100),plotit=TRUE)
# lambda=0.465
lamb=0.465
yboxcox=(y^lamb-1)/lamb/prod(y^(1/10000))^(lamb-1)
out.boxcox=lm(yboxcox~.,data=as.data.frame(xx)) 
plot(out.boxcox$fitted.values,rstandard(out.boxcox))
plot(out.boxcox,2)

# Step-wise backward selection.
xx1=xx
repeat{out2=lm(ylog~xx1)
out22=summary(out2)
if(out22$coefficients[which.max(out22$coefficients[,4]),4]<0.05) break
j=as.numeric(which.max(out22$coefficients[,4])-1)
xx1<-xx1[,-j]
}

# Stepwise forward, backward and hybrid selection.(use AIC as criterion)
out.null=lm(ylog~1,data=as.data.frame(xx))
full=formula(lm(ylog~.,as.data.frame(xx)))
out.forward=step(out.null,scope=list(lower=~1,upper=full),direction="forward",
                 data=as.data.frame(xx),trace=F)

out.backward=step(out.full,scope=list(lower=~1,upper=full),direction="backward",
                 data=as.data.frame(xx),trace=F)

out.both=step(out.full,scope=list(lower=~1,upper=full),direction="both",
                 data=as.data.frame(xx),trace=F)

# Compare adj.r.squared of the four models
out22$adj.r.squared
summary(out.forward)$adj.r.squared
summary(out.backward)$adj.r.squared
summary(out.both)$adj.r.squared

# K-fold Cross validation
library(boot)
set.seed(123)
print(cv.glm(data=as.data.frame(xx),
             glm(ylog~xx1,data=as.data.frame(xx)),K=5)$delta[1])
xx2<-cbind(Product_Category_11,Product_Category_113, 
           Product_Category_14,Product_Category_112,Product_Category_15,
           Product_Category_111,Product_Category_18,Product_Category_24,
           Product_Category_110,Product_Category_16,Product_Category_17,
           Product_Category_116,Product_Category_115,Product_Category_20,
           City_CategoryA,Product_Category_12,Product_Category_13, 
           Product_Category_114,Product_Category_117,Product_Category_19,
           Product_Category_38,City_CategoryB,Age , Product_Category_317 , 
           Occupation11,Occupation5 , Occupation19 , Occupation17 , 
           Product_Category_28 , Product_Category_217 , Occupation7 , 
           Product_Category_35 , Occupation6 , Occupation12 , Occupation15 , 
           Occupation3 , Occupation0 , Occupation10 , Product_Category_33 , 
           Occupation1 , Product_Category_210 , Occupation13 , Occupation4 , 
           Occupation2 , Product_Category_25 , Product_Category_34 , 
           Product_Category_312 , Product_Category_316 , Product_Category_315 , 
           Occupation14 , Occupation9 , Occupation16)
print(cv.glm(data=as.data.frame(xx),
             glm(ylog~xx2,data=as.data.frame(xx)),K=5)$delta[1])

xx3<-cbind(Age , Occupation0 , Occupation1 , Occupation2 , 
             Occupation3 , Occupation4 , Occupation5 , Occupation6 , Occupation7 , 
             Occupation9 , Occupation10 , Occupation11 , Occupation12 , 
             Occupation13 , Occupation14 , Occupation15 , Occupation16 , 
             Occupation17 , City_CategoryA , City_CategoryB , Product_Category_11 , 
             Product_Category_12 , Product_Category_13 , Product_Category_14 , 
             Product_Category_15 , Product_Category_16 , Product_Category_17 , 
             Product_Category_18 , Product_Category_19 , Product_Category_110 , 
             Product_Category_111 , Product_Category_112 , Product_Category_113 , 
             Product_Category_114 , Product_Category_115 , Product_Category_116 , 
             Product_Category_117 , Product_Category_20 , Product_Category_24 , 
             Product_Category_25 , Product_Category_26 , Product_Category_210 , 
             Product_Category_211 , Product_Category_212 , Product_Category_213 , 
             Product_Category_214 , Product_Category_215 , Product_Category_216 , 
             Product_Category_217 , Product_Category_30 , Product_Category_33 , 
             Product_Category_34 , Product_Category_35 , Product_Category_38 , 
             Product_Category_312 , Product_Category_314 , Product_Category_317)
print(cv.glm(data=as.data.frame(xx),
             glm(ylog~xx3,data=as.data.frame(xx)),K=5)$delta[1])

xx4<-cbind(Age , Occupation0 , Occupation1 , Occupation2 , 
           Occupation3 , Occupation4 , Occupation5 , Occupation6 , Occupation7 , 
           Occupation9 , Occupation10 , Occupation11 , Occupation12 , 
           Occupation13 , Occupation14 , Occupation15 , Occupation16 , 
           Occupation17 , City_CategoryA , City_CategoryB , Product_Category_11 , 
           Product_Category_12 , Product_Category_13 , Product_Category_14 , 
           Product_Category_15 , Product_Category_16 , Product_Category_17 , 
           Product_Category_18 , Product_Category_19 , Product_Category_110 , 
           Product_Category_111 , Product_Category_112 , Product_Category_113 , 
           Product_Category_114 , Product_Category_115 , Product_Category_116 , 
           Product_Category_117 , Product_Category_20 , Product_Category_24 , 
           Product_Category_25 , Product_Category_26 , Product_Category_210 , 
           Product_Category_211 , Product_Category_212 , Product_Category_213 , 
           Product_Category_214 , Product_Category_215 , Product_Category_216 , 
           Product_Category_217 , Product_Category_30 , Product_Category_33 , 
           Product_Category_34 , Product_Category_35 , Product_Category_38) 
print(cv.glm(data=as.data.frame(xx),
             glm(ylog~xx4,data=as.data.frame(xx)),K=5)$delta[1])

# Check Multicollinearity.
xxforward=xx[,-c(1,11,21,25,26,45,46,49,50,52,
                 54,55,56,57,58,59,61,65,67,68,69,71,72)]
mean(diag(solve(cor(xxforward))))
max(diag(solve(cor(xxforward))))

# Check influential observations
which(cooks.distance(out.forward)>1)

# PCA regression
#Standardization of observations in different scales
xxdata=xx
for(i in 1:75){
  xxdata[,i]=(xxdata[,i]-mean(xx[,i]))/sd(xx[,i])
}
prin=princomp(xxdata)

# Loadings
summary(prin)


# Screeplot
par(cex=0.7)
screeplot(prin,npcs=75,type="barplot")

# Make transformation on data upon the principle components.
xxdatap=predict(prin)

# Fit regression models with principle components 
# whose accumulative variance proportion has just reach 0.9.
outp.full<-lm(y~.,data=as.data.frame(xxdatap[,1:57]))

# Plot residuals against fitted values.
plot(outp.full$fitted.values,outp.full$residuals,main="PCA regression")

# Make log transformation to y.
fullp=formula(lm(ylog~.,as.data.frame(xxdatap[,1:57])))

# Stepwise backward selection.(use AIC as criterion)
outp.backward=step(outp.full,scope=list(lower=~1,upper=fullp),direction="backward",
                  data=as.data.frame(xxdatap[,1:57]),trace=F)
summary(outp.backward)
