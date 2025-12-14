# 🛍️ Shoply - A Modern E-commerce Flutter App

Shoply is a modern, feature-rich e-commerce mobile application built with Flutter. It's designed with a **feature-first clean architecture** approach to ensure scalability, maintainability, and high-quality code.

This README will be actively maintained and updated as the project evolves.

## ✨ Features

- **User Authentication:** Secure sign-up and sign-in functionality using Firebase Auth (including Google Sign-In).
- **Dynamic Product Catalog:** Browse a list of products fetched from a Cloud Firestore backend.
- **Modern UI/UX:** A clean, intuitive, and engaging user interface.
- *(More features are currently in development and will be added soon!)*

## 🏗️ Architecture

This project follows a **Feature-First Clean Architecture**. The code is organized by features (e.g., `AUTH`, `PRODUCTS`) to promote modularity and separation of concerns.

- **`lib/features`**: Each feature has its own dedicated folder containing its `data` (repositories, data sources, models), `domain` (entities, use cases), and `presentation` (bloc, pages, widgets) layers.
- **`lib/core`**: Contains shared code used across multiple features, such as theme definitions, router configuration, dependency injection, and utility classes.

This structure makes the codebase easy to navigate, test, and scale.

## 🛠️ Tech Stack & Key Libraries

- **Framework:** [Flutter](https://flutter.dev/)
- **State Management:** [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- **Backend & Authentication:** [Firebase](https://firebase.google.com/) (Auth, Cloud Firestore)
- **Navigation:** [go_router](https://pub.dev/packages/go_router) for a declarative, URL-based routing solution.
- **Dependency Injection:** [get_it](https://pub.dev/packages/get_it)
- **Functional Programming:** [dartz](https://pub.dev/packages/dartz) for `Either` and `Option` types to handle errors and nullable data gracefully.
- **Value Equality:** [equatable](https://pub.dev/packages/equatable)
- **External Links:** [url_launcher](https://pub.dev/packages/url_launcher)
- **Local Storage:** [hive](https://pub.dev/packages/hive)
- **UI:** Google Fonts, Flutter SVG

## 🚀 Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

You need to have Flutter installed on your system. You can find instructions [here](https://flutter.dev/docs/get-started/install).

### Installation

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/your-username/shoplyapp.git
    cd shoplyapp
    ```

2.  **Install dependencies:**
    ```sh
    flutter pub get
    ```

3.  **Run the app:**
    ```sh
    flutter run
    ```

## 📂 Project Structure

```
shoplyapp/
├── lib/
│   ├── core/               # Shared code (DI, router, theme, utils)
│   │   ├── di/
│   │   ├── router/
│   │   └── theme/
│   ├── features/           # Feature-based modules
│   │   ├── AUTH/
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/ # BLoC, pages, widgets
│   │   └── ...               # Other features
│   ├── firebase_options.dart # Firebase configuration
│   └── main.dart           # App entry point
├── assets/                 # Images and SVG icons
└── pubspec.yaml            # Project dependencies
```

## 🔮 Future Development

Shoply is an ongoing project. I am continuously working on adding new features and improving the existing ones. The README will be updated accordingly to reflect the latest changes and additions.