library(tidyverse) #Cargamos la librería 'tidyverse'

data() #Por defecto, RStudio trae incorporados algunos set de datos. En esta oportunidad, trabajaremos con un set de Star Wars.


#Tipos de variables

glimpse(starwars) #glimpse() nos devuelve un vistazo de las columnas del set de datos y algunos valores

class(starwars$gender) #class() nos devuelve la clase de datos de la variable

unique(starwars$gender) #unique() nos devuelve los tipos de datos que aparecen en la variable

starwars$gender <- as.factor(starwars$gender) #cambiamos la clase de la variable gender a factor, es decir, a una variable categórica
class(starwars$gender) #revisamos la clase cambiada

levels(starwars$gender) #verificamos el orden del factor

starwars$gender <- factor((starwars$gender),
                          levels=c("masculine","femenine")) #cambiamos el orden del factor

levels(starwars$gender) #verificamos el cambio.


#Selección de variables

starwars %>% 
  select(name, height, ends_with("color"))

#Filtrado de observaciones

unique(starwars$hair_color)

starwars %>% 
  select(name,height,ends_with("color")) %>% 
  filter(hair_color %in% c("blond","brown") & #el operador %in% significa "sea esto o lo otro"
           height < 180)

#datos faltantes

mean(starwars$height, na.rm = TRUE) #'na.rm' excluye los datos no disponibles del cálculo de la media.

starwars %>% 
  select(name, gender, hair_color, height)

starwars %>% 
  select(name, gender, hair_color, height) %>% 
  na.omit() #quita las observaciones NA del set de datos, aunque no es lo recomendable si no tenemos un conocimiento pleno del dataset.

starwars %>% 
  select(name,gender,hair_color,height) %>% 
  filter(!complete.cases(.)) #Con este método dejamos afuera los datos completos para observar las observaciones que se encuentran incompletas en alguna de sus variables.

starwars %>% 
  select(name, gender, hair_color, height) %>% 
  filter(!complete.cases(.)) %>% 
  drop_na(height) %>% #filtra las observaciones incompletas de la variable height.
  view()

starwars %>% 
  select(name,gender,hair_color,height) %>% 
  filter(!complete.cases(.)) %>% 
  mutate(hair_color=replace_na(hair_color,"none")) #modifica la variable hair_color, reemplazando los NA por none.



#Duplicados

#Dado que no hay duplicados en el dataset de 'starwars', usamos otro ejemplo

Nombres <- c("Carlos", "Juan", "Rodrigo", "Carlos") #creamos el vector con los valores de nombres
Edad <- c(22,33,44,22) #creamos el vector con los valores de edad

Amigos <- data.frame(Nombres, Edad) #creamos el data frame con los valores previos
duplicated(Amigos) #devuelve un booleano para cada observacion

Amigos[!duplicated(Amigos),] #filtra de la manera básica de R las observaciones que no son duplicadas.


#Duplicados con tidyverse

Amigos %>% distinct() %>% 
  View()


#Recodificar variables

starwars %>%
  select(name,gender) %>%
  mutate(gender = recode(gender,
                         "masculine"=1,
                         "femenine"=2))