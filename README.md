## 📈 Bitcoin Price Tracker
A Swift-based iOS app that displays the historical price of Bitcoin over the past 14 days, including today’s real-time price. The app updates today’s Bitcoin price every 60 seconds and allows users to tap on a date to see detailed pricing in multiple currencies.

![iCoin Screenshot](https://momeks.com/uploader/media/Screenshot-2026-02-26-at-3-54-29---PM-1772117677.png)

### 🧭 Features
*    Historical Prices: View Bitcoin prices for the past 2 weeks, including today.
*    Live Updates: Today’s price is updated in real-time every 60 seconds.
*    Detail View: Tap on a specific day to view Bitcoin prices in EUR, USD, and GBP.

### 🧱 Architecture
This project follows the MVVM (Model-View-ViewModel) architecture, ensuring a clear separation of concerns between UI, business logic, and data handling. It is designed with modularity and maintainability in mind.

#### 🧩 Modular Design
The app is structured into distinct, reusable Swift modules:
*    CoinKit: Contains domain models and logic related to cryptocurrency data.
*    NetworkKit: Responsible for all networking tasks, such as API requests and decoding, utilizing native Swift features.

This modular setup allows for better testability, separation of responsibilities, and potential reuse in other projects.

####  ⚙️ Swift Concurrency
The project makes extensive use of Swift Concurrency features, including:
*    async/await for asynchronous tasks like fetching data from APIs
*    Structured concurrency to manage task lifecycles in a safe and readable way

Using Swift Concurrency improves performance and readability while reducing the complexity of callback-based code.

#### 🧼 Clean Principles
*    Single Responsibility Principle: Each class, struct, and module serves a clear and distinct purpose.
*    Clear boundaries between presentation, business logic, and data layers
*    Dependency injection for flexibility and testability

This design keeps the codebase scalable, testable, and easy to extend.

#### 🧪 Testing
The app includes unit tests that cover all important code paths, focusing on:
* Use case logic
* View model behavior
* Network responses (with mock data)

Tests are written pragmatically to ensure correctness while keeping test maintenance minimal.

#### 🔐 Security
This project takes API key protection seriously by using Obfuscator to encode the API key, helping prevent static extraction from the app binary.

#### 🔌 Data Source
All Bitcoin price data in this app is fetched in real-time from the [CoinGecko API](https://api.coingecko.com/api/v3), a free and open cryptocurrency data provider. For more information about the available endpoints and usage, refer to the official documentation:  
[https://docs.coingecko.com/v3.0.1/reference/coins-list](https://docs.coingecko.com/v3.0.1/reference/coins-list)

## 📦 Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/Momeks/iCoin.git
   ```
2. Open `iCoin.xcodeproj` in Xcode.
3. Run on a simulator or device.
