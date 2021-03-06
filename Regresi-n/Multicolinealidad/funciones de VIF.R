help(VIF)
require(car)
help("vif")
#CREANDO FUNCION PARA EXTRAER RESULTADOS PARA DIAGN�STICOS DE MULTICOLINEALIDAD
misDiagnostcolin <- function(modeloreg,centrar=F){
  if(centrar==F){
    X=model.matrix(modeloreg)
    val.prop=prcomp(X,center=FALSE,scale=TRUE)$sdev^2
    Ind=colldiag(modeloreg)
    resul=data.frame(Val.propio=val.prop,Ind.Cond=Ind$condindx,Pi=Ind$pi)
    cat("Diagn�sticos Multicolinealidad - Intercepto inclu�do","\n",
        "�ndices de Condici�n y Proporciones de Varianza","\n")
  }
  else{
    X=model.matrix(modeloreg)[,-1]
    val.prop=prcomp(X,center=TRUE,scale=TRUE)$sdev^2
    Ind=colldiag(modeloreg,center=TRUE,scale=TRUE)
    resul=data.frame(Val.propio=val.prop,Ind.Cond=Ind$condindx,Pi=Ind$pi)
    cat("Diagn�sticos Multicolinealidad - Intercepto ajustado","\n",
        "�ndices de Condici�n y Proporciones de Varianza","\n")
  }
  resul
} 

#CREANDO FUNCI�N PARA EXTRAER COEFICIENTES ESTIMADOS, SUS IC DEL 95%, VIF'S Y COEFICIENTES ESTANDARIZADOS
miscoeficientes <- function(modeloreg,datosreg){
  coefi=coef(modeloreg)
  datos2=as.data.frame(scale(datosreg))
  coef.std=c(0,coef(lm(update(formula(modeloreg),~.+0),datos2)))
  limites=confint(modeloreg,level=0.95)
  vifs=c(0,vif(modeloreg))
  resul=data.frame(Estimaci�n=coefi,Limites=limites,Vif=vifs,Coef.Std=coef.std)
  cat("Coeficientes estimados, sus I.C, Vifs y Coeficientes estimados estandarizados","\n")
  resul
} 