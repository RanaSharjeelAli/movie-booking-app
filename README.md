# 🎬 Movie Booking App

A modern, responsive movie booking application built with Flutter 3.29.3 that allows users to browse movies, search for films, view details, and book seats with an intuitive seat selection interface.

## 📱 Features

### 🎯 Core Features
- **Movie Browsing**: Discover upcoming movies with beautiful card layouts
- **Advanced Search**: Find movies by title with real-time search results
- **Movie Details**: View comprehensive movie information including genres, overview, and trailers
- **Seat Selection**: Interactive seat maps with zoom functionality
- **Date & Time Selection**: Choose show dates and screening times
- **Responsive Design**: Optimized for mobile, tablet, and desktop devices

### 🎨 UI/UX Features
- **Responsive Layout**: Adapts seamlessly to different screen sizes
- **Modern Design**: Clean, intuitive interface with smooth animations
- **Zoom Controls**: Interactive zoom for detailed seat maps
- **Custom Widgets**: Reusable components for consistent design
- **Error Handling**: Robust image loading with fallbacks

## 🛠 Tech Stack

### Core Technologies
- **Flutter**: 3.29.3
- **Dart**: Latest stable version
- **Provider State Management**: For efficient state handling

### Key Packages
- `provider`: State management
- `cached_network_image`: Optimized image loading
- `google_fonts`: Typography
- `flutter_svg`: SVG support
- `shimmer`: Loading animations

## 📐 Responsive Design

The app features a comprehensive responsive design system:

### Breakpoints
- **Mobile**: < 768px
- **Tablet**: 768px - 1024px
- **Desktop**: ≥ 1024px

### Responsive Components
- **Grid Layouts**: Dynamic column count (2-4 columns)
- **Typography**: Scalable font sizes
- **Spacing**: Adaptive padding and margins
- **Navigation**: Responsive bottom navigation
- **Images**: Proper aspect ratios across devices

## 🏗 Project Structure

```
lib/
├── config/
│   ├── app_assets.dart      # Asset paths
│   └── app_theme.dart       # App colors and themes
├── models/
│   └── tmdb_models.dart     # Movie data models
├── providers/
│   ├── booking_provider.dart      # Booking state management
│   ├── movie_detail_provider.dart  # Movie details state
│   └── movie_list_provider.dart    # Movie list state
├── screens/
│   ├── movie_detail_screen.dart    # Movie details page
│   ├── movie_list_screen.dart      # Dashboard (non-responsive)
│   ├── search_screen.dart          # Search functionality
│   ├── seat_selection_screen.dart  # Date/time selection
│   └── selection_detail_screen.dart # Seat selection with zoom
├── utils/
│   └── responsive_utils.dart       # Responsive design utilities
├── widget/
│   ├── custom_bottom_nav.dart      # Bottom navigation
│   ├── detail_seat_map_widget.dart # Detailed seat map
│   ├── mini_seat_map_widget.dart   # Mini seat map
│   ├── movie_card_widget.dart      # Movie card component
│   └── ...                         # Other custom widgets
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK: 3.29.3 or higher
- Dart SDK: Compatible with Flutter version
- Android Studio / VS Code with Flutter extensions
- Android SDK (for Android development)
- Xcode (for iOS development)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd movie_booking
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Build Commands

**Debug Build**
```bash
flutter run
```

**Release Build (Android)**
```bash
flutter build apk --release
```

**Release Build (iOS)**
```bash
flutter build ios --release
```

## 🎯 Key Features Implementation

### 🎬 Movie Management
- **TMDB Integration**: Fetches movie data from TMDB API
- **Image Loading**: Optimized caching with error handling
- **Search Functionality**: Real-time search with filtering

### 💺 Seat Selection System
- **Interactive Maps**: Visual seat selection with availability
- **Zoom Controls**: Zoom in/out for better visibility
- **Responsive Layout**: Adapts to different screen sizes
- **Booking State**: Manages selected seats and booking details

### 📱 Responsive Design System
- **ResponsiveUtils**: Centralized responsive utilities
- **Device Detection**: Automatic mobile/tablet/desktop detection
- **Dynamic Sizing**: Font sizes, padding, and layouts adapt to screen
- **Grid Management**: Dynamic column count based on screen width

## 🔧 Configuration

### API Configuration
Update your API keys and endpoints in the appropriate provider files.

### Theme Customization
Modify colors and themes in `lib/config/app_theme.dart`.

### Responsive Breakpoints
Adjust responsive breakpoints in `lib/utils/responsive_utils.dart`.

## 🐛 Troubleshooting

### Common Issues

**Build Errors**
- Ensure Flutter version is 3.29.3
- Run `flutter clean` and `flutter pub get`
- Check Android/iOS configuration

**Responsive Issues**
- Verify ResponsiveUtils implementation
- Check MediaQuery usage
- Test on different screen sizes

**Image Loading Issues**
- Check network connectivity
- Verify TMDB API configuration
- Review CachedNetworkImage implementation

## 📱 Platform Support

- **Android**: API level 21+ (Android 5.0+)
- **iOS**: iOS 11.0+
- **Web**: Supported (with responsive design)
- **Desktop**: Supported (with responsive design)




---

**Built with ❤️ using Flutter 3.29.3**
