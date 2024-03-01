# NotesApp
NotesApp es una aplicación web que te permite anotar toda la información útil que necesites en notas de fácil edición.
Debes registrarte, y luego podrás crear notas.
Las notas se componen de un título y un contenido, y se les puede asignar categorías a cada nota.

### Requisitos técnicos
#### Backend ruby
* Ruby 3.2.2
* Ruby on Rails 7.1.2
* SQLite3
* Node.js 20.10.0

#### Frontend Vue.js
* Vue.js 3.2.13
* Node.js 20.10.0


### Instalación
* git clone https://github.com/alanberns/NotesApp.git
* cd backend
* bundle install
* rails db:migrate
* cd ../frontend
* npm install


### Iniciar la aplicación 
Inicio en un comando
* source/bash start.sh

Inicio por separado
-Backend
* cd backend 
* rails server

-Frontend
* cd frontend
* vue serve


### Datos de prueba
Configurar en el backend:
* cd backend
* rails db:seed

Utilizar en frontend

usuarios de prueba:
* username: testuno
* username: testdos

passwords: 
* asdfg (para todos los usuarios)


### Alcance del sistema
La aplicación backend provee el registro y login de usuarios.
Al iniciar sesión un usuario, se provee un token de autorización que debe ser enviado en 
las peticiones HTTP que lo necesiten.

La aplicación frontend almacena el token y el username del usuario autenticado.

Los usuarios pueden modificar y eliminar su cuenta.
Los usuarios pueden crear, editar y eliminar sus notas.
Los usuarios pueden añadir y quitar categorias a sus notas.
Los usuarios pueden archivar y activar sus notas.
Los usuarios pueden filtrar sus notas por una categoría, y por el estado de las notas.


### Arquitectura
El sistema está compuesto por una aplicación backend y una aplicación frontend.
El backend, desarrollado en ruby, provee una API que será consumida por la aplicación frontend.
No ofrece vistas.
Para autenticarse - ver POST /api/login - la aplicación, en caso de ser exitosa la solicitud, genera
un token que es devuelto en la respuesta junto con el username.
Para cada request que necesite de autorización, debe enviarse el token. La aplicación chequea la prescencia 
del token en el header 'Authorization'.
* El tratamiento de autenticación bajo token fue realizado con la gema 'jwt'
* Encriptación de contraseñas: gema 'bcrypt'
* CORS: gema 'rack-cors'

El frontend, desarrollado en Vue.js, consume la API del backend.
La aplicación está diseñada como una SPA. Almacena el token de autorización, como otros datos que requiera.
* Para el almacenamiento del estado se utilizó la librería 'Pinia'
* Para realizar peticiones HTTP y consumir la API: librería 'Axios'
* Para el maquetado HTML se utilizó 'Bootstrap'
* Para el ruteo de la aplicación se usó 'vue-router'


### API

* POST /api/login
Se debe enviar password y username. Devuelve un token de validación.
{'username':'xxxx', 'password':'xxxx'}


* POST /user/
Crea un usuario
{'user':{
    'username':'xxxx',
    'password':'xxxx'}
}

* GET /user/
Se solicita la información del usuario actual. 
Se debe enviar el token de autorización.
{'headers':
    {'Authorization':'token'}
}

* PUT /user/
Se modifica el username del usuario actual.
Se debe enviar el token de autorización.
{'username':'xxxx'}
{'headers':
    {'Authorization':'token'}
}

* DELETE /user/
Se elimina el usuario actual.
Se debe enviar el token de autorización.

* GET /notes
Se solicitan las notas del usuario actual. Activas(true) o archivadas(false)
Se debe enviar el token de autorización.
params: {
    isActive: false/true,
    category: '1'
}
isActive si no es definido se asume 'true'.
category si no es definido, no se filtra por categoria.

* GET /notes/1
Se solicita la nota 1 del usuario actual
Se debe enviar el token de autorización.


* POST /notes
Se crea una nueva nota, se debe enviar la nota y sus categorias.
Se debe enviar el token de autorización.
{
    'note':{
        'title':'xxxx',
        'content':'xxxx'
    },
    'categories':[{'id':1,'name':'xxx'},{'id':2,'name':'xxx'}] 
}

* PATCH /notes/1/toggle
Activa o desactiva la nota 1. La modificación se hace en el controlador.
Se debe enviar el token de autorización.

* PUT /notes/1
Se modifica la nota 1. Se debe enviar la nota y sus categorias.
Se debe enviar el token de autorización.
{
    'note':{
        'title':'xxxx',
        'content':'xxxx'
    },
    'categories': [{'id':1,'name':'xxx'},{'id':2,'name':'xxx'}] 
}

* DELETE /notes/1
Se elimina la nota 1.
Se debe enviar el token de autorización.


* GET /categories
Se solicitan las caegorías disponibles