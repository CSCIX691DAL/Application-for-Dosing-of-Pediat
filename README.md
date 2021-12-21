# Application-for-Dosing-of-Pediat (Dosing App)

## Guide to Running App

### Step 1: Clone Repo
- Set your global git variables if they arent already set:

  `git config --global user.name "John Doe"`

  `git config --global user.email your_git_email@email.com`

- Open a terminal and type `git clone https://github.com/CSCIX691DAL/Application-for-Dosing-of-Pediat.git`

### Step 2: Install Flutter

- Depending on if you're on macOS or Windows, your installation may be different.
- Follow the Flutter docs to install Flutter on your machine: https://docs.flutter.dev/get-started/install

### Step 3: Install Simulator

- You will be able to run this app in Google Chrome, an Android Simulator, and/or an iOS Simulator
- To run the app in Google Chrome, simply have it installed and that will suffice

  #### iOS

  - Download XCode from the mac App Store, make sure to install Developer Command-Line tools
  - Once installed, you can use XCode, but I suggest VS Code or another text editor to modify the code
  - You can open the simulator by either searching your mac for 'Simulator' or by typing the following into your terminal:

    `open -a simulator`

  #### Android

  - Download Android Studio
  - Follow Flutter docs linked above to follow the steps of setting up an Android simulator

### Step 4: Run the App

- To run the app, navigate to the directory `Application-for-Dosing-of-Pediat/dosing_app`
- Run `flutter doctor` to make sure everything is in order to run the app, some tests may fail, but as long as the simulator you want to use passes the doctor test, your should be okay
- Run the app `flutter run`
