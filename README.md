# CharlaCar

## Miembros del grupo L2-ABS-5

1. Cantos González, Rubén
1. Márquez Molina, Álvaromm
1. Sánchez Gago, Carla
1. Venteo Tapia, Álvaron

## 1. Introducción al problema

- 

## 2. Glosario de términos

- Términos específicos del dominio del problema, ordenados alfabéticamente. Se valorará la presencia de información multimedia.

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

#### **RF-01: Crear Viajes**
**Como** conductor  
**Quiero** crear viajes    
**Para** que los pasajeros puedan apuntarse mi viaje.

**Prueba de aceptación**
- El sistema debe impedir la creación del viaje si la llegada es anterior a la salida o la fecha de salida no es futura.
- El sistema debe impedir la creación del viaje si las plazas publicadas superan la capacidad real del vehículo.
- Se debe aplicar RN-01 y RN-03.   

<br>

#### **RF-02: Reservar viajes**
**Como** pasajero  
**Quiero** reservar todos los viajes que quiera    
**Para** realizar varios viajes en distintas fechas.

**Prueba de aceptación**
- El sistema debe impedir la reserva si el viaje no tiene plazas disponibles.
- El sistema debe generar automáticamente un registro de pago en estado 'Pendiente' asociado a la reserva.
- El pasajero puede ver la confirmación de su viaje y los detalles de la misma.
- Se debe aplicar RN-04 y RN-05.

<br>

#### **RF-03: Chatear**
**Como** conductor y pasajero  
**Quiero** acceder a un chat conductor-pasajero  
**Para** poder hablar acerca de la hora de salida u otros aspectos del viaje, poder llegar a un acuerdo entre todas las partes y hacer variaciones en el viaje planteado.

**Prueba de aceptación**
- El pasajero y el conductor pueden acceder al chat siempre que la reserva esté confirmada.
- Los usuarios reciben notificaciones cuando llega un mensaje nuevo.
- Se debe aplicar RN-04.

<br>

#### **RF-04: Valorar**
**Como** conductor y pasajero  
**Quiero** poder valorar al conductor o pasajero una vez terminado el viaje, además de publicar un comentario explicando mi experiencia  
**Para** que otros usuarios tengan información acerca del usuario.

**Prueba de aceptación**
- El sistema permite al conductor o pasajero asignar una puntuación en estrellas y añadir un comentario.
- El usuario no puede valorar un viaje que no haya completado.
- Se debe aplicar RN-06.

<br>

#### **RF-05: Cancelar Conductor**
**Como** conductor  
**Quiero** poder cancelar el viaje que reservado  
**Para** avisar a los pasajeros que no voy a realizar el viaje y puedan buscar otro.

**Prueba de aceptación**
- El sistema notifica a todos los pasajeros cuando el conductor cancela un viaje.
- El sistema no permite cancelar un viaje una vez iniciado.
- Se debe aplicar RN-02.

<br>

#### **RF-06: Cancelar Pasajero**
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
**Para** rentar el viaje.

**Prueba de aceptación**
- El sistema debe liberar el saldo en la cuenta del conductor únicamente cuando la fecha y hora de llegada del viaje haya pasado.
- Se debe aplicar RN-05.

<br>

#### **RF-09: Editar viaje**
**Como** conductor    
**Quiero** tener la posibilidad de editar las características del viaje, como el precio, hora o lugar de salida,
**Para** ajustar el viaje a las necesidades previo acuerdo con el pasajero.

**Prueba de aceptación**
- El sistema actualiza los cambios realizados y los refleja en la vista pública del viaje.
- Los pasajeros reciben una notificación cuando el conductor modifica el viaje.
- El sistema da error si se intenta modificar un viaje ya iniciado.
- Se debe aplicar RN-01.

<br>

#### **RF-010: Registro de usuario**  
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
- El sistema muestra un mensaje si no se encuentran viajes con los criterios introducidos.

<br>

#### **RF-12: Búsqueda de Viaje**  
**Como** pasajero,     
**Quiero** un apartado de búsqueda de los puntos de origen y destino,        
**Para** reservar mis viajes.  

**Prueba de aceptación**
- El sistema muestra un mensaje si no se encuentran viajes con los criterios introducidos.
- Se debe aplicar RN-01.

#### 4.1.1. Requisitos de información

#### **RI-01: Historial de Viajes**
**Como** conductor y pasajero  
**Quiero** poder ver un registro de todas las rutas en las que he participado, con toda su respectiva información (rol, lugar y fecha de salida y llegada, precio, etc.)  
**Para** poder llevar un control acerca de los viajes que he realizado.

###### 🧪*Pruebas de aceptación*  
- Las rutas aparecen en el historial una vez se terminen o se cancelen.
- La información mostrada (rol, lugar, fechas, precio, etc.) no puede modificarse.

<br>

#### **RI-02: Próximos Viajes**
**Como** conductor y pasajero  
**Quiero** tener un listado con los futuros viajes que tengo reservados, con su respectiva información  
**Para** recordar las fechas y poder organizarme

###### 🧪*Pruebas de aceptación*  
- Si un viaje se cancela, desaparece del listado y se notifica al usuario.
- Se enviará un mensaje al usuario 24 horas antes del próximo viaje.
- Se debe aplicar RN-01

<br>

#### **RI-03: Historial de Valoraciones**
**Como** conductor y pasajero  
**Quiero** conocer todas las valoraciones que otros usuarios (relación conductor-pasajero) han realizado acerca del viaje que realizaron conmigo  
**Para** saber opiniones y sensaciones sobre mí y poder mejorar.

###### 🧪*Pruebas de aceptación*  
- No se podrá publicar valoraciones hasta la finalización del viaje.
- El sistema guarda y gestiona correctamente todas las valoraciones recibidas.
- Se debe aplicar RN-06.

<br>

#### **RI-04: Gestión de Notificaciones**
**Como** conductor y pasajero  
**Quiero** recibir notificaciones sobre los cambios y recordatorios del viaje  
**Para** estar informado.

###### 🧪*Pruebas de aceptación*  
- El sistema debe generar una alerta automática para el pasajero si el estado del viaje cambia a 'Cancelado' o si se modifica la hora de salida.
- Se debe aplicar RN-06.

<br>

#### **RI-05: Gestión de pagos**
**Como** administrador  
**Quiero** que el conductor reciba un precio recomendado para su viaje definido por esta formula:(distancia (km) * consumo medio(l/100Km)) + extras(peajes) + comisión de RideLink(15%)  
**Para** que los viajes estén regidos por un precio justo.

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


