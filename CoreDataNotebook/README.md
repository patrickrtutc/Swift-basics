# CoreData Notebook

A simple notebook application built with UIKit and CoreData using the MVVM-C (Model-View-ViewModel-Coordinator) pattern.

## Features

- Create, read, update, and delete notes
- Store notes with titles and content
- Track creation and update times
- Clean and modern UI

## Architecture

This project follows the MVVM-C architecture pattern:

- **Model**: CoreData entities (Note)
- **View**: UIKit views for displaying and interacting with notes
- **ViewModel**: Handles business logic and prepares data for display
- **Coordinator**: Manages navigation flow and dependencies

## Key Components

- Protocol-oriented approach with generics for flexible and reusable code
- Dependency injection for better testing and loose coupling
- CoreData for persistent storage

## Project Structure

```
CoreDataNotebook/
├── Core/
│   ├── Protocols/
│   │   ├── ViewModelType.swift
│   │   └── Coordinator.swift
│   └── Services/
│       └── CoreDataService.swift
├── Coordinators/
│   └── AppCoordinator.swift
├── ViewModels/
│   ├── NotesListViewModel.swift
│   ├── NoteDetailViewModel.swift
│   └── NoteEditViewModel.swift
├── ViewControllers/
│   ├── NotesListViewController.swift
│   ├── NoteDetailViewController.swift
│   └── NoteEditViewController.swift
└── CoreDataNotebook.xcdatamodeld/
```