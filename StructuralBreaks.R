source("ReadData.R")
#Ustawia kontekst danych, aby wiedziec jakie wartosci
#wspolczynnikow beta1 opisuja duze zmiany
SetContext<-function(data)
{
  n<-length(data)
  vR<-(sd(data))/(2*h) #h-odleglosc miedzy wezlami
  c(0,0.15*vR,vR)
}

#Funkcja zwraca indeksy fuzzy sets
#odpowiadajace miejscom na wykresie gdzie nastapil "structural break"
FindStructuralBreaks<-function(betas, context)
{
  n<-length(betas)
  betas[1]<-betas[2]
  betas[n]<-betas[n-1]
  changeToPos<-which(diff(sign(betas))>0)
  changes<-betas[changeToPos+1]-betas[changeToPos]
  ind<-which(changes>1.3*context[2])
  res1<-changeToPos[ind]
  
  changeToNeg<-which(diff(sign(betas))<0)
  changes2<-betas[changeToNeg]-betas[changeToNeg+1]
  ind2<-which(changes2>1.3*context[2])
  res2<-changeToNeg[ind2]
  
  ver<-which(abs(betas)>3*context[2])
  hor<-which(abs(betas)<0.3*context[2])
  res3<-unique(intersect(ver,hor+1))
  
  res<-unique(c(res1,res2,res3))
  res<-res[order(res)]
}
