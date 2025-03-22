# Descarga dataset 
# GSEMatrix = FALSE, obtenemos un formato tipo lista que después hay que procesar manualmente
# GSEMatrix = TRUE, el dataset ya viene organizado como un objeto ExpressionSet 

if (!require(GEOquery)) {
  BiocManager::install("GEOquery")
}
require(GEOquery)

gds1 <- getGEO("GDS1251", GSEMatrix=TRUE, AnnotGPL=TRUE)


# Determine la estructura de los datos (filas, columnas) y el diseño del estudio 
# (grupos de muestras o individuos, tratamientos si los hubiera, etc.) que los generó.

class(gds1)

# Esto significa que gse1 es un objeto de clase GDS, una clase especial definida 
# por el paquete GEOquery.

#    GDS significa "Gene Expression Omnibus DataSet".
#    Este tipo de objeto aparece cuando descargás datos con getGEO() de un 
#    tipo diferente al GSEMatrix, o cuando usás getGDS().

# attr(,"package") te dice que esa clase "GDS" pertenece al paquete "GEOquery"

# convertir GDS en ExpressionSet
eset <- GDS2eSet(gds1,do.log2=TRUE)

eset

slotNames(gds1)

head(Meta(gds1))

Table(gds1)

Columns(gds1)

# Data frame con los metadatos de la muestra, también llamados phenoData
# a veces se ejecuta pData(phenoData()) a la vez porque...
# phenoData(expSet) extrae el objeto tipo AnnotatedDataFrame que contiene la 
# información de las muestras (es decir, los metadatos).

# phenoData(expSet)   Devuelve un objeto AnnotatedDataFrame
# pData(phenoData(expSet))  Extrae el data.frame desde ese objeto

dim(pData(eset))
View(pData(eset))
# Acceder a los diferentes metadatos
varMetadata(phenoData(eset))
varLabels(phenoData(eset))
sampleNames(phenoData(eset))

# Dimensiones y visualización del assayData
dim(exprs(eset))
View(exprs(eset))

# featureData
# featureData() es la parte del objeto ExpressionSet que guarda anotaciones o 
# metadatos de las variables medidas, es decir, los genes o sondas.

# Es un objeto de clase AnnotatedDataFrame, igual que phenoData(), pero en este 
# caso se refiere a los genes (no a las muestras).

featureData(eset)

fData(eset)[1:2,1:2]

fvarLabels(eset)
fvarMetadata(eset)
featureNames(eset)
View(fData(eset)[1,])
