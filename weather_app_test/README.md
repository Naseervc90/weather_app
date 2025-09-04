Weather App 🌤️
A Flutter weather application built with Clean Architecture, featuring current weather data and 5-day forecasts for any city worldwide.

Features
Current Weather Data: Temperature, humidity, wind speed, and weather conditions

5-Day Forecast: Horizontal scrollable forecast for the next 5 days

Dark/Light Mode: Toggle between dark and light themes with persistence

Network Awareness: Handles offline scenarios gracefully

Error Handling: User-friendly error messages for various scenarios

Modern UI: Clean, material design with smooth animations

Search Functionality: Find weather for any city worldwide

Architecture
This app follows Clean Architecture principles with the following layers:

Domain Layer
Entities: Core business objects (Weather, Forecast)

Repositories: Abstract interfaces for data operations

Use Cases: Application-specific business rules

Data Layer
Models: Data transfer objects with JSON serialization

Repositories: Implementation of domain repositories

Data Sources: API and local data providers

Presentation Layer
BLoC: State management using BLoC pattern

Pages: UI screens and components

Widgets: Reusable UI components

Tech Stack
Flutter: UI framework

BLoC: State management

Dartz: Functional programming helpers

Http: API communication

Connectivity Plus: Network status detection

Shared Preferences: Local storage for theme preference

Cached Network Image: Image loading and caching

Intl: Date formatting and localization

JSON Serialization: Automatic JSON parsing


Project Structure
text
lib/
├── core/
│   ├── constants/      # API constants and app constants
│   ├── error/          # Custom exceptions and failures
│   ├── network/        # Network connectivity checking
│   └── utils/          # Utility classes and constants
├── data/
│   ├── datasources/    # Remote data sources (API calls)
│   ├── models/         # Data models (JSON serialization)
│   └── repositories/   # Repository implementations
├── domain/
│   ├── entities/       # Business entities
│   ├── repositories/   # Repository interfaces
│   └── usecases/       # Application use cases
├── presentation/
│   ├── bloc/           # BLoC state management
│   ├── pages/          # App screens
│   └── widgets/        # Reusable UI components
├── injection_container.dart # Dependency injection setup
└── main.dart           # App entry point
API Integration
This app uses the OpenWeatherMap API:

Current Weather: https://api.openweathermap.org/data/2.5/weather

5-Day Forecast: https://api.openweathermap.org/data/2.5/forecast

Weather Icons: https://openweathermap.org/img/wn/{icon}@2x.png

Error Handling
The app handles various error scenarios:

Network Errors: "No internet connection"

City Not Found: "City not found"

API Errors: "Invalid API key", "Server error"

Generic Errors: Fallback error messages with details

Theme System
The app supports both dark and light themes with persistence using SharedPreferences. The theme preference is saved locally and restored on app startup.

Acknowledgments
Weather data provided by OpenWeatherMap

Icons provided by Flutter

UI inspiration from modern weather applications


