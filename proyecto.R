# Ejecuta solo una vez
#install.packages("pdftools")
#install.packages("tidyverse")

library("pdftools")
library("tidyverse")

# direccion de archivo
pdf.file <- "file.pdf"

# capturamos el texto del pdf
pdf.text <- pdftools::pdf_text(pdf.file)

# convierte el documento a lista(cada pag es 1 elemento) y en minúscula
pdf.text<-unlist(pdf.text)
pdf.text<-tolower(pdf.text)

# elimina espacios de muchos caracteres, dejando solo uno
# e.g.: " \nhola   que   tal \t  " -> "hola que tal"
pdf.text <- sapply(pdf.text, str_squish)


cat(pdf.text[37])

# busca el enlace en el documento
regex_link <- "(http|https)://[a-zA-Z0-9\\-\\.]+\\.[a-zA-Z]{2,3}(/\\S*)?"
regex_simple_link <- "(http|https).{55}"

enlaces <- str_extract_all(pdf.text,regex_simple_link)
str_extract_all("https://doi.org/10.1016/b978-0-12-800049-6.00024-x.nola,r",regex_link)
enlaces <- unlist(enlaces)
data <- data.frame(enlaces)

colnames(data)<-"enlaces"
data

install.packages("writexl")
library("writexl")
write_xlsx(data,"datos.xlsx")
