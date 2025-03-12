# MVVM-C UIKit Demo

This project demonstrates the Model-View-ViewModel-Coordinator (MVVM-C) architecture using UIKit in Swift.

## Architecture Overview

### MVVM-C Components

- **Model**: Data and business logic layer (User model)
- **View**: UI components (ViewControllers)
- **ViewModel**: Presentation logic, connects Models to Views
- **Coordinator**: Navigation logic, manages flow between screens

### Project Structure

```
├── Models
│   └── User.swift
├── Views
│   ├── HomeViewController.swift
│   ├── UserListViewController.swift
│   └── UserDetailViewController.swift
├── ViewModels
│   ├── HomeViewModel.swift
│   ├── UserListViewModel.swift
│   └── UserDetailViewModel.swift
└── Coordinators
    ├── Coordinator.swift
    └── MainCoordinator.swift
```

## Navigation Flow

1. The app starts with a HomeViewController showing a welcome message and a button
2. Tapping the button navigates to UserListViewController displaying a list of users
3. Selecting a user navigates to UserDetailViewController showing detailed information
4. Each screen has a back button to return to the previous screen

## Key Benefits of MVVM-C

- **Separation of Concerns**: Each component has a specific responsibility
- **Testability**: ViewModels and Models can be tested independently
- **Reusability**: ViewModels and Coordinators can be reused across different UIs
- **Navigation Logic**: Centralized in Coordinator classes, making navigation flow clear and easy to modify 