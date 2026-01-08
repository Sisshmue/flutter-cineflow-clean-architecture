📽️ CineFlow - Movie Discovery
CineFlow is a mobile application that allows users to search for movies and view detailed information, including released date, cast, and summaries.

🏗️ Architecture & State Management
This project strictly follows Clean Architecture principles to ensure a separation of concerns, testability, and maintainability.

State Management: BLoC (Business Logic Component)

Dependency Injection: GetIt

External API: TMDB (The Movie Database)

📁 Folder Structure

The project follows the **Clean Architecture** pattern, separating the application into three main layers: **Data**, **Domain**, and **Presentation**.

```text
lib/
 ├── core/                    # App-wide constants, themes, and shared utilities
 │    ├── theme/              # App colors and styling
 │    └── error/              # Failures and exceptions handling
 ├── features/
 │    └── movies/             # Main feature: Movie discovery & search
 │         ├── domain/        # Business Logic: Entities, Repositories (Interfaces), UseCases
 │         ├── data/          # Infrastructure: Models, Repositories (Impl), Data Sources
 │         └── presentation/  # UI Layer: BLoC, Pages, and Widgets
 ├── injection_container.dart # Dependency Injection setup (GetIt)
 └── main.dart                # Application entry point
