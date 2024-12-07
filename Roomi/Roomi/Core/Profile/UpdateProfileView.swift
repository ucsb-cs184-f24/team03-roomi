//
//  SwiftUIView.swift
//  Roomi
//
//  Created by Benjamin Conte on 11/22/24.
//

import SwiftUI

struct UpdateProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    @State private var name: String
    @State private var age: Int
    @State private var gender: String
    @State private var phoneNumber: String
    @State private var schoolWork: String
    @State private var bio: String
    @State private var drugs: String
    @State private var petFriendly: Bool
    @State private var social: String
    
    init(user: User?) {
        _name = State(initialValue: user?.name ?? "")
        _age = State(initialValue: user?.age ?? 18) // Default age to 18
        _gender = State(initialValue: user?.gender ?? "")
        _phoneNumber = State(initialValue: user?.phoneNumber ?? "") // Default to empty string
        _schoolWork = State(initialValue: user?.schoolWork ?? "")
        _bio = State(initialValue: user?.bio ?? "")
        _drugs = State(initialValue: user?.drugs ?? "")
        _petFriendly = State(initialValue: user?.petFriendly ?? false)
        _social = State(initialValue: user?.social ?? "")
    }
    
    var body: some View {
        VStack {
            Text("Profile")
                .font(.title)
            
            Form {
                Section(header: Text("Name")) {
                    TextField("Enter your name", text: $name)
                }
                
                Section(header: Text("Age")) {
                    TextField("Enter your age", value: $age, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Gender")) {
                    Picker("Gender", selection: $gender) {
                        Text("Male").tag("Male")
                        Text("Female").tag("Female")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Phone Number")) {
                    TextField("Enter your phone number", text: $phoneNumber)
                        .keyboardType(.phonePad)
                }
                
                Section(header: Text("School/Work")) {
                    TextField("Enter your phone number", text: $schoolWork)
                }
                
                Section(header: Text("Bio")) {
                    TextField("Enter your bio", text: $bio, axis: .vertical)
                        .lineLimit(1...7) // Allow up to 5 lines of text
                }
                
                Section(header: Text("Social")) {
                    Picker("Social", selection: $social) {
                        Text("Introverted").tag("Introverted")
                        Text("Both").tag("Both")
                        Text("Extroverted").tag("Extroverted")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Alcohol / 420")) {
                    Picker("Gender", selection: $drugs) {
                        Text("Neither").tag("Neither")
                        Text("420 Only").tag("420 Only")
                        Text("Alc Only").tag("Alc Only")
                        Text("Both").tag("Both")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Pet Friendly")) {
                    Picker("Pet Friendly", selection: $petFriendly) {
                        Text("Yes").tag(true)
                        Text("No").tag(false)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            
            Spacer()
            
            ButtonView(title: "Update Profile") {
                Task {
                    do {
                        try await viewModel.updateProfile(user: User(id: "", email: "", name: name, age: age, gender: gender, phoneNumber: phoneNumber, schoolWork: schoolWork, bio: bio, social: social, drugs: drugs, petFriendly: petFriendly))
                        dismiss()
                    } catch {
                        print("Error updating profile")
                    }
                }
            }
            .frame(width: 150, height: 50)
            .padding()
        }
    }
}

#Preview {
    UpdateProfileView(user: User(id: "", email: "", name: "", age: 0, gender: "", phoneNumber: "", schoolWork: "", bio: "", social: "", drugs: "", petFriendly: true))
        .environmentObject(AuthViewModel())
}
