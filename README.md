# SearchKeyword

## Overview

SearchKeyword is a simple yet powerful Flutter application that uses the Google Search API to generate and display keyword suggestions. It helps users discover related terms and variations, useful for content creation, SEO, and general search exploration.

## Features

- 🔍 **Search Functionality:**
    - Users can enter any word and view categorized suggestions.

- 📊 **Results Organized Into 4 Sections:**
    - **Suggestions**
    - **Alphabet Variations**
    - **Question Variations**
    - **Common Phrases**

- ⚙️ **Architecture & State Management:**
    - Built using **GetX** with `GetView`, routing, bindings, and controller structure.
    - Clean, responsive UI with a focus on performance and maintainability.

## Screenshots

*(Add your app screenshots here for visual context)*

## Dependencies

- [get](https://pub.dev/packages/get)
- [http](https://pub.dev/packages/http)
- [flutter](https://flutter.dev)

## Getting Started

1. Clone the repository:

    ```bash
    git clone https://github.com/pranavjoshi8240/searchkeyword.git
    ```

2. Navigate to the project directory:

    ```bash
    cd searchkeyword
    ```

3. Install dependencies:

    ```bash
    flutter pub get
    ```

4. Run the app:

    ```bash
    flutter run
    ```

## API Used

- Google Search API (via: `https://smart-words.vercel.app/api/suggestions?q=your_query`)

## Project Structure

- Uses GetX architecture: `Bindings`, `Controllers`, and `Views`
- Clean and scalable codebase for future enhancements

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

Feel free to contribute, raise issues, or suggest improvements!

