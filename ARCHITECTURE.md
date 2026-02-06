# SmartSaving - Price Comparison & Tracking App

A production-ready Flutter application that helps Indian users save money by comparing product prices across Amazon and Flipkart, tracking price history, predicting future prices, and setting price alerts.

## Features

✅ **User Authentication**

- Email/password signup and login
- Persistent session management
- Secure logout

✅ **Product Search & Listing**

- Real-time product search
- Price comparison across platforms
- Beautiful product cards with ratings
- One-tap tracking

✅ **Price Comparison**

- Side-by-side Amazon vs Flipkart prices
- Automatic best price highlighting
- Savings calculation

✅ **Price History & Analytics**

- Interactive price trend charts
- Historical price snapshots
- 7-day, 30-day, 90-day views

✅ **Price Prediction**

- AI-powered price trend analysis
- "Best time to buy" recommendations
- Confidence scores

✅ **Price Alerts**

- Set target prices for tracked products
- Local notifications on price drops
- Real-time alert triggering

✅ **Tracked Products Dashboard**

- Personalized product watchlist
- Quick price updates
- One-tap access to price history

## Tech Stack

- **Framework**: Flutter 3.10+
- **Language**: Dart
- **State Management**: Riverpod 2.4.0
- **Local Storage**: Shared Preferences
- **Charts**: FL Chart
- **Notifications**: Flutter Local Notifications
- **Architecture**: Clean Architecture with MVVM pattern

## Project Structure

```
lib/
├── main.dart                          # App entry point & routing
├── models/                            # Data models
│   ├── user.dart                      # User profile
│   ├── product.dart                   # Product data
│   ├── tracked_product.dart           # Tracked product + history
│   └── price_alert.dart               # Price alert config
├── services/                          # Business logic
│   ├── auth_service.dart              # Authentication
│   ├── storage_service.dart           # Local data persistence
│   ├── amazon_service.dart            # Amazon mock API
│   ├── flipkart_service.dart          # Flipkart mock API
│   ├── price_comparison_service.dart  # Cross-platform comparison
│   ├── price_prediction_service.dart  # ML-like predictions
│   └── notification_service.dart      # Local notifications
├── providers/                         # Riverpod state management
│   ├── auth_provider.dart             # Auth state
│   ├── product_provider.dart          # Product search & listing
│   ├── tracked_products_provider.dart # Tracked items state
│   └── price_prediction_provider.dart # Prediction state
├── screens/                           # UI screens
│   ├── splash_screen.dart             # App initialization
│   ├── login_screen.dart              # Email/password login
│   ├── register_screen.dart           # User registration
│   ├── home_screen.dart               # Tab-based home
│   ├── product_detail_screen.dart     # Product details + compare
│   └── price_history_screen.dart      # Charts & history
├── widgets/                           # Reusable components
│   ├── product_card.dart              # Product display card
│   ├── price_comparison_card.dart     # Price comparison UI
│   ├── loading_skeleton.dart          # Loading placeholders
│   └── app_bar.dart                   # Custom AppBar
└── utils/                             # Utilities
    ├── constants.dart                 # Colors, strings, dimensions
    ├── currency_formatter.dart        # INR formatting
    └── date_formatter.dart            # Date formatting
```

## Getting Started

### Prerequisites

- Flutter SDK 3.10+
- Dart 3.10+
- Android API level 21+ (for Android)

### Installation

1. **Clone the repository**

   ```bash
   cd c:\Project\smartsaving\temp\app2
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## API Layer Architecture

All API calls are abstracted through service classes, making it easy to swap mock APIs with real ones.

### Current Implementation (Mocks)

- **AmazonService**: Simulates Amazon India API
- **FlipkartService**: Simulates Flipkart API
- **PriceComparisonService**: Aggregates prices from both platforms
- **PricePredictionService**: Trends-based price prediction algorithm

### To Integrate Real APIs

1. Update `amazon_service.dart` to call real Amazon API
2. Update `flipkart_service.dart` to call real Flipkart API
3. No changes needed in UI/state management layers
4. All service methods maintain the same interface

## Key Components

### Authentication Flow

```
LoginScreen → AuthService → StorageService → Home
```

### Product Search Flow

```
SearchInput → ProductProvider → AmazonService/FlipkartService → ProductCards
```

### Price Tracking Flow

```
Track Button → TrackedProductsNotifier → StorageService → Dashboard
```

### Price History Flow

```
Track Product → PriceHistory Updates → PricePrediction → Charts
```

## Mock Data

The app includes realistic mock data for:

- 8 popular products (iPhones, Samsung, Sony, Dell, iPad, etc.)
- Dynamic pricing with realistic fluctuations (±5%)
- Varied discounts per platform
- Ratings and review counts

## Customization

### Add New Products

Edit `amazon_service.dart` and `flipkart_service.dart`:

```dart
static const List<Map<String, dynamic>> mockProducts = [
  {
    'id': 'prod_009',
    'name': 'New Product Name',
    'category': 'Category',
    'basePrice': 15000,
    'discount': 0.10,
  },
  // ... more
];
```

### Change App Colors

Update `utils/constants.dart`:

```dart
class AppColors {
  static const primary = 0xFF2196F3;  // Change this
  // ... more colors
}
```

### Adjust Formatting

Update `utils/currency_formatter.dart` for different number formats
Update `utils/date_formatter.dart` for different date formats

## State Management Pattern

Using Riverpod with clear separation:

```dart
// Providers control state
final authProvider = StateNotifierProvider(...);

// UI watches providers
ref.watch(authProvider)

// UI updates state
ref.read(authProvider.notifier).logout()
```

Benefits:

- Reactive data flow
- Easy testing
- Clear dependencies
- Type-safe

## Error Handling

All screens include:

- Loading states with skeleton loaders
- Error messages with retry buttons
- Graceful degradation
- Network error handling

## Performance Optimizations

- ✅ Lazy loading of providers
- ✅ Widget rebuild optimization
- ✅ Efficient state updates
- ✅ Cached product data
- ✅ Shimmer loading effects

## Testing

The app uses mock services that simulate:

- Network latency (300-1000ms)
- Dynamic pricing
- Price fluctuations
- Historical data

To test:

1. Login with any email/password (6+ chars)
2. Search for products
3. Track products
4. Set price alerts
5. View price history

## Notifications

Local notifications are pre-configured for:

- Price drop alerts
- Target price hits
- General notifications

On Android 11+, users must grant notification permissions when first triggered.

## Configuration

### Android Setup

Edit `android/app/build.gradle` if needed for API level or SDK version changes.

### iOS Setup

Edit `ios/Podfile` if needed for pod dependencies.

## Production Checklist

Before deploying to production:

- [ ] Replace mock APIs with real endpoints
- [ ] Add API authentication (OAuth/tokens)
- [ ] Implement proper error logging
- [ ] Add analytics tracking
- [ ] Set up crash reporting
- [ ] Update app icons and splash screen
- [ ] Test on multiple devices
- [ ] Set appropriate versioning
- [ ] Create privacy policy and terms
- [ ] Add backend database integration
- [ ] Implement real user authentication
- [ ] Set up CI/CD pipeline

## Building for Release

### Android

```bash
flutter build apk --release
# or
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

## Troubleshooting

### Packages not found

```bash
flutter pub get
flutter pub upgrade
```

### Build errors

```bash
flutter clean
flutter pub get
flutter run
```

### Hot reload not working

Use hot restart:

```bash
Press "r" in terminal or use
flutter run -d [device_id]
```

## License

This is a demonstration project. Feel free to use it as a template for your own projects.

## Support

For issues or questions, refer to:

- [Flutter Documentation](https://flutter.dev/docs)
- [Riverpod Documentation](https://riverpod.dev)
- [FL Chart Documentation](https://github.com/imaNNeoFighter/fl_chart)

---

**Built for Indian market with ₹ INR formatting and local notification support**
