# Ejecuta solo una vez

#install.packages("pdftools")
#install.packages("tidyverse")
# install.packages("writexl")

library("pdftools")
library("tidyverse")
library("writexl")

# Dada una ruta de un pdf, extrae los enlaces
# y devuelve una lista con todos ellos
get_urls <- function(pdf.file) {
  
  expresion_regular <- "https?[^\\s\\),\\(;]+\\s*[^\\s\\),\\(;\\:]*"
  
  pdf <- pdftools::pdf_text(pdf.file)
  pdf.text <- unlist(pdf)# convertimos en lista

  
  enlaces <- pdf.text %>% 
    str_extract_all(expresion_regular) %>% # extraemos el enlace (sucio)
    unlist() %>% # deshacemos la lista de listas en una única lista
    sapply(str_squish) %>% # aplicamos el squish sobre todos los enlaces
    str_replace_all(pattern = " ", replacement = "") # dar formato a la url
  
  return (unlist(enlaces,recursive=FALSE))
}

# Funcion que debe devolver un dataFrame que rellene los valores
# más pequeños (columnas con menos valores) con NAs para evitar
# que aparezcan duplicados
fillNas <- function(lista_vector,max_length){
  for (elemento in lista_vector){
    return (0)
  }
}

documentos <- list.files(path="archivos",full.names=TRUE)

list_urls <- list()

i = 1
max.length = 0
for (pdf.path in documentos) {
  urls <- get_urls(pdf.path)
  
  if (length(urls) > max){
    max.length <- length(urls)
  }
  
  list_urls[[i]] <- urls
  i = i + 1
}
print(list_urls)
data <- data.frame(list_urls)
colnames(data) <- documentos
head(data)
write_xlsx(data,"datos_urls.xlsx")
write_csv(data, "csv.csv")


