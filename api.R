library(plumber)


#* retornar a media de 3 valores
#* @param n1 é o primeiro numero inputado
#* @param n2 é o segundo numero inputado
#* @param n3 é o terceiro numero inputado
#* @get /media

function(n1, n2, n3){
  paste0("A média dos valores é ", round(mean(c(as.numeric(n1), as.numeric(n2), as.numeric(n3)), 2)), "!!!")
}
