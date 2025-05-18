# 🍽️ SaborPTY

**SaborPTY** es una aplicación móvil de recetas de cocina panameña, enfocada en ofrecer una experiencia moderna, intuitiva y rápida para quienes desean descubrir, aprender y preparar platos típicos de Panamá.  
Diseñada bajo los lineamientos de [Material Design 3](https://m3.material.io/), esta app proporciona categorías, detalles de recetas, favoritos, búsqueda y más. 

---

## 📱 Características principales propuesta

- 🥘 Navegación por categorías: sopas, platos tradicionales, postres y más.
- 🔎 Búsqueda de recetas desde la app.
- 📋 Detalles completos de cada receta (ingredientes, pasos, duración, dificultad).
- ❤️ Sistema de favoritos para guardar tus recetas preferidas.
- 🔄 Escalable y modular para futuras funcionalidades (registro, comentarios, etc.).

---

## 🚀 Tecnologías utilizadas

[![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white&style=for-the-badge)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white&style=for-the-badge)](https://dart.dev)
[![Material Design 3](https://img.shields.io/badge/Material%20Design%203-757575?logo=google&logoColor=white&style=for-the-badge)](https://m3.material.io)
[![Riverpod](https://img.shields.io/badge/Riverpod-5C6BC0?style=for-the-badge&logo=flutter&logoColor=white)](https://riverpod.dev)
[![Provider](https://img.shields.io/badge/Provider-42A5F5?style=for-the-badge&logo=flutter&logoColor=white)](https://pub.dev/packages/provider)
[![BLoC](https://img.shields.io/badge/BLoC-8E24AA?style=for-the-badge&logo=flutter&logoColor=white)](https://bloclibrary.dev)
[![Go Router](https://img.shields.io/badge/go_router-00BFA5?style=for-the-badge&logo=dart&logoColor=white)](https://pub.dev/packages/go_router)
[![Hive](https://img.shields.io/badge/Hive-FFC107?style=for-the-badge&logo=hive&logoColor=black)](https://pub.dev/packages/hive)
[![Shared Preferences](https://img.shields.io/badge/Shared%20Preferences-4CAF50?style=for-the-badge&logo=google&logoColor=white)](https://pub.dev/packages/shared_preferences)
[![Firebase](https://img.shields.io/badge/Firebase-FFCA28?logo=firebase&logoColor=black&style=for-the-badge)](https://firebase.google.com)
[![Laravel](https://img.shields.io/badge/Laravel-F55247?logo=laravel&logoColor=white&style=for-the-badge)](https://laravel.com)

---

## 🧱 Estructura del proyecto

```plaintext
lib/
├── core/                    # Elementos reutilizables y generales
│   ├── constants/           # Constantes globales (colores, textos, rutas)
│   ├── errors/              # Manejo y definición de errores
│   ├── services/            # Servicios comunes (API, internet, notificaciones)
│   └── utils/               # Funciones utilitarias (formatos, validaciones)
│
├── features/                # Módulos funcionales divididos por dominio
│   ├── auth/                # Autenticación (login, registro)
│   │   ├── data/            # Modelos, repositorios concretos
│   │   ├── domain/          # Casos de uso, entidades y abstracciones
│   │   └── presentation/    # Pantallas y lógica de UI
│   │
│   ├── home/                # Pantalla principal con categorías
│   ├── recipes/             # Listado, detalle, búsqueda de recetas
│   └── favorites/           # Gestión de recetas favoritas
│
├── shared/                  # Componentes reutilizables en toda la app
│   ├── widgets/             # Tarjetas, botones, inputs comunes
│   ├── themes/              # Configuración de temas claro/oscuro
│   └── navigation/          # Configuración de rutas (go_router, etc.)
│
├── main.dart                # Punto de entrada de la aplicación 


feature_name/
├── data/           # Modelos, repositorios concretos, APIs
├── domain/         # Entidades puras y abstracciones (interfaces, casos de uso)
├── presentation/   # UI (pantallas, estados, viewmodels, widgets)

````

---

> https://uning.es/wp-content/uploads/2016/08/ef3-placeholder-image.jpg


## 📦 Instalación y ejecución

```bash
git clone https://github.com/tu-usuario/saborpty.git
cd saborpty
flutter pub get
flutter run
```
> Asegúrate de tener Flutter instalado y configurado correctamente.
> Puedes verificarlo con: `flutter doctor`
---
## 📄 Licencia
Este proyecto está bajo la licencia [MIT](LICENSE).
---
## 🙌 Autor

**SaborPTY** fue creado por \[BrayanAlmengor] 🇵🇦
Siéntete libre de contribuir, reportar errores o proponer mejoras.

---



## 💡 Ideas futuras
* Registro e inicio de sesión con Google o email
* Publicación de recetas por los usuarios
* Comentarios y valoraciones
* Videos tutoriales
* Recomendaciones del día con notificaciones push
---

> ¡Gracias por apoyar la cultura gastronómica panameña con tecnología moderna! 🇵🇦✨

