# 📸 Finstagram — Instagram Clone App

**Finstagram** is a simple **Instagram-style photo sharing app** built with Flutter and Firebase. Users can **create an account**, **log in with email**, and **upload photos** that are stored securely in **Firebase Storage**.

---

## ✨ Features

- 👤 Email-based user registration and login
- 🔐 Firebase Authentication for secure access
- 🖼️ Upload and view photos (like a mini Instagram feed)
- ☁️ Firebase Storage integration for image hosting
- 🔄 Real-time updates using Firebase Firestore
- 📱 Clean and responsive UI in Flutter

---

## 🛠️ Tech Stack

- **Flutter** — Cross-platform UI framework
- **Dart** — Programming language for Flutter
- **Firebase**:
  - **Authentication** — Email/password login
  - **Firestore** — Storing image metadata
  - **Firebase Storage** — Uploading and retrieving images
- **Provider / setState** — State management

---

## 🚀 Getting Started

### ✅ Prerequisites

- Flutter SDK installed
- Firebase project set up
- Android Studio / Xcode / VSCode

### 🔧 Firebase Setup

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Create a new project called `finstagram`
3. Add an Android/iOS app to Firebase
4. Download the `google-services.json` (for Android) or `GoogleService-Info.plist` (for iOS)
5. Enable:
   - **Authentication > Email/Password**
   - **Firestore Database**
   - **Firebase Storage**

---

## 📦 Installation

```bash
git clone https://github.com/pavlitoss/finstagram.git
cd finstagram
flutter pub get
flutter run
