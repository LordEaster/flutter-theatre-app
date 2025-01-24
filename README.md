
# 🎭 Mock Theatre App

A Flutter-based mobile application for exploring cinemas, discovering movies, and tracking watch history. This app demonstrates navigation, data fetching, and UI design using mock data.

## 🚀 Features

### 1. **Cinema Explorer**
- Browse a list of cinemas with their name, address, and description.
- View detailed information about each cinema.
- Easily navigate to cinema details from the cinema list.

### 2. **Movie Browser**
- Categorized movie lists:
  - **Hot Movies**: Trending movies.
  - **Now Showing**: Movies currently in theatres.
  - **Coming Soon**: Upcoming releases.
- View detailed descriptions, genres, ratings, and showtimes for each movie.
- Navigate between movies seamlessly.

### 3. **Account Management**
- Displays a user profile with:
  - Avatar.
  - Name and email.
- View recent watch history (last 3 movies).
- Access full watch history via a dedicated screen.
- Contact form for feedback or inquiries.

## 🗂️ Mock Data

### Cinema Data
Located in `assets/json/cinemas.json`, it contains:
- **Name**: The cinema's name.
- **Address**: The cinema's location.
- **Description**: Overview of the cinema.

### Movie Data
Located in `assets/json/movies.json`, it includes:
- **Title**: The movie's name.
- **Image**: Path to the movie's poster.
- **Description**: Overview of the movie's plot.
- **Rating**: Content rating (e.g., G, PG).
- **Genre**: List of movie genres.
- **Release Date**: The movie's release date.
- **Showtimes**: Available days and times for viewing.

### Watch History Data
Located in `assets/json/watch_history.json`, it contains:
- **Title**: Name of the movie watched.
- **Date**: Date the movie was watched.

## 📂 Folder Structure

```
lib/
├── screens/
│   ├── home_screen.dart         # Home screen with movie categories
│   ├── cinema_screen.dart       # Cinema list and details
│   ├── account_screen.dart      # User profile and watch history
│   ├── movie_description_screen.dart # Detailed movie information
├── utils/
│   ├── json_loader.dart         # Utility to load JSON files
assets/
├── json/
│   ├── cinemas.json             # Cinema data
│   ├── movies.json              # Movie data
│   ├── watch_history.json       # Watch history data
├── images/
│   ├── ...                      # Movie and cinema images
```

## 🛠️ How It Works

1. **Dynamic Data Loading**:
   - Data is fetched from local JSON files using `FutureBuilder`.

2. **Navigation**:
   - Named routes for seamless screen transitions.
   - `Navigator` used for routing between cinema and movie details.

3. **State Management**:
   - Simple state management with local data fetching.

4. **Responsive Design**:
   - Scales well across different screen sizes.

## 📜 License

This project is for educational purposes only.
