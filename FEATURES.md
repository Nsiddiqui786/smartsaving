# SmartSaving - Feature Guide & Test Instructions

Complete walkthrough of all features and how to test them.

## 🚀 Quick Feature Overview

SmartSaving has 7 main features. Here's what you can do:

### 1. 🔐 Authentication

- **Create Account** - Sign up with any email/password
- **Login** - Persistent sessions (auto-login)
- **Logout** - Clear session from profile

**How to Test:**

1. Launch app → Splash screen appears
2. Tap "Sign Up" → Create account with:
   - Email: `test@example.com`
   - Name: `John Doe`
   - Password: `password123`
3. Auto-logged in to Home screen
4. Profile tab → Tap Logout button → Back to Login

### 2. 🔍 Product Search

Search across 8 popular products in real-time.

**Available Products:**

- Apple iPhone 15 Pro
- Samsung Galaxy S24
- Sony WH-1000XM5 Headphones
- Dell XPS 13 Laptop
- iPad Air 2024
- Apple Watch Series 9
- Canon EOS R6 Camera
- LG 55" 4K Smart TV

**How to Test:**

1. Home → First tab (Search)
2. Search box at top
3. Type:
   - "iPhone" → Shows Apple products
   - "Samsung" → Samsung phones
   - "Sony" → Audio products
   - Leave empty → Shows all products
4. Results load with price, rating, reviews
5. Tap product card → See details

### 3. 💰 Price Comparison

Compare prices between Amazon and Flipkart.

**What You See:**

- Best price (₹)
- Platform (Amazon / Flipkart)
- Savings amount
- Both platform prices side-by-side

**How to Test:**

1. Search for any product
2. Tap product card → Product Detail screen
3. See "Price Comparison" card showing:
   - Amazon price (₹)
   - Flipkart price (₹)
   - Which is cheapest (highlighted in green)
   - Total savings if you buy from cheaper
4. Prices update realistically (±5%)

### 4. ❤️ Product Tracking

Add products to your personal watchlist.

**How to Test:**

1. Home → Search tab → Find a product
2. Tap "Track" button (blue)
3. Button changes to "Untrack" (red)
4. Top right shows "Tracked" badge
5. Home → Tracked tab → See all tracked items
6. Tap "Untrack" to remove

### 5. 📊 Price History & Charts

View interactive price trend graphs.

**Features:**

- Line chart showing price over time
- Date labels on X-axis
- Price values on Y-axis
- Historical price snapshots
- Price change indicators (↑ ↓)

**How to Test:**

1. Track a product (must be tracked first)
2. Product Detail → Tap "Price History" button
3. Charts show historical prices
4. Scroll down to see:
   - Full price history list
   - Each entry shows both platforms
   - Price trend icons (up/down/flat)

### 6. 🤖 Price Prediction

Get "Best Time to Buy" recommendations.

**Prediction Shows:**

- Current price (₹)
- Predicted next price (7 days)
- Confidence score (30%-90%)
- Recommendation:
  - "Buy Now" - Price likely to increase
  - "Wait" - Price likely to decrease
  - "Hold" - Price likely stable
- Amount you can save if wait

**How to Test:**

1. Price History screen → Scroll to bottom
2. See "Price Prediction" card with:
   - Current price vs Predicted
   - Green/red indicators
   - Helpful message
3. Prediction updates when price history changes

### 7. 🔔 Price Alerts & Notifications

Set target prices and get notified when prices drop.

**Features:**

- Set target price (₹)
- Local notifications
- Alert history tracking
- Multiple alerts per product

**How to Test:**

1. Product Detail → "Track" product
2. After tracking, tap "Set Price Alert"
3. Enter target price (e.g., 50000)
4. Tap "Save"
5. Alert is set (notification permissions may be requested)
6. Note: Mock notifications show as local alerts

## 📱 Complete User Journey

### First Time User

```
Splash → Register → Home Search → Track Product
→ Product Detail → Compare Prices → Set Alert → View History
```

### Returning User

```
Splash → Auto-Login → Home → Browse Tracked → View History
```

### Session Flow

```
Login/Register → Home (3 tabs) → Specific Feature → Return to Home
```

## 🧪 Detailed Testing Scenarios

### Scenario 1: Complete Purchase Research

**Goal:** Research a product thoroughly before buying

```
1. Search "iPhone 15 Pro"
2. View product details (1000+ reviews, 4.8★)
3. Compare prices (Amazon ₹79,900 vs Flipkart ₹79,450)
4. Track the product
5. Set alert for ₹70,000 (target price)
6. View price history & prediction
7. Check "Buy Now" or "Wait" recommendation
8. Come back later to check updated prices
```

### Scenario 2: Track Multiple Products

**Goal:** Monitor several products at once

```
1. Search and track "iPhone 15 Pro"
2. Search and track "Samsung Galaxy S24"
3. Search and track "Sony Headphones"
4. Go to Tracked tab
5. See all 3 products with current prices
6. Compare side-by-side
7. Set alerts on 2 products
8. Untrack one product
```

### Scenario 3: Price Monitoring Over Time

**Goal:** Track price trends

```
1. Track a product
2. View its full price history
3. See prices from different dates
4. View interactive chart
5. Check prediction (7-day forecast)
6. See recommended action
7. Expected price change (±₹500-2000)
```

### Scenario 4: Account Management

**Goal:** Create account and manage profile

```
1. Register with:
   - Name: "Rajesh Kumar"
   - Email: "rajesh@example.com"
   - Password: "secure123"
2. Immediately logged in
3. Profile tab shows:
   - Name: Rajesh Kumar
   - Email: rajesh@example.com
4. Track some products
5. Come back (auto-login works)
6. All tracked products still there
7. Logout
8. Login again with same credentials
```

## 🎯 Feature Testing Checklist

### Authentication

- [ ] Register new user
- [ ] Login with same credentials
- [ ] Auto-login works
- [ ] Logout clears session
- [ ] Cannot access protected screens without login

### Product Search

- [ ] Search finds products by name
- [ ] Empty search shows all products
- [ ] Results appear instantly
- [ ] Product cards show rating/reviews
- [ ] Track button works from card

### Price Comparison

- [ ] Shows both platform prices
- [ ] Calculates best price correctly
- [ ] Highlights cheaper option
- [ ] Savings calculation is accurate
- [ ] Prices vary realistically

### Product Tracking

- [ ] Track button changes state
- [ ] Tracked items appear in dashboard
- [ ] Can track multiple products
- [ ] Can untrack easily
- [ ] Persistence works (stays tracked after app restart)

### Price History

- [ ] Chart displays correctly
- [ ] Shows historical data
- [ ] Price trends are visible
- [ ] Dates are formatted correctly
- [ ] Can scroll through history

### Price Prediction

- [ ] Shows confidence score
- [ ] Recommendation is logical
- [ ] Saves amount is calculated
- [ ] Updates with new data
- [ ] 7-day forecast makes sense

### Profile & Settings

- [ ] User info displays correctly
- [ ] Logout button works
- [ ] About section visible
- [ ] Privacy policy link present
- [ ] Session persists across app restarts

## 📊 Expected Data Patterns

### Price Ranges (INR ₹)

- Smartphones: ₹34,000 - ₹79,999
- Audio: ₹15,000 - ₹22,999
- Laptops: ₹89,999 - ₹99,999
- Tablets: ₹49,999 - ₹59,999
- Watches: ₹29,999 - ₹34,999
- Cameras: ₹129,999 - ₹189,999
- TVs: ₹39,999 - ₹49,999

### Price Variations

- Daily change: ±₹500 - ₹2,000
- Platform diff: 1-5% usually
- Seasonal spikes: Up to 15% during sales
- Predictions: ±3-8% accuracy

### Ratings

- Most products: 3.5★ - 4.8★
- Review counts: 100 - 5000+
- Varies by product type

## 🔧 Customization for Testing

### Change Mock Data

Edit `lib/services/amazon_service.dart`:

```dart
'basePrice': 50000,  // Change base price
'discount': 0.20,    // Change discount percentage
```

### Change Number of Products

Add more entries to `mockProducts` list in both services.

### Change Price Update Frequency

Edit `services/amazon_service.dart`:

- `Random().nextDouble() * 0.05` - Changes ±% variation
- Adjust multiplier for bigger/smaller changes

## 💡 Tips for Testing

1. **Fresh Start**: Logout and login to test persistence
2. **Multiple Products**: Track 3+ products for better UI experience
3. **Price Changes**: Reload app to see price updates
4. **Different Amounts**: Set alerts at 80%, 70%, 60% of current price
5. **Fast Navigation**: Use tabs to switch between features quickly
6. **Test Notifications**: Set alert slightly below current price (will trigger)
7. **Chart Viewing**: Zoom or pan on price history chart if available
8. **Error States**: Try invalid inputs to see error messages

## 🎬 Demo Script (5 Minute)

For quick product demo:

```
Time 0:00 - Launch and Register
"Welcome to SmartSaving! Let me create an account..."
[Show registration screen, fill details]

Time 0:45 - Search Products
"Let's search for an iPhone 15 Pro..."
[Show search results with ratings]

Time 1:30 - Compare Prices
"See how prices differ between platforms?"
[Highlight comparison card, show savings]

Time 2:15 - Track Product
"Track it to monitor the price..."
[Tap track, show in tracked tab]

Time 3:00 - Price History
"View the price trend over time..."
[Show chart and historical data]

Time 3:45 - Price Prediction
"Get AI recommendations..."
[Show prediction with buy/wait suggestion]

Time 4:30 - Set Alert
"Get notifications when price drops..."
[Set alert, explain notification]

Time 5:00 - Summary
"SmartSaving helps you save money on e-commerce!"
```

## 🚀 Ready to Go!

You now understand all features. Start testing and exploring!

Next: See [ARCHITECTURE.md](ARCHITECTURE.md) for code details or [SETUP.md](SETUP.md) for installation help.

---

**Happy Testing! 🎉**
