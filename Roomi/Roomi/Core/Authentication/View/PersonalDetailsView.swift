//
//  PersonalDetailsView.swift
//  Roomi
//
//  Created by Alec Morrison on 11/26/24.
//

import SwiftUI

struct PersonalDetailsView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    @Binding var navigationPath: NavigationPath
    @State private var showError: Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: 0x4A90E2), Color(hex: 0x9013FE)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            
            VStack {
                Text("Who Are You?")
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .font(.title)
                    .padding(.bottom, 50)
                
                // name input
                Text("Full Name")
                    .font(.subheadline)
                    .foregroundColor(.white)
                TextField("Name", text: $viewModel.potentialUser.name)
                    .padding()
                    .frame(height: 55)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                    .onChange(of: viewModel.potentialUser.name) {
                        showError = false
                    }

                // age input
                Text("Age")
                    .font(.subheadline)
                    .foregroundColor(.white)
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
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)
                
                
                // gender input
                Text("Gender")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                Picker("Select Gender", selection: $viewModel.potentialUser.gender) {
                    ForEach(["Male", "Female"], id: \.self) { gender in
                        Text(gender)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)
                .padding()
                
                // next button
                Button(action: {
                    if (viewModel.potentialUser.name.isEmpty){
                        showError = true
                    }
                    else {
                        navigationPath.append("Bio")
                    }
                    
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.gray.opacity(0.7))
                            .frame(height: 50)
                        
                        Text("Next")
                            .foregroundColor(Color.white)
                            .bold()
                    }
                }
                .padding()
                
                if showError {
                    Text("Enter Full Name")
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack {
                                Image(systemName: "arrow.left.circle.fill")
                                    .foregroundColor(.white)
                                Text("Back")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
        
    }
}

#Preview {
    struct PersonalDetailsPreview: View {
            @State private var navigationPath = NavigationPath()

            var body: some View {
                NavigationStack(path: $navigationPath) {
                    PersonalDetailsView(navigationPath: $navigationPath).environmentObject(AuthViewModel())
                        .navigationDestination(for: String.self) { destination in
                                            switch destination {
                                            case "Bio":
                                                BioView(navigationPath: $navigationPath)
                                            default:
                                                EmptyView()
                                            }
                                        }
                }
            }
        
        }
    
    return PersonalDetailsPreview()
}
