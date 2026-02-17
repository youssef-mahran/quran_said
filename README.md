📖 Quran Kareem App

A Complete Islamic Audio Application built with Flutter

A fully featured Quran application that allows users to browse all 114 Surahs and listen to them through multiple educational sections with a clean Islamic-inspired UI and responsive design.

🌟 Overview

Quran Kareem App is a structured and scalable Flutter application designed to provide a smooth and immersive Quran listening experience.

The app organizes the Holy Quran into four listening modes:

🎧 Tilawa (Recitation)

🎼 Tarteel (Measured Recitation)

🎓 Muallim (Teaching Mode)

📚 Tajweed (Rules-based Recitation)

Each section contains the full 114 Surahs with dedicated audio files.

✨ Key Features

✅ Full 114 Surahs list

🔎 Real-time search (Arabic & English names)

🎵 Built-in audio player

⏯ Play / Pause / Seek forward / Seek backward

📊 Live progress tracking with Slider

🕒 Duration & position listeners

📂 Dynamic audio path generation per category

🎨 Elegant Islamic UI with Amiri Quran font

📱 Fully Responsive Design (MediaQuery based)

🧪 Device testing using DevicePreview

🛡 Safe resource handling & proper disposal

🧠 Technical Implementation
🔹 Audio System

Implemented using audioplayers

Streams:

onPlayerStateChanged

onDurationChanged

onPositionChanged

Dynamic AssetSource loading

Manifest validation for asset safety

Proper dispose() handling to prevent memory leaks

🔹 Architecture Approach

Separation between:

UI Components

Navigation Layer

Audio Logic

Static Surah Data

Reusable custom widgets (CategoryItem)

Clean navigation flow between screens

🔹 Responsive Strategy

Screen-based scaling using:

MediaQuery

Percentage-based sizing

Tested across multiple device sizes using DevicePreview

📂 Project Structure
lib/
 ├── component/
 │    └── category_item.dart
 ├── screens/
 │    ├── home_page.dart
 │    ├── surah_list_page.dart
 │    └── surah_player_page.dart
 └── main.dart
