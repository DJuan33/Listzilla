# Listzilla

Listzilla is a Free Libre Open Source Task Management app that increase your productivity (or I hope so 😀).

## Table of contents

- [Listzilla](#listzilla)
  - [Table of contents](#table-of-contents)
  - [Features](#features)
  - [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
  - [Using Listzilla](#using-listzilla)
    - [Running the app](#running-the-app)
    - [Building the app](#building-the-app)
    - [Releases](#releases)
  - [License](#license)
  - [Contributing](#contributing)
    - [Issues](#issues)
    - [Suggestions](#suggestions)
    - [Pull Requests](#pull-requests)
  - [What's Next?](#whats-next)
    - [TODO](#todo)
    - [Another projects](#another-projects)
  - [About the Author](#about-the-author)

## Features

- 🛠️ State management with [BLoC](https://bloclibrary.dev/#/).

- 📚 Local Database with [Hive](https://github.com/hivedb/hive).

- 📐 Developed following [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) principles.

## Getting Started

### Prerequisites

- 🖥️ The [Flutter SDK](https://flutter.dev/docs/get-started/install) 2.0 or Higher

- 📱 An Android device.

- 📝 A Text Editor like [VIM](https://www.vim.org/) or [VSCode](https://code.visualstudio.com/).

### Installation

Clone this repository:

`$ git clone https://github.com/DJuan33/Listzilla`

Get Flutter packages:

`$ flutter pub get`

## Using Listzilla

### Running the app

Keep in mind that Listzilla it's developed with Null Safety. Check the [Flutter Docs](https://flutter.dev/docs/null-safety) for more information about Null Safety.

Run the app with the command:

`$ flutter run`

### Building the app

Build an APK file with the command:

`$ flutter build apk --split-per-abi`

### Live testing

Check a live web version of the app: [Listzilla Web](https://djuan33.github.io/listzilla-web/).

## License

Listzilla uses some Dart Packages that have his own licenses, check the [pubspec file](/pubspec.yaml) for a list of current packages utilized in the project. The font used in the app (Encoding sans) use the [Open Font Licence](https://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=OFL).

However, the Listzilla source code is FLOSS under the GNU Public General License. Check the [LICENSE.md](/LICENSE) for more information.

## Contributing

### Issues

If you experiment some issue, I recommend first check that isn't a Flutter framework issue. However, you can open an issue in the [issue page](https://github.com/DJuan33/Listzilla/issues).

### Suggestions

I receive your suggestions in the [issues page](https://github.com/DJuan33/Listzilla/issues). Also, the [author](#about-the-author) receive suggestions in their social media profiles.

### Pull Requests

I'm not receiving pull requests at the moment, I want to make changes in the file structure, documenting code and Widget extracting. I'll accept PR in next releases (1.5).

## What's Next?

### TODO

I have a lot of changes and features in mind:

- [ ] UI Improvements.
- [X] Add an Calendar.
- [ ] Add Better illustrations.

Coding improvements:

- [ ] Better implementation of BLoC.
- [ ] Improved variable access modifiers (I always forget to use the underscore).
- [ ] More custom Widgets (Yeah, more files).

### Another projects

The Listzilla ecosystem to another platforms.

- [X] Listzilla [Web version](https://github.com/DJuan33/Listzilla-Web).
- [ ] Create Listzilla Firebase Backend.

## About the Author

This is my first FLOSS project, so I'm glad to receive your comments and suggestions. You can follow me in social media:

- [Twitter](https://twitter.com/DJuan_33) for Listzilla news and personal opinions
- [LinkedIn](https://www.linkedin.com/in/djuan33/) if you want to hire me :D