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
    
    init(user: User?) {
        _name = State(initialValue: user?.name ?? "")
        _age = State(initialValue: user?.age ?? 18) // Default age to 18
        _gender = State(initialValue: user?.gender ?? "")
        _phoneNumber = State(initialValue: user?.phoneNumber ?? "") // Default to empty string
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
                    .pickerStyle(SegmentedPickerStyle()) // Use a segmented control for better UI
                }
                
                Section(header: Text("Phone Number")) {
                    TextField("Enter your phone number", text: $phoneNumber)
                        .keyboardType(.phonePad)
                }
            }
            
            Spacer()
            
            ButtonView(title: "Update Profile", background: .blue) {
                Task {
                    do {
                        try await viewModel.updateProfile(user: User(id: "", email: "", name: name, age: age, gender: gender, phoneNumber: phoneNumber, schoolWork: "", bio: "", social: "", drugs: "", petFriendly: true))
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
