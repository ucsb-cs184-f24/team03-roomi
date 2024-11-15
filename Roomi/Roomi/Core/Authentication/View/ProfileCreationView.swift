//
//  ProfileCreationView.swift
//  Roomi
//
//  Created by Alec Morrison on 10/28/24.
//

import SwiftUI

struct ProfileCreationView: View, Hashable {
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var cardsViewModel: CardsViewModel
    @State private var name: String = ""
    @State private var selectedNumber = 18
    @State private var selectedGender = "Male"
    @State private var phoneNumber = ""
    
    var body: some View {
        VStack {
            // TODO ADD VALIDATION FOR THESE FIELDS
            
            
            Text("Lets Get to Know You...")
                .fontWeight(.heavy)
                .font(.title)
                .padding(.bottom, 50)
            
            // name input
            InputView(text: $viewModel.potentialUser.name, title: "Name", placeholder: "Name")
            
            // age selector
            Text("Age")
                .font(.subheadline)
                .padding(.top, 20)
            Picker("Select a number", selection: $viewModel.potentialUser.age) {
                ForEach(18...100, id: \.self) { number in
                    Text("\(number)")
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(maxWidth: .infinity)
            .frame(height: 100)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            
            // gender input
            Text("Gender")
                .font(.subheadline)
                .padding(.top, 20)
            Picker("Select Gender", selection: $viewModel.potentialUser.gender) {
                ForEach(["Male", "Female"], id: \.self) { gender in
                    Text(gender)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            // phone number input
            TextField("Enter your phone number", text: $viewModel.potentialUser.phoneNumber)
                .keyboardType(.numberPad) // Use number pad keyboard
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            ButtonView(title: "Create Profile", background: .blue){
                Task {
                    try await viewModel.signUp()
                    cardsViewModel.initialize()
                }
            }
            .frame(height: 50)
            .padding()
            
        }
        .padding()
            
    }
    
    // Conformance to Hashable
    static func == (lhs: ProfileCreationView, rhs: ProfileCreationView) -> Bool {
        // Implement equality check (e.g., compare properties)
        return true // Change as necessary based on your properties
    }
    
    func hash(into hasher: inout Hasher) {
        // Hash relevant properties if needed
    }
}

#Preview {
    ProfileCreationView()
        .environmentObject(AuthViewModel())
}
