# Título Proyecto

## Miembros del grupo L2-ABS-5

1. Cantos González, Rubén
1. Márquez Molina, Álvaro
1. Sánchez Gago, Carla
1. Venteo Tapia, Álvaro

## 1. Introducción al problema

- 

## 2. Glosario de términos

- Términos específicos del dominio del problema, ordenados alfabéticamente. Se valorará la presencia de información multimedia.

## 3. Visión general del sistema

### 3.1. Requisitos generales

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
- Descripción de la primera comprobación a realizar
- Descripción de la segunda comprobación a realizar
- Se debe aplicar la regla de negocio R.N.XX.
- ...

<br>

#### **RF-02: Reservar viajes**
**Como** pasajero  
**Quiero** reservar todos los viajes que quiera    
**Para** realizar varios viajes en distintas fechas.

**Prueba de aceptación**
- Descripción de la primera comprobación a realizar
- Descripción de la segunda comprobación a realizar
- Se debe aplicar la regla de negocio R.N.XX.
- ...

<br>

#### **RF-03: Chatear**
**Como** conductor y pasajero  
**Quiero** acceder a un chat conductor-pasajero  
**Para** poder hablar acerca de la hora de salida u otros aspectos del viaje, poder llegar a un acuerdo entre todas las partes y hacer variaciones en el viaje planteado.

**Prueba de aceptación**
- Descripción de la primera comprobación a realizar
- Descripción de la segunda comprobación a realizar
- Se debe aplicar la regla de negocio R.N.XX.
- ...

<br>

#### **RF-04: Valorar**
**Como** conductor y pasajero  
**Quiero** poder valorar al conductor o pasajero una vez terminado el viaje, además de publicar un comentario explicando mi experiencia  
**Para** que otros usuarios tengan información acerca del usuario.

**Prueba de aceptación**
- Descripción de la primera comprobación a realizar
- Descripción de la segunda comprobación a realizar
- Se debe aplicar la regla de negocio R.N.XX.
- ...

<br>

#### **RF-05: Cancelar Conductor**
**Como** conductor  
**Quiero** poder cancelar el viaje que reservado  
**Para** avisar a los pasajeros que no voy a realizar el viaje y puedan buscar otro.

**Prueba de aceptación**
- Descripción de la primera comprobación a realizar
- Descripción de la segunda comprobación a realizar
- Se debe aplicar la regla de negocio R.N.XX.
- ...

<br>

#### **RF-06: Cancelar Pasajero**
**Como** pasajero 
**Quiero** poder cancelar el viaje que tengo reservado  
**Para** avisar al conductor que no voy a realizar el viaje y dejar una plaza libre para otro pasajero.


**Prueba de aceptación**
- Descripción de la primera comprobación a realizar
- Descripción de la segunda comprobación a realizar
- Se debe aplicar la regla de negocio R.N.XX.
- ...

<br>

#### **RF-07: Pagar**
**Como** pasajero  
**Quiero** utilizar un método de pago  
**Para** reservar el viaje de forma segura.

**Prueba de aceptación**
- Descripción de la primera comprobación a realizar
- Descripción de la segunda comprobación a realizar
- Se debe aplicar la regla de negocio R.N.XX.
- ...

<br>

#### **RF-08: Cobrar**
**Como** conductor  
**Quiero** cobrar el pago realizado  
**Para** rentar el viaje.

**Prueba de aceptación**
- Descripción de la primera comprobación a realizar
- Descripción de la segunda comprobación a realizar
- Se debe aplicar la regla de negocio R.N.XX.
- ...

<br>

#### **RF-09: Editar viaje**
**Como** conductor    
**Quiero** tener la posibilidad de editar las características del viaje, como el precio, hora o lugar de salida,
**Para** ajustar el viaje a las necesidades previo acuerdo con el pasajero.

**Prueba de aceptación**
- Descripción de la primera comprobación a realizar
- Descripción de la segunda comprobación a realizar
- Se debe aplicar la regla de negocio R.N.XX.
- ...

<br>

#### **RF-010: Registro de usuario**  
**Como** conductor y pasajero    
**Quiero** identificarme      
**Para** usar la aplicación y acceder a mis viajes.  

**Prueba de aceptación**
- Descripción de la primera comprobación a realizar
- Descripción de la segunda comprobación a realizar
- Se debe aplicar la regla de negocio R.N.XX.
- ...
jij
<br>

#### **RF-11: Crear vehículos**  
**Como** conductor,
**Quiero** poder registrar o añadir vehículos con sus características,   
**Para** facilitar la información del vehículo al realizar un viaje.  

**Prueba de aceptación**
- Descripción de la primera comprobación a realizar
- Descripción de la segunda comprobación a realizar
- Se debe aplicar la regla de negocio R.N.XX.
- ...

<br>

#### **RF-12: Búsqueda de Viaje**  
**Como** pasajero,     
**Quiero** un apartado de búsqueda de los puntos de origen y destino,        
**Para** reservar mis viajes.  

**Prueba de aceptación**
- Descripción de la primera comprobación a realizar
- Descripción de la segunda comprobación a realizar
- Se debe aplicar la regla de negocio R.N.XX.
- ...

#### 4.1.1. Requisitos de información

##### R.I.01. Título requisito de información

Como [tipo de usuario]
quiero [servicio]
para [razón]

**Prueba de aceptación**
- Descripción de la primera comprobación a realizar
- Descripción de la segunda comprobación a realizar
- ...

#### 4.1.2. Reglas de negocio

#### **RN-01: Fechas válidas**
Solo será posible publicar viajes con la fecha de salida futura y la fecha de llegada posterior a la fecha de salida.


#### **RN-02: Política de cancelación**
Si un pasajero cancela un viaje 24 horas antes o el conductor hace cambios en la hora o punto de salida y estas no le favorecen se le devolverá el 100% del importe automáticamente, si cancela con menos de 24 horas solo un 50% y si cancela una vez iniciado el viaje o no se presenta, perderá el importe total.  
Si es el conductor el que cancela el viaje, su tasa de fiabilidad bajará y esto repercutirá en futuros viajes. 


#### **RN-03: Validación de conductor**
Un conductor no podrá publicar ningún viaje si no ha validado su permiso de conducir y su mayoría de edad. 


#### **RN-04: Validación de pasajero**
Ningún pasajero podrá reservar un viaje si no supera los 16 años y esta validado su DNI.

#### **RN-05: Pagos**
El dinero abonado por el pasajero se guardará en la aplicación desde la reserva hasta el fin de viaje para evitar fraudes.


#### **RN-06: Valoraciones**
Los conductores pueden publicar valoraciones de los pasajeros que hayan viajado con él,y los pasajeros sólo pueden publicar valoraciones de los conductores con los que hayan viajado.

### 4.2. Mapa de historias de usuario (opcional)

### 4.3. Requisitos no funcionales (opcional)

**R.N.F. 01. Título requisito no funcional**
Como [tipo de usuario]
quiero [servicio]
para [razón]

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


