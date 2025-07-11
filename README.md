# Kagojkolom - a note app ✅

KagojKolom (meaning Paper-Pen) is a simple and efficient note app built with Flutter. It helps users to note down their thought in a simple, hasslefree way. The app draws its inspiration from Google Keep. The app is responsive allowing users to run it on desktop, tablet and mobile platforms. 

## Demo and screenshots

## ✨ Features

- **User Authentication**  
  Sign up and log in securely using Firebase Authentication. Authentication state is preserved across sessions.

- **Cloud Sync with Firestore**  
  Notes are automatically synced to Firestore when online. This provides backup and lets users access their todos from multiple devices.

- **Create, Edit, Delete Notes**  
  Add new note, update them, or delete them as needed with a smooth and intuitive UI. Deleted notes will be moved to trash. Users have the ability to permanently delete in Delete all notes section.

- **Share Notes**  
  Share notes with others via email. After creating a note, tap the share icon to send it to anyone using their email address. The shared user only have view access.

## 🛠 Technologies Used  

KagojKolom is built using the following technologies and packages:

#### **📌 Framework & Language**  
- **Flutter** – For building the cross-platform UI  
- **Dart** – The programming language used  

#### **📌 State Management**  
- **BLoC** – For managing app state in a reactive and scalable way using the BLoC (Business Logic Component) pattern.  

#### **📌 API & Networking**  
- **Firebase Authentication** – Handles user sign-in and authentication.  
- **Cloud Firestore** – Stores and syncs todo tasks with the cloud.  

#### **📌 UI & Utilities**  
- **flutter_staggered_grid_view** – Used to create a responsive and visually pleasing grid layout for displaying notes across different screen sizes.  
- **popover** – Enables floating pop-up menus or tooltips, enhancing interaction with additional context options.  


#### **📌 Other Utilities**  
- **shared_preferences** – For saving small user preferences locally, such as light or dark theme. 
- **provider** – A lightweight state management helper, used alongside `flutter_bloc` where necessary.  
- **logger** – Structured and colorful logging during development and debugging.
- **dartz** – For error handling using `Either`

## 📈 Flowchart

## 📁 Folder Structure

The project follows **Clean Architecture** principles, separating concerns across three main layers:
```
lib/
├── core/ # Errors, globals, theme.
├── features/
│    ├── auth/ # User authentication feature
│    │   ├── data/ # Firebase data sources, sync, models
│    │   ├── domain/ # Entities, repositories, use cases for user auth
│    │   └── presentation/ # UI, widgets and BLoC logic for auth
│    │
│    ├── notes/ # Todo feature with sharing
│    │   ├── data/ # data sources, models
│    │   ├── domain/ # Entities, repositories, use cases for creating notes
│    │   └── presentation/ # UI, widgets, and BLoC logic for notes use cases
│    │
│    └── user/ # User profile feature
│        └── presentation/ # BLoC logic for user profile and settings
│
├── main.dart # Entry point
└── firebase_options.dart # Dependency injection setup

```

This structure promotes testability, scalability, and separation of concerns.

## 📌 Usage

Here’s how you can use Kagojkolom:

#### 👤 User authentication
- You can log in through the Login screen by providing your credentials (email and password), or tap on Don't have an account? to create a new account.
- If you have an account but forgot your password, tap on the Forgot password? link to reset it. A reset link will be sent to your registered email.

#### 📝 Create a note
- Tap the **take a note button** (on tablet and desktop) **+ button** (on mobile) to open the note creation dialog box.
- Enter your note and press save to save the note.

#### ✅ Toggle Task Completion
- Tap on checkbox of any task to mark it as complete or incomplete.

#### ✏️ Edit a note
- Tap on any note to edit ✏️.

#### 🗑️ Delete a note
- Tap on three dot of each note to select `delete` 🗑️ to delete a note.

#### 👥 View shared notes
- Go to the **Shared with me** tab or **Share** icon to see notes shared with you.

#### 🔗 Share a Task
- Tap on three dot of any note and select `Share`. Enter an email address to share with.


## 🛠 Installation
Follow these steps to set up and run KagojKolom locally:

#### ⚙️ Prerequisites:  
- Flutter SDK

#### 📥 Setup & Run Taskaroo

1️⃣ Clone the Repository
```
git clone https://github.com/yourusername/taskaroo.git
cd kagojkolom
```
2️⃣ Install Dependencies
```
flutter pub get
```
3️⃣ Run the App
```
flutter run
```

## 🚀 Future Improvements

- **Push Notifications with reminders**  
  Create reminders with notification feature

- **Select multiple notes**
  Select multiple notes to perform an action like share or delete


## 🤝 Contributing
Contributions are welcome! If you'd like to improve or implement new features to Taskaroo, please go ahead. Since, I am just a beginner in this space, feel free to send me your suggestions and code Improvements.
