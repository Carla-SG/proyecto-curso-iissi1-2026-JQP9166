# CharlaCar

## Miembros del grupo L2-ABS-5

1. Cantos González, Rubén
1. Márquez Molina, Álvaro
1. Sánchez Gago, Carla
1. Venteo Tapia, Álvaro

## 1. Introducción al problema

El modelo actual de transporte interurbano y urbano a menudo se enfrenta a problemas como el alto coste económico de los desplazamientos individuales, la congestión del tráfico y un impacto ambiental negativo debido a la alta emisión de gases contaminantes. A su vez, muchos conductores realizan trayectos diarios o esporádicos con asientos vacíos en sus vehículos, mientras que existen personas buscando alternativas de transporte eficientes, económicas y directas para esas mismas rutas.

CharlaCar nace como una solución tecnológica orientada a la economía colaborativa para resolver este problema. El proyecto propone el desarrollo de un sistema integral de transporte compartido que conecta de forma rápida y segura a conductores con plazas disponibles y pasajeros que necesitan realizar el mismo viaje. A través de una plataforma accesible e intuitiva, los usuarios podrán gestionar la publicación, búsqueda y reserva de trayectos de manera transparente. Además, el sistema centraliza la comunicación y los pagos, ofreciendo un entorno confiable que se sustenta en la verificación de usuarios y un sistema de valoraciones cruzadas, fomentando así un uso más sostenible, económico y social de los vehículos. 

### Ejemplo práctico

Imagina a Carlos, un estudiante universitario que viaja todos los viernes de Sevilla a Cádiz en su propio vehículo. Realizar este trayecto en solitario le supone un gasto elevado en combustible y peajes (unos 25 € por viaje), manteniendo 4 asientos vacíos en el coche. Al mismo tiempo, Elena necesita realizar esa misma ruta a esa misma hora, pero el billete de tren es caro y los horarios de autobús son ineficientes.

A través de CharlaCar, Carlos puede publicar sus plazas libres calculando un precio justo recomendado por la plataforma. Elena encuentra el viaje, reserva su plaza y paga de forma segura. De esta manera, Carlos amortiza los gastos del desplazamiento, Elena viaja de forma cómoda y económica, y se evita la circulación de un vehículo adicional en la carretera.

## 2. Glosario de términos

•	**Administrador** 🛡️: Perfil encargado de revisar y mantener el correcto funcionamiento de la plataforma, gestionar incidencias, moderar viajes y asegurar que se cumplan las normativas de la aplicación.

•	**Chat** 💬: Herramienta de comunicación interna de la plataforma que permite a conductores y pasajeros intercambiar mensajes una vez confirmada una reserva, facilitando la coordinación de detalles como el punto exacto de encuentro. 

•	**Conductor** 🚗: Usuario mayor de edad y con permiso de conducir validado, que publica un trayecto ofreciendo las plazas libres de su vehículo, estableciendo fecha, ruta, hora de salida y precio. 

•	**Pasajero** 🎒: Usuario (mayor de 16 años verificado mediante DNI) que utiliza el sistema para buscar trayectos publicados y reservar una plaza en el vehículo de un conductor. 

•	**Pasarela de pago** 💳: Sistema de cobro de la aplicación que gestiona las transacciones de forma segura. Retiene el dinero abonado por el pasajero desde la reserva hasta que finaliza el viaje, momento en el cual libera los fondos al conductor, evitando así posibles fraudes. 

•	**Precio recomendado** 💶: Tarifa sugerida automáticamente por el sistema para asegurar precios justos. Se calcula en base a la distancia, consumo medio del vehículo, extras (como peajes) y la comisión de la plataforma. 

•	**Reserva** 📅: Acción formal por la cual un pasajero solicita y asegura una plaza en un viaje publicado. Pasa por los estados: Solicitada, Aceptada o Cancelada. 

•	**Valoración** ⭐: Puntuación (mediante un sistema de estrellas) y comentario textual que un usuario otorga a otro tras finalizar un viaje compartido, con el fin de informar a la comunidad y mantener la seguridad y confianza. 

•	**Viaje** 📍: Trayecto creado por un conductor definido por un punto de origen y un destino físico específicos. Su ciclo de vida pasa por los estados: Programado, EnCurso, Finalizado o Cancelado. 


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

#### **RF-01: Consultas de viajes**
**Como** conductor y pasajero,  
**Quiero** ver los viajes disponibles actualmente que vayan desde un punto físico a otro,   
**Para** comprobar si algún viaje se ajusta a mis necesidades.

**Prueba de aceptación**
- No aparecerán los viajes finalizados ni cancelados.
- Aparecerán ordenados por fecha de salida.

<br>

#### **RF-02: Consultas de cancelaciones**
**Como** conductor  
**Quiero** que al cancelar un viaje, el sistema consulte que el viaje no ha comenzado ni que ya esté cancelado,    
**Para** no crear errores ni notificaciones falsas.

**Prueba de aceptación**
- Podemos cancelar un viaje no iniciado y no cancelado. 
- Una vez iniciado, el sistema no permite cancelar un viaje.
- Se debe aplicar RN-02.

<br>

#### **RF-03: Consultas de reservas**
**Como** pasajero  
**Quiero** que al reservar un viaje, el sistema consulte si hay plazas disponibles,     
**Para** realizar el viaje sin problemas.  

**Prueba de aceptación**
- El sistema no debe permitir la reserva si el viaje no tiene plazas disponibles.
- Los pasajeros y conductor pueden ver la confirmación de su viaje y los detalles de la misma.

<br>

#### **RF-04: Consultas de mensajes**
**Como** conductor y pasajero  
**Quiero** consultar los mensajes intercambiados entre conductor y pasajero  
**Para** poder comprobar los cambios realizados.

**Prueba de aceptación**
- No se bloqueará la consulta aun si el viaje se ha cancelado.
- Se mostrarán todos los mensajes intercambiados.

<br>

#### **RF-05: Consultas de valoraciones**
**Como** conductor y pasajero  
**Quiero** que al reservar un viaje, el sistema consulte las últimas valoraciones de cada usuario y la muestre,   
**Para** tener información acerca del usuario con el que voy a viajar.  

**Prueba de aceptación**
- El sistema mostrará 3 valoraciones por usuario.
- Si no se disponen valoraciones de un usuario, saldrá un mensaje indicándolo.
- Se debe aplicar RN-06.

<br>

#### **RF-06: Consultas de pagos**
**Como** pasajero  
**Quiero** consultar los pagos que he realizado en la plataforma, 
**Para** comprobar los precios que pagué por otros viajes.

**Prueba de aceptación**
- El sistema muestra los pagos realizados, pendientes y cancelados.  
- Se debe aplicar RN-05.

<br>

#### **RF-07: Consulta de usuarios**  
**Como** administrador    
**Quiero** consultar los usuarios registrados en la plataforma,       
**Para** manejar los perfiles registrados y crear estadísticas.

**Prueba de aceptación**
- El sistema muestra los pasajeros, conductores y administradores registrados.
- No se mostrará un usuario duplicado.

<br>

#### **RF-08: Consultas de vehículos**  
**Como** conductor,  
**Quiero** consultar los vehículos disponibles para un viaje,   
**Para** elegir el más adecuado para un viaje.  

**Prueba de aceptación**
- El sistema no muestra un vehículo si faltan datos obligatorios o el formato de matrícula es inválido.
- El sistema muestra los vehículos libres para ese viaje.

<br>

#### **RF-9: Búsqueda de viaje**  
**Como** pasajero,     
**Quiero** un apartado de búsqueda de los puntos de origen y destino,        
**Para** reservar mis viajes.  

**Prueba de aceptación**
- El sistema muestra un mensaje si no se encuentran viajes con los criterios introducidos.
- Se debe aplicar RN-01.

<br>

#### **RF-10:Consultas motivos de cancelación**  
**Como** pasajero,     
**Quiero** ver la razón de cancelación de mi viaje,        
**Para** conocer el por qué de la anulación.  

**Prueba de aceptación**
- El sistema muestra la justificación al anular el viaje.
- Se debe aplicar RN-02.

<br>

#### **RF-11: Consultas de viaje por rango de fechas**  
**Como** pasajero y conductor,     
**Quiero** filtrar los viajes disponibles dentro de un rango concreto de fechas,        
**Para** planificar mis viajes en un periodo específico.  

**Prueba de aceptación**
- El sistema validar-a que la fecha de inicio no sea posterior a la fecha de fin.
- Solo se mostrarán los viajes cuya fecha de salida esté dentro del rango establecido.
- Se debe aplicar RN-01.

<br>

#### **RF-12: Consulta de viajes por localidad origen**  
**Como** pasajero,     
**Quiero** encontrar los viajes disponibles filtrando por la localidad de origen,        
**Para** encontrar trayectos que salgan exactamente del sitio filtrado.  

**Prueba de aceptación**
- El sistema mostrará todos los viajes activos cuyo campo o punto de salida coincida con la localidad introducida.  
- Si no existen trayectos, se mostrará un aviso informando que no hay salidas disponibles.  
- Se debe aplicar RN-01.

### 4.1.1. Requisitos de información

#### **RI-01: Usuarios del sistema**
**Como** administrador,  
**Quiero** que exista una identificación de <u>usuario</u>, que permita al <u>administrador</u>, a los <u>pasajeros</u> y a los <u>conductores</u> acceder a su perfil del sistema, mediante un nombre, sus apellidos, email, teléfono y contraseña,  
**Para** permitirles usar correctamente el sistema.  

###### 🧪*Pruebas de aceptación*  
- Un usuario no puede tener asignado más de un rol entre administrador, conductor y pasajero.
- La información podrá modificarse.

<br>

#### **RI-02: Viajes**
**Como** conductor y pasajero,  
**Quiero** un registro de los <u>viajes</u> en los que he perticipado, voy a participar o se han cancelado en el que pueda ver toda su información: fecha de salida, fecha de llegada, coste por plaza, plazas reservadas, plazas disponibles, estado y distancia. Además, me permitirá ver al <u>conductor</u> (el cuál tendrá verificado su carnet de conduccir, además de haber subido una foto de su carnet y tendrá una valoración media), con qué <u>vehículo</u> (y su información: matrícula, marca, modelo, plazas y consumo medio) y desde qué <u>punto físico</u> hasta qué otro,  
**Para** llevar un control acerca de mis viajes.  

###### 🧪*Pruebas de aceptación*  
- Puedo ver todos los viajes que realicé.
- La información de los viajes no puede modificarse.

<br>

#### **RI-03: Punto Físico**
**Como** conductor y pasajero,  
**Quiero** ver los <u>puntos físicos</u> desde donde parte y a donde llega un viaje en el que participo, donde podré ver la dirección, localidad, provincia, país u código postal,   
**Para** poder determinar si me conviene o no realizar el viaje.  

###### 🧪*Pruebas de aceptación*  
- No existirán dos puntos físicos con las mismas entradas (no se permiten puntos físicos duplicados).
- Un viaje no puede partir y llegar al mismo punto físico.

<br>

#### **RI-04: Reservas de viajes**
**Como** conductor y pasajero  
**Quiero** ver cada <u>reserva</u> de viaje que he realizado, con la información acerca del estado y fecha de la misma.  
**Para** poder organizarme y no olvidar el viaje programado.  

###### 🧪*Pruebas de aceptación*  
- Si un viaje se cancela, desaparece del listado.
- Puedo comprobar toda la información de los viajes.

<br>

#### **RI-05: Valoraciones**
**Como** conductor y pasajero   
**Quiero** conocer las <u>valoraciones</u> que otros usuarios han realizado del viaje que realizamos juntos, incluyendo las estrellas, la fecha y el contenido opcional,  
**Para** saber opiniones tuvieron sobre mí y poder mejorar de cara a próximos viajes.  

###### 🧪*Pruebas de aceptación*  
- No se podrá publicar valoraciones hasta la finalización del viaje.
- El sistema guarda y gestiona correctamente todas las valoraciones recibidas.
- Se debe aplicar RN-06.

<br>

#### **RI-06: Mensajes**
**Como** conductor y pasajero   
**Quiero** intercambiar <u>mensajes</u> con los otros usuarios con los que voy a realizar un viaje,  
**Para** concretar aspectos del viaje. 

###### 🧪*Pruebas de aceptación*  
- No se podrá enviar mensajes si el viaje ha finalizado.
- Los mensajes no podrán ser eliminados.

<br>

#### **RI-07: Pagos**
**Como** conductor y pasajero,  
**Quiero** tener  información acerca del estado del <u>pago</u>, que contenga el estado, la fecha y el importe, que vendrá recomendado para el creador del viaje por esta formula:(distancia (km) * consumo medio(l/100Km)) + extras(peajes) + comisión de CharlaCar(15%).  
**Para** tener un pago seguro y que los viajes estén regidos por un precio justo.  

###### 🧪*Pruebas de aceptación*  
- El sistema debe calcular automáticamente el precio recomendado.
- Se debe aplicar RN-05.
---

### 4.1.2. Reglas de negocio

#### **RN-01: Fechas válidas**
Solo será posible publicar viajes con la fecha de salida futura y la fecha de llegada posterior a la fecha de salida.  

###### 🧪*Pruebas de aceptación*  
- Si intento publicar un viaje que sale mañana a las 18:00 y que llega a las 20:00, el sistema me permite publicarlo.  
- Si intento publicar un viaje que sale mañana a las 18:00 y que llega hoy, el sistema NO me permite publicarlo.  

<br>

#### **RN-02: Política de cancelación**
Si un pasajero cancela un viaje 24 horas antes o el conductor hace cambios en la hora o punto de salida y estas no le favorecen se le devolverá el 100% del importe automáticamente, si cancela con menos de 24 horas solo un 50% y si cancela una vez iniciado el viaje o no se presenta, perderá el importe total.  
Si en cambio es el conductor el  que cancela el viaje, su tasa de fiabilidad bajará y esto repercutirá en futuros viajes ya que los pasajeros verán dicha tasa. 
En ambos casos el pasajero/conductor afectado será notificado con un aviso automático.

###### 🧪*Pruebas de aceptación*  
- Al cancelar un viaje 12 horas antes de su inicio, el sistema me devuelve la mitad del importe.  
- Si cancelo un viaje que ya ha iniciado, el sistema no me devuelve nada del importe.  

<br>

#### **RN-03: Validación de conductor**
Un conductor no podrá publicar ningún viaje ni ejercer de conductor u¡en uno si aún no ha validado su permiso de conducir y por consiguiente su mayoría de edad. 

###### 🧪*Pruebas de aceptación*  
- Si tengo validado el carnet de conducir e intento publicar un viaje, el sistema me permitirá publicarlo.  
- Si no tengo validado el carnet de conducir e intento un viaje, el sistema NO me lo permitirá.  

<br>

#### **RN-04: Validación de usuario**
Ningún usuario podrá registrarse si no supera los 16 años y esto ha sido verificado con su DNI.

###### 🧪*Pruebas de aceptación*  
- Puedo registrarme sin ningún problema si soy un usuario de 17 años.  
- No puedo registrarme si lo intento y tengo 15 años.  

<br>

#### **RN-05: Pagos**
El dinero abonado por el pasajero se guardará en la aplicación desde la reserva hasta el fin de viaje (evita fraudes).

###### 🧪*Pruebas de aceptación*  
- Fui el conductor de un viaje que finalizó hace una semana, el sistema ya me ha abonado el importe.
- Voy a ser el conductor de un viaje programado para la semana que viene, y el sistema no me abona el importe.

<br>

#### **RN-06: Valoraciones**
Los conductores pueden publicar valoraciones de los pasajeros que hayan viajado con él. A su vez, los pasajeros sólo pueden publicar valoraciones de los conductores con los que hayan viajado. 

###### 🧪*Pruebas de aceptación*  
- Ayer viajé como pasajero de un viaje, y el sistema me permite valorar al conductor del mismo.  
- La semana que viene voy a realizar un viaje, el sistema aún no me permite valorar al conductor.  

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

|       | Usuario   | Conductor  | Pasajero  | Vehículo  | Viaje  | Reserva  | Pago  | Valoración  | Mensaje  | Punto Físico  |
|:-------|:-----------|:-----------|:-----------|:-----------|:-----------|:-----------|:-----------|:-----------|:-----------|:-----------|
| RI-01  | X          | X          | X          |            |            |            |            |            |            |            |
| RI-02  |            | X          | X          | X          | X          |           |           |          |           | X          |
| RI-03  |            | X          |      X      |           | X          |           |           |           |           | X         |
| RI-04  |            | X          |     X       |           | X          | X          |           |           |          |           |
| RI-05  |            | X          |  X          |           | X          |           | X          | X          |           |           |
| RI-06  |            | X          |            | X          | X          | X          | X          | X          | X          | X          |
| RI-07  |            | X          |            | X          | X          | X          | X          | X          | X          | X          |
| RF-1   |            | X          |            | X          | X          | X          | X          | X          | X          | X          |
| RF-2   | X          |            | X          | X          | X          | X          | X          | X          | X          | X          |
| RF-3   |            | X          |            | X          | X          | X          | X          | X          | X          | X          |
| RF-4   |            | X          |            | X          | X          | X          | X          | X          | X          | X          |
| RF-5   |            | X          |            | X          | X          | X          | X          | X          | X          | X          |
| RF-6   |            | X          |            | X          | X          | X          | X          | X          | X          | X          |
| RF-7   |            | X          |            | X          | X          | X          | X          | X          | X          | X          |
| RF-8   |            | X          |            | X          | X          | X          | X          | X          | X          | X          |
| RF-9   |            | X          |            | X          | X          | X          | X          | X          | X          | X          |
| RF-10  |            | X          |            | X          | X          | X          | X          | X          | X          | X          |
| RF-11  |            | X          |            | X          | X          | X          | X          | X          | X          | X          |
| RF-12  |            | X          |            | X          | X          | X          | X          | X          | X          | X          |
| RN-1   |            | X          |            |            | X          | X          | X          | X          | X          | X          |
| RN-2   | X          | X          | X          |            | X          | X          | X          | X          | X          | X          |
| RN-3   | X          | X          | X          |            | X          | X          | X          | X          | X          | X          |
| RN-4   | X          | X          | X          |            | X          | X          | X          | X          | X          | X          |
| RN-5   | X          | X          | X          |            | X          | X          | X          | X          | X          | X          |
| RN-6   | X          | X          | X          |            | X          | X          | X          | X          | X          | X          |

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


