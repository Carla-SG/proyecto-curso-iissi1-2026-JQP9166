# CharlaCar

## Miembros del grupo L2-ABS-5

1. Cantos González, Rubén
1. Márquez Molina, Álvaro
1. Sánchez Gago, Carla
1. Venteo Tapia, Álvaro

## 1. Introducción al problema

El modelo actual de transporte interurbano y urbano a menudo se enfrenta a problemas como el alto coste económico de los desplazamientos individuales, la congestión del tráfico y un impacto ambiental negativo debido a la alta emisión de gases contaminantes. A su vez, muchos conductores realizan trayectos diarios o esporádicos con asientos vacíos en sus vehículos, mientras que existen personas buscando alternativas de transporte eficientes, económicas y directas para esas mismas rutas.

CharlaCar nace como una solución tecnológica orientada a la economía colaborativa para resolver este problema. El proyecto propone el desarrollo de un sistema integral de transporte compartido que conecta de forma rápida y segura a conductores con plazas disponibles y pasajeros que necesitan realizar el mismo viaje. A través de una plataforma accesible e intuitiva, los usuarios podrán gestionar la publicación, búsqueda y reserva de trayectos de manera transparente. Además, el sistema centraliza la comunicación y los pagos, ofreciendo un entorno confiable que se sustenta en la verificación de usuarios y un sistema de valoraciones cruzadas, fomentando así un uso más sostenible, económico y social de los vehículos.  


## 2. Glosario de términos

•	Administrador 🛡️: Perfil encargado de revisar y mantener el correcto funcionamiento de la plataforma, gestionar incidencias, moderar viajes y asegurar que se cumplan las normativas de la aplicación.

•	Chat 💬: Herramienta de comunicación interna de la plataforma que permite a conductores y pasajeros intercambiar mensajes una vez confirmada una reserva, facilitando la coordinación de detalles como el punto exacto de encuentro. 

•	Conductor 🚗: Usuario mayor de edad y con permiso de conducir validado, que publica un trayecto ofreciendo las plazas libres de su vehículo, estableciendo fecha, ruta, hora de salida y precio. 

•	Pasajero 🎒: Usuario (mayor de 16 años verificado mediante DNI) que utiliza el sistema para buscar trayectos publicados y reservar una plaza en el vehículo de un conductor. 

•	Pasarela de pago 💳: Sistema de cobro de la aplicación que gestiona las transacciones de forma segura. Retiene el dinero abonado por el pasajero desde la reserva hasta que finaliza el viaje, momento en el cual libera los fondos al conductor, evitando así posibles fraudes. 

•	Precio recomendado 💶: Tarifa sugerida automáticamente por el sistema para asegurar precios justos. Se calcula en base a la distancia, consumo medio del vehículo, extras (como peajes) y la comisión de la plataforma. 

•	Reserva 📅: Acción formal por la cual un pasajero solicita y asegura una plaza en un viaje publicado. Pasa por los estados: Solicitada, Aceptada o Cancelada. 

•	Valoración ⭐: Puntuación (mediante un sistema de estrellas) y comentario textual que un usuario otorga a otro tras finalizar un viaje compartido, con el fin de informar a la comunidad y mantener la seguridad y confianza. 

•	Viaje 📍: Trayecto creado por un conductor definido por un punto de origen y un destino físico específicos. Su ciclo de vida pasa por los estados: Programado, EnCurso, Finalizado o Cancelado. 


## 3. Visión general del sistema
El proyecto consiste en el desarrollo de un sistema para la gestión de transporte compartido, cuyo objetivo principal es conectar al conductor, que realiza cierto viaje con un determinado vehículo, con los pasajeros para la realización del viaje. 
Un viaje está definido por los puntos físicos origen-destino, y cambia de estado en función del momento: Programado, EnCurso, Finalizado, Cancelado.
Para la correcta realización del viaje, se deberá realizar una reserva del mismo, cuyo estado variará entre  Solicitada, Aceptada o Cancelada.
Se continuará con la realización del cobro, mediante la pasarela de pago
El sistema informará del estado del pago con los estados Pendiente, Exitoso o Reembolsado.
La plataforma facilitará para la planificación del viaje el intercambio de mensajes privados entre conductor y pasajeros. Además, incluye un sistema de puntuación para conductores y pasajeros, que permitirá a los usuarios determinar una calificación una vez terminado el viaje.
La interfaz, divide a los usuarios entre 3 roles disjuntos: administrador, pasajero y conductor. Además, esta interfaz debe ser sencilla para facilitar el uso a todo el público, fomentando el uso de vehículos compartidos.


### 3.1. Requisitos generales

#### **RG-001: Facilidad de publicación y búsqueda**

**Como** conductor o pasajero,  
**Quiero** publicar y buscar viajes de la manera más sencilla posible,  
**Para** acordar trayectos compartidos y no tener una planificación complicada.  

<br>

#### **RG-002: Transparencia del viaje**

**Como** pasajero,  
**Quiero** poder ver los detalles del viaje sin necesidad de reservar,  
**Para** poder tomar una decisión con toda la información.   

<br>

#### **RG-003: Consulta de perfiles y valoración**

**Como** conductor o pasajero,  
**Quiero** poder ver los perfiles y valoraciones de los demás usuarios con los que voy a viajar,  
**Para** aumentar la confianza y seguridad previa al viaje.  

<br>

#### **RG-004: Notificaciones y avisos**

**Como** conductor o pasajero,  
**Quiero** recibir recordatorios de mis viajes y avisos de cambios,  
**Para** mantenerme informado en tiempo real sin tener que consultar la plataforma constantemente. 

<br>

#### **RG-005: Atención al cliente**

**Como** usuario,      
**Quiero** tener disponible en todo momento algún medio de comunicación con los administradores,  
**Para** reportar y solucionar problemas de manera rápida en cualquier momento.  

### 3.2. Usuarios del sistema
|**Administrador**| Encargado de revisar y mantener el correcto funcionamiento de la plataforma. Gestiona usuarios (conductores y pasajeros), revisa y modera publicaciones de viajes, resuelve incidencias y garantiza el cumplimiento de las políticas y términos de uso. |
|:--|:--|
|**Conductor** | Usuario que publica los viajes que va a realizar, proporcionando información como la ruta, fecha, hora de salida, número de plazas. Es responsable de ofrecer una experiencia segura y confiable, al igual que mantener a los pasajeros informados de futuros imprevistos(retraso, anulación,...).|
| **Pasajero**| Usuario que busca y reserva una plaza disponible en un viaje publicado. Una vez seleccionado y confirmado el viaje que mejor se adapte a sus necesidades, debe cumplir con las condiciones del conductor, como la puntualidad. |


## 4. Catálogo de requisitos

### 4.1. Requisitos funcionales

#### **RF-01: Crear viajes**
**Como** conductor  
**Quiero** crear viajes    
**Para** que los pasajeros puedan apuntarse mi viaje.

**Prueba de aceptación**
- El sistema debe impedir la creación del viaje si el vehículo no es válido, o la llegada es anterior a la salida o alguna de ellas no es válida.
- El sistema debe impedir que se sobrepase la capacidad del vehículo.
- Se debe aplicar RN-01 y RN-03.   

<br>

#### **RF-02: Reservar viajes**
**Como** pasajero  
**Quiero** reservar todos los viajes que quiera    
**Para** realizar viajes en distintas fechas.

**Prueba de aceptación**
- El sistema no debe permitir la reserva si el viaje no tiene plazas disponibles.
- El sistema debe generar automáticamente un registro de pago asociado a la reserva en estado 'Pendiente'.
- Los pasajeros y conductor pueden ver la confirmación de su viaje y los detalles de la misma.
- Se deben aplicar RN-04 y RN-05.

<br>

#### **RF-03: Chatear**
**Como** conductor y pasajero  
**Quiero** intercambiar mensajes entre conductor y pasajero  
**Para** poder llegar a un acuerdo sobre aspectos del viaje y hacer variaciones en el viaje planteado.

**Prueba de aceptación**
- Mientras la reserva esté reservada, el pasajero y el conductor pueden acceder al chat.
- Los usuarios reciben notificaciones cuando llega un mensaje nuevo.
- Se debe aplicar RN-04.

<br>

#### **RF-04: Valorar**
**Como** conductor y pasajero  
**Quiero** que una vez terminado el viaje, pueda valorar al conductor o pasajero y tener la opción de dejar un comentario sobre la experiencia.  
**Para** que otros usuarios tengan información acerca del usuario.

**Prueba de aceptación**
- El sistema permite al usuario asignar una puntuación en estrellas y añadir un comentario.
- Si el viaje no ha sido completado, no se permiten valoraciones.
- Se debe aplicar RN-06.

<br>

#### **RF-05: Cancelar viaje**
**Como** conductor  
**Quiero** poder cancelar el viaje reservado por pasajeros  
**Para** avisar a los pasajeros que no voy a realizar el viaje y puedan buscar otro viaje.

**Prueba de aceptación**
- El sistema notifica a todos los pasajeros cuando el conductor cancela un viaje.
- Una vez iniciado, el sistema no permite cancelar un viaje.
- Se debe aplicar RN-02.

<br>

#### **RF-06: Cancelar pasajero**
**Como** pasajero  
**Quiero** poder cancelar el viaje que tengo reservado  
**Para** avisar al conductor que no voy a realizar el viaje y dejar una plaza libre para otro pasajero.  


**Prueba de aceptación**
- El sistema libera una plaza cuando un pasajero cancela su reserva.
- El conductor recibe una notificación cuando un pasajero cancela su reserva.
- No se permite cancelar una reserva una vez iniciado el viaje.
- Se debe aplicar RN-02.

<br>

#### **RF-07: Pagar**
**Como** pasajero  
**Quiero** utilizar un método de pago  
**Para** reservar el viaje de forma segura.

**Prueba de aceptación**
- El sistema confirma el pago exitoso y genera un comprobante digital.
- Si el pago falla, el sistema informa del error.
- Se debe aplicar RN-05.

<br>

#### **RF-08: Cobrar**
**Como** conductor  
**Quiero** cobrar el pago realizado  
**Para** obtener beneficio del viaje.

**Prueba de aceptación**
- El sistema liberará el saldo en la cuenta del conductor únicamente cuando el viaje se de por finalizado.
- Se debe aplicar RN-05.

<br>

#### **RF-09: Editar viaje**
**Como** conductor    
**Quiero** tener la posibilidad de editar las características del viaje, tales como el precio, hora o lugar de salida,
**Para** ajustar el viaje a las necesidades acordadas

**Prueba de aceptación**
- El sistema actualiza los cambios realizados y los refleja en la vista pública del viaje.
- Los pasajeros reciben una notificación cuando el conductor modifica el viaje.
- El sistema da error si se intenta modificar un viaje ya iniciado.
- Se debe aplicar RN-01.

<br>

#### **RF-10: Registro de usuario**  
**Como** conductor y pasajero    
**Quiero** identificarme      
**Para** usar la aplicación y acceder a mis viajes.  

**Prueba de aceptación**
- El sistema muestra un mensaje de error si el usuario introduce datos incorrectos al iniciar sesión.
- El usuario debe registrarse introduciendo su nombre, correo electrónico, teléfono y contraseña válidos.
- Se debe aplicar RN-04.

<br>

#### **RF-11: Crear vehículos**  
**Como** conductor,
**Quiero** poder registrar o añadir vehículos con sus características,   
**Para** facilitar la información del vehículo al realizar un viaje.  

**Prueba de aceptación**
- El sistema no permite registrar un vehículo si faltan datos obligatorios o el formato de matrícula es inválido.
- El sistema muestra los viajes que coinciden con los criterios de búsqueda.


<br>

#### **RF-12: Búsqueda de viaje**  
**Como** pasajero,     
**Quiero** un apartado de búsqueda de los puntos de origen y destino,        
**Para** reservar mis viajes.  

**Prueba de aceptación**
- El sistema muestra un mensaje si no se encuentran viajes con los criterios introducidos.
- Se debe aplicar RN-01.

#### 4.1.1. Requisitos de información

#### **RI-01: Usuarios del sistema**
**Como** administrador,  
**Quiero** que exista una identificación de <u>usuario</u>, que permita al <u>administrador</u>, a los <u>pasajeros</u> y a los <u>conductores</u> acceder a su perfil del sistema, mediante un nombre, sus apellidos, email, teléfono y contraseña,  
**Para** permitirles usar correctamente el sistema.  

###### 🧪*Pruebas de aceptación*  
- Un usuario no puede tener asignado más de un rol entre administrador, conductor y pasajero.
- La información podrá modificarse.

<br>

#### **RI-02: Historial de viajes**
**Como** conductor y pasajero,  
**Quiero** un registro de todos los <u>viajes</u> que he realizado en el que pueda ver toda su información: fecha de salida, fecha de llegada, coste por plaza, plazas reservadas, plazas disponibles, estado y distancia. Además, me permitirá ver quién fue el <u>conductor</u>, con qué <u>coche</u> (y su información: matrícula, marca, modelo, plazas y consumo medio) y desde qué <u>punto físico</u> hasta qué otro,  
**Para** llevar un control acerca de mis viajes.  

###### 🧪*Pruebas de aceptación*  
- Los viajes aparecen en el historial una vez se terminen (o se cancelen).
- La información del viaje no puede modificarse.

<br>

#### **RI-03: Viajes reservados**
**Como** conductor y pasajero  
**Quiero** ver cada <u>reserva</u> de viaje que he realizado, con la información acerca del estado y fecha de la misma.  
**Para** poder organizarme y no olvidar el viaje programado.  

###### 🧪*Pruebas de aceptación*  
- Si un viaje se cancela, desaparece del listado y se notifica al usuario.
- Se enviará un mensaje al usuario 24 horas antes del próximo viaje.
- Se debe aplicar RN-01

<br>

#### **RI-04: Valoraciones**
**Como** conductor y pasajero   
**Quiero** conocer las <u>valoraciones</u> que otros usuarios han realizado del viaje que realizamos juntos, incluyendo las estrellas, la fecha y el contenido opcional,  
**Para** saber opiniones tuvieron sobre mí y poder mejorar de cara a próximos viajes.  

###### 🧪*Pruebas de aceptación*  
- No se podrá publicar valoraciones hasta la finalización del viaje.
- El sistema guarda y gestiona correctamente todas las valoraciones recibidas.
- Se debe aplicar RN-06.

<br>

#### **RI-05: Gestión de pagos**
**Como** conductor  
**Quiero** tener  información acerca del estado del <u>pago</u>, que contenga el estado, la fecha y el importe, que vendrá recomendado por esta formula:(distancia (km) * consumo medio(l/100Km)) + extras(peajes) + comisión de CharlaCar(15%)  
**Para** tener un pago seguro y que los viajes estén regidos por un precio justo.  

###### 🧪*Pruebas de aceptación*  
- El sistema debe calcular automáticamente el precio recomendado.
- Se debe aplicar RN-05.
---

#### 4.1.2. Reglas de negocio

#### **RN-01: Fechas válidas**
Solo será posible publicar viajes con la fecha de salida futura y la fecha de llegada posterior a la fecha de salida.

<br>

#### **RN-02: Política de cancelación**
Si un pasajero cancela un viaje 24 horas antes o el conductor hace cambios en la hora o punto de salida y estas no le favorecen se le devolverá el 100% del importe automáticamente, si cancela con menos de 24 horas solo un 50% y si cancela una vez iniciado el viaje o no se presenta, perderá el importe total.  
Si en cambio es el conductor el  que cancela el viaje, su tasa de fiabilidad bajará y esto repercutirá en futuros viajes ya que los pasajeros verán dicha tasa. 
En ambos casos el pasajero/conductor afectado será notificado con un aviso automático.


<br>

#### **RN-03: Validación de conductor**
Un conductor no podrá publicar ningún viaje si aún no ha validado su permiso de conducir y por consiguiente su mayoría de edad. 

<br>

#### **RN-04: Validación de pasajero**
Ningún pasajero podrá reservar un viaje si no supera los 16 años y esto ha sido verificado con su DNI.

<br>

#### **RN-05: Pagos**
El dinero abonado por el pasajero se guardará en la aplicación desde la reserva hasta el fin de viaje (evita fraudes).
    
<br>

#### **RN-06: Valoraciones**
Los conductores pueden publicar valoraciones de los pasajeros que hayan viajado con él. A su vez, los pasajeros sólo pueden publicar valoraciones de los conductores con los que hayan viajado. 

---

### 4.2. Mapa de historias de usuario (opcional)

### 4.3. Requisitos no funcionales (opcional)

#### **RNF-01: Compatibilidad**
**Como** responsable TIC  
**Quiero** que la aplicación esté disponible en Android y en IOS  
**Para** una mayor accesibilidad de nuestros clientes.

<br>

#### **RNF-02: Seguridad**  
**Como** responsable de seguridad  
**Quiero** que solo se muestren los datos necesarios (nombre, recorrido en la aplicación)  
**Para** cumplir con la Ley de Protección de Datos  

<br>

#### **RNF-03: Usabilidad**  
**Como** responsable de ventas  
**Quiero** que la interfaz sea sencilla e intuitiva  
**Para** que los usuarios tengan una experiencia agradable y cómoda  

<br>

#### **RNF-04: Tolerancia**  
**Como** responsable de atención al cliente  
**Quiero** que se pueda soportar un mínimo de 5000 usuarios sin degradar el servicio  
**Para** mejorar la experiencia del cliente  

<br>

#### **RNF-05: Disponibilidad**  
**Como** responsable del servicio  
**Quiero** que el sistema tenga un tiempo de actividad del 99,5% anual  
**Para** que el sistema esté disponible en todo momento a disposición del cliente 

<br>

#### **RNF-06: Robustez**  
**Como** responsable del servicio  
**Quiero** que exista la capacidad de restaurar el servicio ante una caída en menos de 5 minutos  
**Para** mantener la disponibilidad del servicio las 24 horas del día

-- fin entregable 1 --

## 5. Modelo conceptual

### 5.1. Diagramas de clases UML

- con restricciones.

### 5.2. Escenarios de prueba

- con descripción textual y diagrama de objetos UML.

## 6. Matrices de trazabilidad

- Matriz de trazabilidad entre los elementos del modelo conceptual y los requisitos.

|       | EntidadX   | AsociaciónX  | RestricciónX  | Entidad2 ...   | 
|:------|:-----------|:-----------|:-----------|:-----------|
| RI-1  | X          | X          | X          | X          |
| RI-2  |            | X          |            | X          |
| RF-1  |            | X          |            | X          |
| RF-2  | X          |            | X          | X          |
| RN-1  |            | X          |            |            |
| RN-2  | X          | X          | X          |            |
| ...   |            |            |            |            |

-- fin entregable 2 --

## 7. Modelo relacional en 3FN

- Relaciones obtenidas al aplicar la transformación del modelo conceptual.

### 7.1.  Justificación de la estrategia de transformación de jerarquías

- si se identificaron jerarquías en el MC.


### 8. Matriz de trazabilidad MC/SQL (opcional):

- Restricciones sobre el MC / Elementos del modelo tecnológico (SQL) (Triggers, checks, etc.)
- Incluir Reglas de negocio — Constraints/Triggers en las matrices de trazabilidad para el entregable 3

|       | EntidadX   | AsociaciónX  | RestricciónX  | Entidad2 ...   | 
|:-------|:-------|:-------|:-------|:-------|
| TABLA-1 |        |        |        |        |
| TABLA-2 |        |        |        |        |
| TABLA-3 |        |        |        |        |
| TABLA-4 |        |        |        |        |
| TRIG-1 |        |        |        |        |
| TRIG-2 | X      | X      |        | X      |
| TRIG-3 |        | X      |        | X      |
| TRIG-4 |        |        | X      |        |
| CONST-1 |        |        |        |        |
| CONST-2 | X      | X      |        | X      |
| CONST-3 |        | X      |        | X      |
| CONST-4 |        |        | X      |        |

Se consideran todo tipo de constraints declarativas (aquellas definidas durante el CREATE TABLE).
-- fin entregable 3 --

## Referencias


