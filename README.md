# 🌿 Eco Footprint Tracker

A beautiful Flutter application that helps users track their environmental impact, participate in eco-friendly challenges, and build sustainable habits.

## 📱 UI Design & Responsiveness

### Material Design 3 Implementation
- Custom color schemes based on user preference
- Adaptive components following Material guidelines
- Consistent typography and spacing
- Elevation and shadow hierarchies

### Responsive Layout
- Adaptive to different screen sizes
- Flexible grid system
- Dynamic font scaling
- Safe area handling
- Orientation support

### Interactive Elements
- Custom animated buttons
- Progress indicators
- Intuitive form inputs
- Gesture-based interactions
- Haptic feedback support

## ⚙️ Functionality & Core Features

### Quiz System
- Dynamic question loading
- Score calculation algorithm
- Result categorization:
  - 🌿 Eco-Warrior (Low Footprint)
  - 🍃 Eco-Learner (Moderate Footprint)
  - 🌪 Eco-Beginner (High Footprint)
- Personalized feedback generation

### Challenge Tracking
- 7-day No-Plastic Challenge
- Progress monitoring system
- Achievement badges
- Daily tips and reminders
- Completion celebration

### Profile Management
- User data handling
- Progress dashboard
- Achievement tracking
- Settings management
- Theme preferences

## 🏗 Code Structure & Architecture

### Project Organization
```
lib/
├── screens/         # UI screens
├── providers/       # State management
├── models/          # Data models
├── widgets/         # Reusable components
├── utils/          # Helper functions
└── constants/      # App constants
```

### Clean Architecture
- Separation of concerns
- SOLID principles
- DRY code practices
- Efficient resource management
- Modular components

### State Management
- Provider implementation
- Centralized state handling
- Efficient widget rebuilds
- Data persistence
- Error handling

## 🔄 Navigation & State Handling

### Navigation System
- Bottom navigation bar
- Screen transitions
- Route management
- Deep linking support
- Navigation state preservation

### State Management Features
- User preferences
- Quiz progress
- Challenge status
- Theme settings
- Profile data

## ✨ Bonus Features

### Animations
- Custom screen transitions
- Progress animations
- Loading indicators
- Interactive feedback
- Micro-interactions

### Dark Mode
- System-based auto switch
- Manual toggle option
- Preserved preference
- Custom color palettes
- Smooth transition

### Firebase Integration (In Progress)
- User authentication
- Data persistence
- Real-time updates
- Analytics integration
- Cloud storage

## 🚀 Setup & Installation

### Prerequisites
```bash
Flutter: Latest stable version
Dart SDK: >=3.2.3 <4.0.0
iOS: Latest Xcode
Android: Latest Android Studio
```

### Step-by-Step Setup
1. **Clone & Setup**
   ```bash
   git clone <repository-url>
   cd eco_footprint
   flutter pub get
   ```

2. **iOS Setup**
   ```bash
   cd ios
   pod install
   cd ..
   ```

3. **Run Configuration**
   ```bash
   # Development
   flutter run

   # Release
   flutter run --release
   ```

### Feature Configuration
1. **Theme Setup**
   - Enable dark mode in profile
   - Customize color scheme
   - Set up animations

2. **Quiz Configuration**
   - Update questions in `quiz_provider.dart`
   - Adjust scoring system
   - Customize feedback

3. **Challenge Setup**
   - Configure duration
   - Set up notifications
   - Customize badges

## 🔍 Testing & Quality

### Automated Tests
- Unit tests for core logic
- Widget tests for UI
- Integration tests
- Provider tests
- Navigation tests

### Performance Metrics
- Fast startup time
- Smooth animations
- Efficient state management
- Optimized resource usage
- Minimal battery impact

## 🤝 Contributing

We welcome contributions! Please follow these steps:
1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## 📝 License

MIT License - See LICENSE file for details.

---
*Built with 💚 for a greener future*
