# Cuenta Única Ciudadana: guía de integración

Guía simplificada de integración con CUC para instituciones.

## Tabla de contenidos

- [Cuenta Única Ciudadana: guía de integración](#cuenta-única-ciudadana-guía-de-integración)
- [Tabla de contenidos](#tabla-de-contenidos)
- [Introducción](#introducción)
  - [OAuth: La Llave Maestra de la Autorización](#oauth-la-llave-maestra-de-la-autorización)
  - [OpenID Connect: La Identidad Verificada en Acción](#openid-connect-la-identidad-verificada-en-acción)
  - [ORY Network: La Red que Enlaza Todo](#ory-network-la-red-que-enlaza-todo)
  - [Importancia](#importancia)
- [Solicitud de cliente OAuth](#solicitud-cliente-oauth)
- [Integración desde cero](#integración-desde-cero)
- [Integración con autenticación ya existente](#integración-con-autenticación-ya-existente)
- [Ejemplos de integración](#ejemplos-de-integración)

## Introducción

¡Bienvenidos a la emocionante travesía de integrar tu sistema con la Cuenta Única Ciudadana (CUC) en la República Dominicana! En esta guía, te llevaremos de la mano a través de los pasos clave para lograr una integración exitosa. Pero antes de sumergirnos en los detalles, es esencial comprender los protagonistas principales de esta historia tecnológica: OAuth, OpenID Connect y ORY Network.

### OAuth: La llave maestra de la autorización

Imagine que OAuth es como la llave maestra que permite a tu sistema acceder de manera segura a la CUC. Este protocolo es la puerta de entrada para autorizar y validar usuarios de manera eficiente. Piensa en ello como la llave que abre la puerta digital, permitiendo a tu sistema interactuar con la CUC sin comprometer la seguridad.

### OpenID Connect: La identidad verificada en acción

Ahora, imagina que OpenID Connect es el guardián de la identidad. No solo abre la puerta, sino que también verifica la identidad de quienes entran. Es como la credencial que asegura que los usuarios son quienes dicen ser. Gracias a OpenID Connect, tu sistema puede obtener información de identidad verificada de manera segura desde la CUC.

### ORY Network: La red que enlaza todo

Finalmente, entra en escena ORY Network, el tejido que conecta todos los elementos. ORY Network es como el coordinador detrás de escena que asegura que OAuth y OpenID Connect trabajen juntos sin problemas. Es el director de la orquesta que garantiza una integración armoniosa, permitiendo que tu sistema y la CUC se comuniquen de manera eficiente y segura.

### Importancia

Ahora, ¿por qué son tan importantes estos actores en nuestra guía de integración? La respuesta es simple y poderosa: aseguran la seguridad, eficiencia y confiabilidad de todo el proceso. OAuth garantiza que solo las personas autorizadas accedan a la CUC. OpenID Connect verifica la identidad de manera robusta. Y ORY Network facilita la conexión entre todos, asegurando que la integración sea como una danza perfectamente coordinada.

Así que, mientras avanzamos en esta guía, recuerda que OAuth, OpenID Connect y ORY Network son tus aliados en esta aventura. Juntos, hacen posible que tu sistema y la Cuenta Única Ciudadana trabajen en armonía, allanando el camino hacia una experiencia digital segura, eficiente y confiable para todos. ¡Vamos a sumergirnos en el fascinante mundo de la integración!

## Solicitud cliente OAuth

Para una mejor compresión, hemos divido en pasos el proceso de solicitud del cliente OAuth:

### Paso 1: Iniciando el contacto

La institución interesada en la integración se comunica con el Departamento de Arquitectura. Durante este contacto inicial, la institución expresa su interés en integrarse con la CUC y solicita información sobre el proceso.

### Paso 2: Creación de la solicitud oficial

La institución prepara una solicitud oficial que incluye detalles clave:

1. Propósito de la integración
2. Descripción general de los servicios que desea integrar.
3. Información técnica básica sobre su sistema.

### Paso 3: Envío de la solicitud

La institución envía la solicitud oficial al Departamento de Arquitectura. El departamento revisa la solicitud para garantizar que esté completa y proporciona la información necesaria.

### Paso 4: Creación del cliente OAuth en ambiente de prueba

Una vez aprobada la solicitud, el Departamento de Arquitectura procede a crear un cliente OAuth en el ambiente de prueba específicamente para la institución solicitante. Se proporcionan las credenciales del cliente (ID de cliente y secreto compartido) a la institución.

### Paso 5: Comunicación con el equipo de desarrollo

La institución comparte las credenciales del cliente con su equipo de desarrollo. El equipo de desarrollo utiliza estas credenciales para configurar la autenticación y autorización en su sistema.

### Paso 6: Inicio del flujo de integración

Con las credenciales del cliente, el equipo de desarrollo inicia el flujo de integración en el ambiente de prueba.
Se realizan pruebas exhaustivas para garantizar que la comunicación entre el sistema de la institución y la CUC sea exitosa.

¡Listo! Con estos pasos, la institución ha iniciado el proceso de integración de manera segura y controlada. El Departamento de Arquitectura de OGTIC está disponible para brindar orientación y soporte técnico en cada fase de este emocionante viaje hacia la integración con la Cuenta Única Ciudadana. ¡Que comience la colaboración digital!

## Integración desde cero

Si tu institución está comenzando desde cero, sin una solución de autenticación previa, sigue esta guía paso a paso para implementar OAuth y OpenID Connect de manera exitosa.

### Paso 1: Entendiendo OAuth y OpenID Connect

Antes de comenzar, asegúrate de comprender los conceptos básicos de OAuth y OpenID Connect:

**OAuth**: Protocolo para autorización, permitiendo a tu sistema acceder a la CUC de manera segura.
**OpenID Connect**: Capa de autenticación sobre OAuth, proporcionando identidad verificada del usuario.

### Paso 2: Configuración inicial en ambiente de prueba

Utiliza las credenciales del cliente OAuth proporcionadas por el Departamento de Arquitectura para configurar tu sistema en el ambiente de prueba. Familiarízate con los endpoints OAuth y OpenID Connect proporcionados por la CUC.

### Paso 3: Implementación del flujo de autorización OAuth

**Authorization Code Flow (para aplicaciones web)**: Configura tu sistema para redirigir a los usuarios a la URL de autorización de la CUC. Procesa la respuesta, intercambiando el código de autorización por un token de acceso.

**Implicit Flow (para aplicaciones móviles y JavaScript en navegadores)**: Implementa la redirección del navegador para obtener el token de acceso directamente.

**Client Credentials Flow (para servicios y aplicaciones sin participación directa del usuario)**: Integra la obtención del token de acceso utilizando las credenciales del cliente directamente.

### Paso 4: Implementación de OpenID Connect para autenticación

Configura tu sistema para solicitar el ID Token durante el flujo de autorización. Valida y verifica la firma del ID Token para asegurar la identidad del usuario.

### Paso 5: Almacenamiento y gestión de tokens

Implementa un mecanismo seguro para almacenar y gestionar los tokens de acceso y el ID Token. Asegúrate de que la caducidad de los tokens se maneje correctamente.

### Paso 6: Pruebas y depuración

Realiza pruebas exhaustivas de todos los flujos de autorización e autenticación implementados. Utiliza las herramientas de depuración proporcionadas por la CUC y el Departamento de Arquitectura para identificar y corregir posibles problemas.

### Paso 7: Configuración para ambiente de producción

Asegúrate de que todas las configuraciones estén optimizadas para el ambiente de producción. Actualiza las URL y endpoints para reflejar el entorno de producción de la CUC.

### Paso 8: Documentación y capacitación

Documenta detalladamente la implementación de OAuth y OpenID Connect en tu sistema. Proporciona capacitación interna para que el personal comprenda el flujo de integración y las medidas de seguridad.

### Paso 9: Soporte continuo

Aprovecha el soporte continuo del Departamento de Arquitectura para abordar cualquier problema o pregunta. Mantente actualizado con las mejores prácticas y actualizaciones proporcionadas.

## Integración con autenticación ya existente

Si ya cuentas con una solución de autenticación y una base de datos de usuarios, intenta seguir los siguientes pasos para integrar OAuth y OpenID Connect (OIDC) de manera eficaz:

### Paso 1: Evaluación de la solución de autenticación existente y la base de datos de usuarios

**Revisión de la solución de autenticación**: Analiza en detalle la arquitectura y funcionamiento de tu solución de autenticación existente. Identifica los puntos clave que necesitan ajustes para integrar OAuth y OIDC.

**Exploración de la base de datos de usuarios**: Examina la estructura y contenido de tu base de datos de usuarios. Identifica el campo que actuará como identificador principal, como la cédula del ciudadano.

### Paso 2: Configuración inicial en ambiente de prueba (test)

Utiliza las credenciales del cliente OAuth proporcionadas por el Departamento de Arquitectura para configurar tu sistema en el ambiente de prueba. Verifica la compatibilidad de tu solución de autenticación con OAuth y OIDC.

### Paso 3: Estrategia de integración con la base de datos de usuarios

**Relación con la cédula del ciudadano**: Identifica el campo en tu base de datos que contiene la cédula del ciudadano como ID principal. Configura tu sistema para utilizar este campo como identificador principal al interactuar con la CUC.

**Mapeo de atributos del usuario**: Define un mapeo entre los atributos de usuario en la CUC y tu base de datos local. Asegúrate de que la información clave, como nombre, correo electrónico y roles, se sincronice correctamente.

### Paso 4: Integración con OAuth y OIDC

**Adaptación en la autenticación**: Modifica tu sistema de autenticación para alinear los flujos con OAuth y OIDC. Asegúrate de manejar correctamente los eventos de inicio y cierre de sesión.

**Configuración de redireccionamiento**: Configura las URLs de redireccionamiento en tu sistema para permitir el flujo de autorización. Asegúrate de que la respuesta del servidor de autorización se maneje adecuadamente.

### Paso 5: Implementación de OpenID Connect para autenticación

**Integración del ID Token**: Ajusta tu sistema para solicitar y validar el ID Token durante el proceso de autenticación. Actualiza la lógica de autenticación para verificar la identidad del usuario utilizando el ID Token.

### Paso 6: Gestión de tokens y sesiones

**Token de acceso**: Modifica el sistema para gestionar y almacenar de manera segura el token de acceso obtenido durante la autorización. Asegúrate de manejar adecuadamente la expiración y renovación de tokens.

**Sesiones de usuario**: Ajusta la gestión de sesiones para que coincida con la autenticación basada en tokens de OAuth y OIDC. Verifica que las sesiones de usuario se mantengan correctamente.

### Paso 7: Pruebas y depuración

**Escenarios de prueba**: Realiza pruebas exhaustivas para asegurar la interoperabilidad entre tu sistema, la solución de autenticación existente y la CUC. Prueba diversos escenarios de autenticación y autorización.

**Herramientas de depuración**: Utiliza herramientas de depuración proporcionadas por el DA y la CUC para identificar y corregir posibles problemas.

### Paso 8: Configuración para ambiente de producción

Asegúrate de que todas las configuraciones estén optimizadas para el ambiente de producción. Actualiza las URL y endpoints para reflejar el entorno de producción de la CUC.

### Paso 9: Documentación y capacitación

Documenta detalladamente la integración realizada en tu sistema. Proporciona capacitación interna para asegurar que el personal comprenda el nuevo flujo de autenticación.

### Paso 10: Soporte continuo

Aprovecha el soporte continuo del Departamento de Arquitectura para abordar cualquier problema o pregunta. Mantente informado sobre actualizaciones y mejores prácticas relacionadas con OAuth y OIDC.

## Ejemplos de integración

Revise los siguientes [ejemplos](../examples/README.md) y seleccione el que se adapta a su caso.
