# BeReal Stories Feature

## 📌 Overview
This project implements an **Instagram-like Stories feature** using **SwiftData and SwiftUI**. Users can view stories, mark them as seen, like/unlike stories, and navigate between the story list and story details.

---

## 🎯 Features
- **Story List Screen** 📜
  - Displays a **horizontally scrollable list of stories**.
  - Supports **infinite scrolling with pagination**.
  - Stories are marked as **seen/unseen**.

- **Story Details Screen** 🔍
  - Users can view a full-screen **story with image and title**.
  - **Like/Unlike a story** by tapping the heart button.
  - **Swipe up or shake** the device to return to the story list.

- **State Persistence** 💾
  - `isLiked` and `isSeen` states are **stored in SwiftData**.
  - Stories **remain consistent** even after app restarts.

---

## 🏗 Architecture
The project follows the **MVVM (Model-View-ViewModel) + Coordinator** architecture for better scalability and maintainability.

### **Project Structure**
```plaintext
📂 BeReal/
 ├── 📂 MVVM/
 │   ├── 📂 Views/
 │   │   ├── StoriesListView.swift
 │   │   ├── StoryDetailsView.swift
 │   ├── 📂 ViewModels/
 │   │   ├── StoriesListViewModel.swift
 │   │   ├── StoryDetailsViewModel.swift
 │   ├── 📂 Models/
 │   │   ├── Story.swift
 │   │   ├── StoryEntity.swift
 │   ├── 📂 Services/
 │   │   ├── NetworkService.swift
 │   ├── 📂 Coordinators/
 │   │   ├── AppCoordinator.swift
 │   ├── 📂 Helpers/
 │   │   ├── Extensions.swift
 ├── BeRealApp.swift
 ├── README.md
