# SwipeHire

Welcome to **SwipeHire**, your pocket-sized job-hunting companion. Built with SwiftUI, SwipeHire turns the traditionally tedious process of job searching into a simple, swipe‑left/swipe‑right experience. Ideal for busy students and recent grads, it quickly surfaces opportunities that fit your skills and location—so you can spend less time scrolling and more time applying.

---

## 🎯 Why SwipeHire?

- **Fast & Fun**: Swipe through curated job listings like you would on your favorite apps.
- **Stay Local (or Go Global)**: Automatically pick up your city/state or choose “Remote”—your call.
- **Personalized Matches**: See a “Fit Score” that shows how well your skills align with each role.
- **Keep Organized**: Save jobs you love, track where you’ve applied, and never lose your place.
- **One-Stop Profile**: Update your bio, skills, education, and experience in a snap.

---

## 🚀 Getting Started

1. **Clone the repo**:
   ```bash
   git clone https://github.com/aniakula/Swipe-Hire.git
   ```
2. **Open in Xcode 15+**:
   - Double-click `SwipeHire.xcodeproj`.
3. **Run on your device**:
   - Build and run on iOS 16 or later (simulator or real device).

---

## 🛠️ How It Works

1. **Home Feed**: Swipe right to bookmark a job, swipe left to skip it.

<img src="home.png" alt="App Screenshot" width="300" height="550"/>

2. **Search & Filter**: Tap the search bar to find specific titles or locations. Use the pin icon to switch between state-only and country-wide listings.
3. **Saved & Applied**: Head to the **Saved** tab to revisit bookmarks or mark jobs as applied.

<img src="./saved.png" alt="App Screenshot" width="300" height="550"/>

4. **Edit Profile**: Open **Profile**, tap **Edit**, and tweak your personal info—your Fit Scores will adjust instantly.
   
<img src="profile.png" alt="App Screenshot" width="300" height="550"/>

---

## 🎥 Demo

Want to see SwipeHire in action? Check out this quick demo:

<video src="swipehiredemo.MP4" controls width="320">
Your browser doesn’t support video. You can find the demo in `demo/SwipeHireDemo.mp4`.
</video>

---

## 🛠️ Under the Hood

- **MVVM**: Clear separation of views and logic via `AppViewModel`.
- **SwiftUI**: Declarative views for rapid UI updates.
- **CoreLocation**: Geo‑tagged job filtering based on your current city/state.
- **Local Storage**: JSON persistence for profiles and saved/apply status.

