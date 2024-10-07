# StoryLine

StoryLine is a full-stack blog application built with Flutter. Users can sign in, create accounts, and post blogs. The app follows Clean Architecture principles, using Bloc & Cubit for state management, Supabase for backend services, `get_it` for dependency injection, and Hive for local storage.

## Features

- User authentication (Sign up, log in)
- Create, edit, and view blog posts
- Efficient state management using Bloc & Cubit
- Offline support via Hive
- Clean architecture with SOLID principles

## Technologies

- **Flutter** for UI
- **Bloc & Cubit** for state management
- **Supabase** for authentication and database
- **Hive** for local storage
- **get_it** for dependency injection

## Getting Started

### Prerequisites

- Flutter SDK
- Supabase account

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/araohatkokate/StoryLine.git
   cd StoryLine

2. Install dependencies:
   ```bash
   flutter pub get

4. Configure Supabase:
   ```bash
   const String SUPABASE_URL = 'your-supabase-url';
   const String SUPABASE_ANON_KEY = 'your-anon-key';

6. Run the app:
   ```bash
   flutter run

## Project Structure
Following Clean Architecture principles:

- Core: Constants, utilities, common widgets
- Features: Divided into authentication and blog domains
- Data: Repositories, data sources, models
- Domain: Use cases, business logic
- Presentation: Screens, widgets, UI
