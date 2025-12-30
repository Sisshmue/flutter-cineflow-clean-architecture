📽️ CineFlow - Movie Discovery
CineFlow is a mobile application that allows users to search for movies and view detailed information, including ratings, cast, and summaries.

🏗️ Architecture & State Management
This project strictly follows Clean Architecture principles to ensure a separation of concerns, testability, and maintainability.

State Management: BLoC (Business Logic Component)

Dependency Injection: GetIt

External API: TMDB (The Movie Database)

📁 Folder Structure

lib/
 ├── core/                # Constants, params, and common widgets
 ├── features/
 │   └── movie/
 │       ├── domain/      # Entities, Repository Interfaces, UseCases
 │       ├── data/        # Models, Repository Impl, Data Sources
 │       └── presentation/# BLoC, Pages, and Widgets
 └── init_dependencies.dart # GetIt Service Locator
