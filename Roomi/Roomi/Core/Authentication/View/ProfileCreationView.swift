//
//  ProfileCreationView.swift
//  Roomi
//
//  Created by Alec Morrison on 10/28/24.
//

import SwiftUI

struct ProfileCreationView: View {
    @State private var name: String = ""
    @State private var selectedNumber = 18
    @State private var selectedGender = "Male"
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Text("Lets Get to Know You...")
                .fontWeight(.heavy)
                .font(.title)
                .padding(.bottom, 50)
            
            InputView(text: $name, title: "Name", placeholder: "Name")
            
            Text("Age")
                .font(.subheadline)
                .padding(.top, 20)
            Picker("Select a number", selection: $selectedNumber) {
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
            
            
            Text("Gender")
                .font(.subheadline)
                .padding(.top, 20)

            Picker("Select Gender", selection: $selectedGender) {
                ForEach(["Male", "Female"], id: \.self) { gender in
                    Text(gender)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            
            ButtonView(title: "Create Profile", background: .blue){
                Task {
                    // CALL VIEW MODEL SIGN UP METHOD
                    // try await viewModel.signUp(withEmail: email, password: password)
                }
            }
            .frame(height: 50)
            .padding()
            
        }
        .padding()
            
    }
}

#Preview {
    ProfileCreationView()
        .environmentObject(AuthViewModel())
}
