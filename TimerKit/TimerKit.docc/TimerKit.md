# ``TimerKit``

<!--@START_MENU_TOKEN@-->Summary<!--@END_MENU_TOKEN@-->

A reusable SwiftUI-based countdown timer framework built using the VIP (View–Interactor–Presenter) architecture.

---

## Overview

<!--@START_MENU_TOKEN@-->Text<!--@END_MENU_TOKEN@-->

`TimerKit` is a modular iOS framework that provides a configurable countdown timer implemented using SwiftUI.  
It supports setting hours, minutes, and seconds, along with controls to start, pause, reset, and stop the timer.

The framework is designed using the **VIP architecture**, ensuring a clear separation between:
- User Interface
- Business Logic
- Presentation Logic

This approach improves maintainability, testability, and makes the timer easy to reuse across applications or features.

---

## Topics

### Public Entry Point

- ``TimerView``

---

### Views

- ``ButtonsView``
- ``CustomTimePicker``
- ``TimeRemaningView``

---

### View Model

- ``TimerViewModel``

---

### Business Logic

- ``TimerInteractor``
- ``TimerInteractorProtocol``

---

### Presentation Logic

- ``TimerPresenter``
- ``TimerPresentationLogic``
- ``TimerDisplayLogic``

---

### Models

- ``TimerModels``

---

## Architecture

`TimerKit` follows the VIP (View–Interactor–Presenter) architecture pattern.

### View
- Built using SwiftUI
- Displays UI components and observes the ViewModel
- Forwards user interactions to the ViewModel

### Interactor
- Contains all timer-related business logic
- Maintains the single source of truth for timer state
- Handles start, pause, reset, stop, and picker updates

### Presenter
- Transforms raw timer data into UI-friendly values
- Formats remaining time into `HH:mm:ss`
- Sends formatted data to the ViewModel

### ViewModel
- Acts as the View layer in VIP
- Conforms to `ObservableObject` for SwiftUI reactivity
- Receives formatted ViewModels from the Presenter
- Publishes state changes to update the UI

---

## Data Flow

TimerKit uses a unidirectional data flow to ensure predictable behavior:

```

User Action
↓
SwiftUI View
↓
TimerViewModel
↓
TimerInteractor
↓
TimerPresenter
↓
TimerViewModel
↓
SwiftUI View

```

---

## Usage

To use `TimerKit`, embed `TimerView` inside your SwiftUI view hierarchy:

```swift
import TimerKit

struct ContentView: View {
    var body: some View {
        TimerView()
    }
}
```

No additional setup is required, as all dependencies are configured internally.

---

## Design Principles

* Single Responsibility per layer
* Unidirectional data flow
* Business logic isolated from UI
* Presentation logic isolated from state
* Reusable and framework-friendly design

---

## Threading & State Management

* All UI updates are performed on the main thread
* Timer lifecycle is safely managed to avoid memory leaks
* `objectWillChange.send()` is used intentionally to batch UI updates

---

```
