

# Flutter Demo App

This Flutter project consists of two main features:
1. **Main Page**: Displays a list of items with infinite scrolling and search functionality.
2. **Login Page**: Implements phone number login functionality with animations.
2. **Detail Page**: Displays the item with more data about it.

## Features

### Main Page
- **Infinite Scrolling**: Fetches items in paginated form and appends them to the list as the user scrolls.
- **Search Functionality**: Allows users to search for items by title.
- **Dynamic UI**: Integrates a gradient background and a list view with animated transitions for better user experience.
- **Error Handling**: Displays error messages in case the data fetching fails.

### Login Page
- **Phone Number Validation**: Uses regular expressions to validate the phone number input.
- **Slide & Fade Animations**: Features smooth slide-up form animation and fade-in for the welcome text.
- **Responsive Design**: Adapts to both portrait and landscape modes.
- **Contact Support**: Provides a direct link for users to contact the developer.

## Project Structure

```
lib/
│
├── models/
│   └── item_model.dart       
├── repositories/
│   └── item_repository.dart   
├── screens/
│   ├── main_page.dart       
│   ├── login_page.dart      
│   └── detail_page.dart    
└── main.dart                
```
## Setup Instructions

### Prerequisites
Ensure that you have the following:
- Flutter installed ([Flutter installation guide](https://flutter.dev/docs/get-started/install))
- A working mobile device emulator or a physical device for testing

### Steps to Run the App

1. Clone the repository:
   ```bash
   git clone https://github.com/rezk1834/intern_demo_app.git
   cd intern_demo_app
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app on your emulator or device:
   ```bash
   flutter run
   ```



