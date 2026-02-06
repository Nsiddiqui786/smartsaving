# SmartSaving - Smart Price Tracking for Indians

A production-ready Flutter application that helps Indian users save money by comparing product prices across Amazon and Flipkart, tracking price history, predicting future prices, and notifying about price drops.

## 🚀 Quick Start

### Prerequisites

- Flutter 3.10+
- Dart 3.10+
- Android API 21+ or iOS 11+

### Installation & Run

```bash
# Get dependencies
flutter pub get

# Run the app
flutter run

# Or run on specific device
flutter run -d [device_id]
```

## ✨ Features

- **🔐 Authentication** - Email/password login with persistent sessions
- **🔍 Product Search** - Search across 8+ popular products
- **💰 Price Comparison** - Real-time Amazon vs Flipkart pricing
- **📊 Price History** - Interactive charts with trend analysis
- **🤖 Price Prediction** - AI-powered "best time to buy" recommendations
- **🔔 Price Alerts** - Local notifications when prices drop
- **❤️ Wishlist** - Track favorite products with one tap
- **₹ Indian Formatting** - All prices in INR with proper formatting

## 🏗️ Architecture

- **State Management**: Riverpod (reactive & type-safe)
- **Architecture**: Clean Architecture + MVVM
- **Storage**: Shared Preferences (local)
- **UI**: Material Design 3
- **Notifications**: Flutter Local Notifications

## 📁 Project Structure

```
lib/
├── main.dart              # App entry & routing
├── models/                # Data models
├── services/              # Business logic & mock APIs
├── providers/             # Riverpod state management
├── screens/               # UI screens
├── widgets/               # Reusable components
└── utils/                 # Utilities & constants
```

## 🧪 Demo Credentials

The app works with mock data. Try any email/password:

- **Email**: test@example.com
- **Password**: password123

## 📱 Screens

1. **Splash** - App initialization
2. **Login/Register** - User authentication
3. **Home** - Tab-based navigation
   - Search & browse products
   - Tracked products dashboard
   - User profile
4. **Product Detail** - View & compare prices
5. **Price History** - Charts & predictions

## 🔌 Mock APIs Included

- **AmazonService** - 8 popular products with dynamic pricing
- **FlipkartService** - Same products with varied prices
- **PricePredictionService** - Trend-based price forecasting

Ready to swap with real APIs - no UI changes needed!

## 🛠️ Key Dependencies

```yaml
flutter_riverpod: ^2.4.0 # State management
shared_preferences: ^2.2.2 # Local storage
fl_chart: ^0.64.0 # Price history charts
intl: ^0.19.0 # Localization & formatting
flutter_local_notifications: ^14.1.0 # Notifications
```

## 📦 Build for Release

```bash
# Android
flutter build apk --release
flutter build appbundle --release

# iOS
flutter build ios --release
```

## 📚 Full Documentation

See [ARCHITECTURE.md](ARCHITECTURE.md) for:

- Detailed project structure
- API integration guide
- Customization options
- Production checklist
- Troubleshooting

## 🎯 Next Steps

1. ✅ Run the app
2. Login with any email/password
3. Search for products
4. Compare prices
5. Track products
6. Check price history & predictions
7. Set price alerts

## 💡 Real API Integration

To connect real APIs:

1. Update `lib/services/amazon_service.dart` - replace mock methods
2. Update `lib/services/flipkart_service.dart` - replace mock methods
3. Add API authentication in `auth_service.dart`
4. All UI screens remain unchanged!

## 📋 What's Included

- ✅ Complete Flutter project
- ✅ 8+ Mock products with realistic pricing
- ✅ Full authentication system (login/register)
- ✅ Price comparison & history
- ✅ Trend-based price prediction
- ✅ Local notifications
- ✅ Persistent user sessions
- ✅ Responsive Material Design
- ✅ Error handling & loading states
- ✅ Production-ready code structure

## 🚀 Ready to Use

The app is:

- ✅ Fully functional with mock data
- ✅ Production-ready code quality
- ✅ Scalable architecture
- ✅ Easy to customize
- ✅ Ready for real API integration

## 📝 Notes

- All prices in ₹ INR format
- Date formatting for Indian locale
- 24-hour price update simulation
- Mock data updates in real-time
- Works offline (cached data)

---

**Made with ❤️ for Indians | Market-ready | Easy to extend**
