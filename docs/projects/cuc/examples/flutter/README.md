Este es un nuevo proyecto de [**Flutter**](https://flutter.dev/) con un OAuth básico implementado.

# Empezando

> **Nota:** Asegúrate de tener [Flutter correctamente instalado](https://docs.flutter.dev/get-started/install) antes de intentar este tutorial.

## Configuración de los permisos necesarios

Esta es una descripción general de los permisos que se necesitan para que funcione el proceso de OAuth. Todo en esta sección ya está hecho en el ejemplo y está aquí en caso de que alguien quiera implementarlo en una aplicación Flutter ya desarrollada.

### Modificar la configuración de iOS

- Abre el archivo `Info.plist` de tu proyecto.

- Agrega una nueva clave llamada "CFBundle URLTypes" de tipo Array.

- Agrega un nuevo elemento bajo "CFBundleURLTypes" y establece el Esquema de URL (CFBundleURLSchemes) al esquema deseado, por ejemplo, "miaplicacion".

- Guarda los cambios.

```xml
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>miaplicacion</string> <!-- Reemplaza "miaplicacion" con el esquema deseado -->
    </array>
  </dict>
</array>
```

### Configurar el manifiesto de Android (AndroidManifest.xml)

- Abre el archivo `AndroidManifest.xml` ubicado en el directorio `android/app/src/main`.

- Agrega un filtro de intención dentro de la etiqueta `<activity>`.

- Establece el atributo `android:scheme` en tu esquema deseado, por ejemplo, "miaplicacion".

- Guarda los cambios.

```xml
<activity>
  ...
  <intent-filter>
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data
        android:scheme="miaplicacion" /> <!-- Reemplaza "miaplicacion" con el esquema deseado -->
  </intent-filter>
</activity>
```

## Iniciando la aplicación

Después de instalar las dependencias del paquete con:

```
flutter pub get
```

Ejecuta la aplicación con el siguiente comando:

```
flutter run
```

# Solución de problemas

Si no puedes hacer que esto funcione, consulta la página de [Errores comunes de Flutter](https://docs.flutter.dev/testing/common-errors).

# Aprende más

Para aprender más sobre Flutter, echa un vistazo a los siguientes recursos:

- [Sitio web de Flutter](https://flutter.dev/) - aprende más sobre Flutter.
- [Empezando](https://docs.flutter.dev/get-started/install) - una **descripción general** de Flutter y cómo configurar tu entorno.
- [`@flutter/flutter`](https://github.com/flutter/flutter) - el repositorio de GitHub **de código abierto** para Flutter.
