# DuckDuckGo Search App

This iOS application allows users to search using the DuckDuckGo Instant Answers API and view the results.

## Features

- Enter and submit search queries
- View search results from DuckDuckGo API
- View related topics for search queries
- Clear search functionality
- Error handling for failed API requests

## Project Structure

- **Models/**: Contains data models for API responses
- **Views/**: Contains UI components
  - `ContentView.swift`: Main view containing the search interface
  - `ResultItemView.swift`: Component for displaying search results
  - `TopicItemView.swift`: Component for displaying related topics
- **ViewModels/**: Contains view models
  - `SearchViewModel.swift`: Manages search state and API communication
- **Services/**: Contains services
  - `SearchService.swift`: Handles API requests

## Implementation Details

- Uses SwiftUI for the user interface
- Uses Combine framework for reactive programming
- Uses URLSession for API requests
- Follows MVVM architecture pattern
- No third-party libraries used (as per requirements)

## Example Searches

As demonstrated in the app, you can search for:
- American Airlines
- Dallas, TX
- Chicago Cubs

## API Used

The app uses the DuckDuckGo Instant Answers API:
- Example: https://api.duckduckgo.com/?q=American+Airlines&format=json&pretty=1 