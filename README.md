# Go

Un proyecto pensado para agilizar los flujos de personas en las edificaciones aprovechándose de los sensores NFC en smartphones y las tarjetas inteligente que también suelen implementar esta tecnología.

## Iniciando en Flutter

Algunos recursos para iniciar si este es tu primer proyecto con Flutter:

- [Lab: Escribe tu primera aplicación con Flutter](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Ejemplos utiles de Flutter](https://flutter.dev/docs/cookbook)

Para ayuda comenzando con Flutter, visita la
[documentación online](https://flutter.dev/docs), donde se ofrecen tutoriales,
ejemplos, guía en desarrollo móvil, y una referenciación completa sobre API's.

## Instalación de Flutter en VSCode sin Android Studio

Para realizar la instalación de todo el entorno necesario para el funcionamiento de este framework sin el IDE de Android Studio, se requiere hacer la instalación de los componentes necesarios en el comando *Flutter Doctor*:

```
$flutter doctor

Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 2.0.3, on Linux, locale es_CO.UTF-8)
[✓] Android toolchain - develop for Android devices (Android SDK version 29.0.2)
[✓] Chrome - develop for the web
[!] Android Studio (not installed)
[✓] VS Code (version 1.55.0)
[✓] Connected device (1 available)

! Doctor found issues in 1 category.
```

Vemos que para el correcto funcionamiento de Flutter sin el IDE se requieren tener instalados los siguientes componentes:

- Flutter Engine
- Android SDK y herramientas de linea de comandos
- Java Development Kit (JDK) *version 8*
- Google Chrome
- VSCode
- Dispositivo donde compilar el proyecto
    - Emulador Android o IOs
    - Google Chrome para desarrollo web

Por lo tanto se va a cubrir el paso a paso para cada uno de estos puntos necesarios durante la composición del framework.

# Linux

> Procedimiento realizado en Debian 10 Buster arquitectura x86-64
> si no tiene instalado el editor *nano*, utilice otro de su preferencia o utilice `< sudo apt install nano>` para instalarlo
## Instalación del Motor de Flutter

Para la instalación del motor del framework nos dirigimos a la [página principal](https://flutter.dev/docs/get-started/install/linux) de descarga, y nos dirigimos a la sección de *descarga manual* donde encontraremos un botón de descarga de un paquete .zip con la versión más reciente, este debe ser descomprimido en la carpeta */home* y posteriormente agregar el binario de Flutter al PATH del bash así:

```
cd /home
tar xf ~/Downloads/flutter_linux_2.0.4-stable.tar.xz
cd ~
sudo nano .bashrc
```

Dentro del editor nos dirigimos a la parte final y colocamos lo siguiente:

```
#Flutter config
export FLUTTER_HOME="/home/flutter"
export PATH="$PATH:$FLUTTER_HOME/bin"
```

finalmente utilizamos *ctrl+o* para guardar y *ctrl+x* para salir del editor, debemos reiniciar la terminal o usar `<source .bashrc>`, ahora podremos usar `<flutter doctor>` para checkear si el motor quedó instalado con exito.

## Instalación JDK version 8

Para instalar el *Java Development Kit* debemos dirigirnos a la [pagina principal](https://www.oracle.com/co/java/technologies/javase/javase-jdk8-downloads.html) donde descargaremos el *Linux x64 Compressed Archive*, posteriormente debemos crear el directorio jvm  en */usr/lib* y descomprimir el JDK ahí y finalemente declararle al sistema operativo que hay un JDK disponible:

```
cd /usr/lib
sudo mkdir jvm
cd jvm
sudo tar xf ~/Downloads/jdk-8u281-linux-x64.tar.gz
sudo update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk1.8.0_version/bin/java" 1
sudo update-alternatives --set java /usr/lib/jvm/jdk1.8.0_version/bin/java
```

para ver si el JDK quedó instalado satisfactoriamente usamos `<java -version>` para ver la version actual de java.

## Instalación de las Herramientas de linea de comandos y Android SDK

Para la instalación de las herramientas de linea de comando y el Android SDK debemos dirigirnos a la pagina de [Android Studio](https://developer.android.com/studio) en la opción de *download options* y buscamos el menú de *Command line tools only* y descargamos el .zip para linux y lo extraemos en la carpeta de descargas, ahora tenemos que crear una carpeta llamada *android-sdk/cmdline-tools/tools* en el directorio */opt* y mover el contenido del zip a estas carpetas:

```
cd /opt
sudo mkdir -p android-sdk/cmdline-tools/tools
sudo mv ~/Downloads/cmdline-tools/* /opt/android-sdk/cmdline-tools/tools/
```

Ya que tenemos movidos los archivos de las herramientas, tenemos que agregar la carpeta al PATH del bash, así que:

```
cd ~
sudo nano .bashrc
```

Dentro del editor nos dirigimos al final y colocamos lo siguiente:

```
# Android-sdk config
export ANDROID_HOME="/opt/android-sdk"
export ANDROID_SDK_ROOT="/opt/android-sdk"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools"
export PATH="$PATH:$ANDROID_HOME/emulator"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/tools/bin"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$ANDROID_SDK_ROOT"
```

Utilizamos *ctrl+o* para guardar y *ctrl+x* para salir del editor, debemos reiniciar la terminal o usar `<source .bashrc>`, ahora tenemos que instalar el resto de herramientas necesarias dentro del android-sdk con lo siguiente:

```
sdkmaganer "platforms:android-30" "build-tools;28.0.3" "extras;google;m2repository" "extras;android;m2repository" "system-images;android-27;google_apis_playstore;x86"
```

De este modo la instalación del android-sdk finalizó, ahora para poder ejecutar el emulador de android una opción es entrar a *VSCode* en un proyecto de Flutter, donde en la esquina inferior derecha aparacerá un icono con los dispositivos disponibles, al darle click veremos que solo aparece *google chrome*, así que damos click en nuevo emulador para ejecutar el emulador Android.

## Instalación Google Chrome

Para instalar el buscador web, debemos dirigirnos a la [página principal](https://www.google.com/intl/es-419/chrome/) y descargamos el paquete .deb, luego usamos el comando `<sudo apt install .~/Downloads/google-chrome-stable_current_amd64.deb>` para instalarlo.
## Instalación Visual Estudio Code

Para instalar el editor de código, debemos dirigirnos a la [página principal](https://code.visualstudio.com/) y descargamos el paquete .deb, luego usamos el comando `<sudo apt install .~/Downloads/code_1.55.0-1617120720_amd64.deb>` para instalarlo.

Finalmente debemos instalar las extensiones tanto de Flutter como de Dart dentro del buscador del editor de código.
