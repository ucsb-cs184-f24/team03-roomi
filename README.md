# Roomi
Roomi is a mobile application that allows users to find and connect with potential roommates that most closely align with their personal preferences/interests. On the app, users will be able to swipe through different profiles and view information about potential roommates. Based on the information they see, they can decide to "match" and get in touch with them about becoming roommates. Additionally, users will be given suggestions on roommates which will help them find a match easier. These suggestions will be based on the information users give the app when creating their profiles. And this will be used to suggest matches based on similar preferences/interests/lifestyles.

# Group Members
- Braden Castillo @bradenc24
- Benny Conte @Bennyyyyy
- Alec Morrison @alecmorrison
- Khang Chung @khangvchung
- Ryan Vo @ryanvo504
- Anderson Lee @andersonlee3

## Tech Stack
- Platform: iOS
- Languages: Swift
- Backend: Firebase (for real-time database and user authentication)


## User Roles and Permissions
There are two types of users:

### Users:
- look for a potential roommate and a place to stay, or a user who already has a place to stay but is looking for a roommate to help fill it.

### Admins:
- Have all user capabilities.
- monitor and manages the app from inappropriate content, scams, etc.

We want our app to be available to a wide array of people to ensure we can maximize the amount of people we can help find roommates. Therefore, currently, we have decided not to restrict our user base to a specific domain.

# Installation
To deploy the Bathroom Finder app, please follow these instructions:

## Prerequisites:
- Xcode 15 or later
- Swift 5.x
- An Apple Developer account (for device deployment)

## Dependencies:
- Firebase Authentication
- Firebase Firestore

## Installation Steps
Clone the repository through HTTP or SSH by using git clone

### Install Dependencies:
Open the Roomi project with XCode and install the necessary dependencies by going to File -> Add Package Dependancies

- "firebase-ios-sdk"
- Specifically add FirebaseAuth and FirebaseFirestore to Roomi when prompted

### Trust Device
If prompted to verify the Developer App certificate for your account is trusted on your device. Open Settings on the device and navigate to General -> VPN & Device Management, then select your Developer App certificate to trust it

### Sign In and Select Dev team
Sign into your apple id, change the bundle identifier to yours, and select a development team in the Signing & Capabilities editor

### Build and Run:
- Select your target device and ensure it’s connected or use the simulator.
- Make sure your IPhone is plugged in and connected to the same wifi network
- Click Run in Xcode to deploy to your selected device or simulator.

### Deployment:
- Our application is not deployable because we do not have an apple developer's account.
- The closest we could get to "Deployment" was by following our Build and Run steps above.

## Functionality:
See User Manual at teams/MANUAL.md

## Known Problems 
TODO: Describe any known issues, bugs, odd behaviors or code smells. Provide steps to reproduce the problem and/or name a file or a function where the problem lives.



