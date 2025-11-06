# newsProjectSwift
Proyecto final curso Apps nativo

# Descripción del proyecto
-Es una aplicación nativa echa con swift ui la cual carga ultimas noticias de tecnología, los datos se optienen de una api publica llamada "NewsAPI"

-La arquitectura que se usa es MVVM dividida de la siguiente manera:
-Model 
    contiene el archivo ArticleModel el cual es un modelado de datos correspondientes a cada noticia
-Services
    contiene el archivo NetworkManager el cual contiene la clase NetWorkManager la cual funciona como un singleton ya que contiene una unica instancia que centraliza la obtención y decodificación de datos JSON desde una URL.
    contiene el archivo NewsRepository el cual contiene la clase la cual va construir la url para la peticion llamando a NetworkManager.shared.fetchData y retornando los articulos del servicio
-ViewModel
    contiene el archivo NewsViewModel la cual es de tipo ObservableObject la cual permite que esta clase sea observada por las vistas SwiftUI; cuando cambien sus propiedades publicadas, la vista se redibujará automáticamente.
-Views
    contiene el archivo NewsDetailView el cual pinta la noticia completa y el boton abrir fuente 
    contiene el archivo NewsDetailView el cual pinta la vista de cada noticia con su respectiva imagen autor y fecha 


# Instrucciones para correr swift
Abre el proyecto: Localizar el archivo .xcodeproj del proyecto y abrir con Xcode. 
Compilar y ejecutar: Hacer clic en el botón "Run" (el ícono de triángulo de reproducción) en la esquina superior izquierda de la ventana, o presiona ⌘R para compilar y ejecutar la aplicación.
Verificar la salida: La aplicación se ejecutará en el simulador o dispositivo seleccionado.  se Puede ver la salida de la consola dentro de Xcode. 