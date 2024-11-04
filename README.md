# Roomi
Roomi is a mobile application that allows users to find and connect with potential roommates that most closely align with their personal preferences/interests.

# Group Members
- Braden Castillo @bradenc24
- Benny Conte @Bennyyyyy
- Alec Morrison @alecmorrison
- Khang Chung @khangvchung
- Ryan Vo @ryanvo504
- Anderson Lee @andersonlee3

# Tech Stack
Our app will be developed on the iOS platform. Specifically, we have decided to use Swift/SwiftUI for the frontend and Firebase for the backend.

On the app, users will be able to swipe through different profiles and view information about potential roommates. Based on the information they see, they can decide to "match" and get in touch with them about becoming roommates. Additionally, users will be given suggestions on roommates which will help them find a match easier. These suggestions will be based on the information users give the app when creating their profiles. And this will be used to suggest matches based on similar preferences/interests/lifestyles.

# User Roles & Permissions
- Roommate Seeker: A user looking for a potential roommate and a place to stay, or a user who already has a place to stay but is looking for a roommate to help fill it.
- Admin/Moderator: A role that monitors and manages the app from inappropriate content, scams, etc.

We want our app to be available to a wide array of people to ensure we can maximize the amount of people we can help find roommates. Therefore, currently, we have decided not to restrict our user base to a specific domain.

# Installation

## Prerequisites
Download the latest version of XCode from the Apple Appstore

## Step 1: 
Clone the repository through HTTP or SSH by using git clone

## Step 2: 
Open the Roomi project with XCode and install the necessary dependencies by going to File -> Add Package Dependancies

- "firebase-ios-sdk"
- Specifically add FirebaseAuth and FirebaseFirestore to Roomi when prompted

## Step 3: 
If prompted to verify the Developer App certificate for your account is trusted on your device. Open Settings on the device and navigate to General -> VPN & Device Management, then select your Developer App certificate to trust it

## Step 4:
Sign into your apple id, change the bundle identifier to yours, and select a development team in the Signing & Capabilities editor

## Step 5: 
Make sure your IPhone is plugged in and connected to the same wifi network, then choose it as a simulator then build and run


# Functionality
TODO: Write usage instructions. Structuring it as a walkthrough can help structure this section, and showcase your features.

# Known Problems
TODO: Describe any known issues, bugs, odd behaviors or code smells. Provide steps to reproduce the problem and/or name a file or a function where the problem lives.
