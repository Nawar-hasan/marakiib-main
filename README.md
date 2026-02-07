# Marakiib - Transportation App 🚗

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-039BE5?style=for-the-badge&logo=Firebase&logoColor=white)](https://firebase.google.com)

A comprehensive transportation and ride-sharing application built with Flutter, supporting both users and drivers (vendors) with features like car booking, real-time messaging, payment processing, and location services.

## 🌟 Features

### 👤 User Features
- **User Registration & Authentication** - Secure login/signup with Google Sign-In
- **Car Booking** - Browse and book available vehicles
- **Real-time Tracking** - GPS-based location tracking
- **Messaging** - In-app chat with drivers
- **Notifications** - Push notifications for booking updates
- **Payment Integration** - Secure payment processing
- **Wallet Management** - Digital wallet for transactions
- **Profile Management** - User profile customization
- **Subscription Plans** - Premium features and services

### 🚗 Driver (Vendor) Features
- **Driver Registration** - Complete driver onboarding
- **Car Management** - Add and manage vehicle listings
- **Booking Management** - Handle ride requests
- **Earnings Tracking** - Monitor income and transactions
- **Route Optimization** - GPS navigation and routing
- **Document Upload** - License and vehicle documentation

### 🛠️ Technical Features
- **Multi-language Support** - Arabic and English localization
- **Offline Support** - Works without internet connection
- **Real-time Updates** - Live data synchronization
- **Maps Integration** - Interactive maps with Flutter Map and Google Maps
- **Image Handling** - Photo upload and caching
- **Push Notifications** - Firebase Cloud Messaging
- **State Management** - BLoC pattern implementation

## 🏗️ Architecture

The app follows a clean architecture pattern with:
- **Presentation Layer** - UI components and screens
- **Business Logic Layer** - BLoC cubits for state management
- **Data Layer** - Repository pattern for API and local storage
- **Core Layer** - Shared utilities and services

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (^3.7.2)
- Dart SDK (^3.7.2)
- Android Studio / VS Code
- Firebase account for backend services

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/marakiib-app.git
   cd marakiib-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Add your `google-services.json` to `android/app/`
   - Configure Firebase project settings

4. **Generate localization files**
   ```bash
   flutter gen-l10n
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

### Build Commands

- **Android APK**: `flutter build apk --release`
- **iOS**: `flutter build ios --release`
- **Web**: `flutter build web --release`

## 📱 Supported Platforms

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ Linux
- ✅ macOS

## 🛠️ Technologies Used

### Core Framework
- **Flutter** - UI framework
- **Dart** - Programming language

### State Management
- **Flutter BLoC** - Business logic components
- **Provider** - Dependency injection

### Networking & API
- **Dio** - HTTP client
- **Firebase Core** - Backend services

### Maps & Location
- **Flutter Map** - Open-source maps
- **Google Maps Flutter** - Google Maps integration
- **Geolocator** - GPS location services
- **Geocoding** - Address conversion

### UI Components
- **Carousel Slider** - Image carousels
- **Convex Bottom Bar** - Custom navigation
- **Smooth Page Indicator** - Page indicators
- **Flutter Animate** - Animations
- **Shimmer** - Loading effects

### Utilities
- **Shared Preferences** - Local storage
- **Image Picker** - Photo selection
- **URL Launcher** - External links
- **Permission Handler** - System permissions
- **Connectivity Plus** - Network status

## 📂 Project Structure

```
lib/
├── core/                 # Core utilities and services
├── features/             # Feature modules
│   ├── auth/            # Authentication
│   ├── booking_screen/  # Car booking
│   ├── car_details/     # Vehicle information
│   ├── chat/            # Messaging system
│   ├── user_home/       # User dashboard
│   ├── vendor_home/     # Driver dashboard
│   └── ...
├── generated/           # Generated localization files
├── l10n/               # Localization assets
└── main.dart           # App entry point
```

## 🔧 Configuration

### Environment Setup

1. **API Configuration**
   - Update API endpoints in `core/config/`
   - Configure Firebase project ID

2. **Localization**
   - Arabic and English translations in `lib/l10n/`
   - Add new languages by creating `.arb` files

3. **Assets**
   - Images: `assets/images/`
   - Icons: `assets/icons/`
   - Fonts: `assets/fonts/`

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

For support and questions:
- Create an issue on GitHub
- Contact the development team

---

**Made with ❤️ using Flutter**
