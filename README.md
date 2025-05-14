# [Social Plus] Frontend

This folder contains the Flutter web frontend for the project.  
The codebase follows the Clean Architecture pattern for scalability and maintainability.

## Requirements

- [Flutter](https://flutter.dev/) (latest stable version)

## How to Run

```
flutter run -d chrome
```

## Folder Structure

The project is organized according to Clean Architecture principles.  
Below is the structure under the `lib/` directory:

```
lib/
├── core
│   ├── navigation
│   │   └── app_router.dart
│   └── utils
│       └── scenario_id_mapper.dart
├── data
│   ├── repository
│   │   ├── mock_scenario_repository.dart
│   │   ├── scenario_repository_impl.dart
│   │   ├── speech_recognition_repository_impl.dart
│   │   └── user_preferences_repository_impl.dart
│   ├── speech_to_text_data_source.dart
│   └── user_preferences_data_source.dart
├── domain
│   ├── entity
│   │   └── ScenarioMapping.dart
│   ├── models
│   │   ├── lesson.dart
│   │   └── scenario.dart
│   └── repository
│       ├── popular_lesson_repository.dart
│       ├── scenario_repository.dart
│       ├── speech_recognition_repository.dart
│       └── user_preferences_repository.dart
├── main.dart
└── presentation
    ├── constants
    │   ├── colors.dart
    │   └── text_styles.dart
    ├── pages
    │   ├── chat_page.dart
    │   ├── home_screen.dart
    │   ├── job_type_screen.dart
    │   ├── lesson_page.dart
    │   ├── lesson_selection_screen.dart
    │   ├── splash_page.dart
    │   └── type_choose_screen.dart
    ├── routes
    │   └── route_names.dart
    ├── viewmodels
    │   ├── home_viewmodel.dart
    │   ├── lesson_scenario_viewmodel.dart
    │   ├── lesson_select_viewmodel.dart
    │   ├── speech_recognition_viewmodel.dart
    │   └── user_preferences_viewmodel.dart
    └── widgets
        ├── app_scaffold.dart
        ├── common_app_bar.dart
        ├── custom_bottom_nav_bar.dart
        ├── job_type_button.dart
        ├── lesson_box.dart
        ├── lesson_card.dart
        ├── mission_card.dart
        ├── primary_action_button.dart
        ├── stampWidget.dart
        └── type_option_card.dart
```

### Folder Descriptions

- **core/**: Common utilities, navigation, and helper functions.
- **data/**: Data sources and repository implementations for API and local storage.
- **domain/**: Business logic, entities, models, and repository interfaces.
- **presentation/**: UI components, pages, viewmodels, widgets, and constants.
- **main.dart**: Application entry point.

## Architecture

- **Pattern:** Clean Architecture (separation of data, domain, and presentation layers)
- **State Management:** Provider
- **Routing:** Managed via `core/navigation/app_router.dart`

## Commit Convention

We use [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) for commit messages.

## Notes

- No additional setup is required except for Flutter installation.
- For overall project information, please refer to the [main README](../README.md).
