//
//  PhoneNumberView.swift
//  Roomi
//
//  Created by Alec Morrison on 11/22/24.
//

import SwiftUI

struct PhoneNumberView: View {
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
                Text("First, Your Phone Number")
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .font(.title)
                    .padding(.bottom, 100)
                
                
                // phone number input
                HStack {
                    Text("+1 🇺🇸").foregroundColor(.white)
                    
                    ZStack(alignment: .leading) {
                        if viewModel.potentialUser.phoneNumber.isEmpty {
                            Text("Phone Number")
                                .foregroundColor(.white)
                                .opacity(0.5)
                                .padding(.leading, 15)
                        }
                        
                        TextField("", text: $viewModel.potentialUser.phoneNumber)
                        .foregroundStyle(.white)
                        .onChange(of: viewModel.potentialUser.phoneNumber) {
                            showError = false
                            if !viewModel.potentialUser.phoneNumber.isEmpty {
                                viewModel.potentialUser.phoneNumber = viewModel.potentialUser.phoneNumber.formatPhoneNumber()
                            }
                        }
                        .overlay(
                            Rectangle()
                                .frame(height: 1) // Height of the underline
                                .foregroundStyle(.white), // Color of the underline
                            alignment: .bottom // Ensure it aligns below the text
                        )
                        .padding()
                        
                    }
                }
                .padding()
                
                
                
                Button(action: {
                    if (viewModel.potentialUser.phoneNumber.filter {$0.isNumber}.count != 10){
                        showError = true
                    }
                    else {
                        navigationPath.append("Personal Details")
                    }
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.blue.opacity(0.7))
                            .frame(height: 50)
                        
                        Text("Next")
                            .foregroundColor(Color.white)
                            .bold()
                    }
                }
                .padding()
                
                
                if showError {
                    Text("Enter a Valid Phone Number")
                        .foregroundColor(.red)
                        .font(.caption)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.top, 100)
            
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
                    // cancel button
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            viewModel.clearPotentialUser()
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack {
                                Image(systemName: "arrow.left.circle.fill")
                                    .foregroundColor(.white)
                                Text("Cancel")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
        
    }
        
}


extension String {
    func formatPhoneNumber() -> String {
        let cleanNumber = components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        let mask = "(XXX) XXX-XXXX"
        
        var result = ""
        var startIndex = cleanNumber.startIndex
        let endIndex = cleanNumber.endIndex
        
        for char in mask where startIndex < endIndex {
            if char == "X" {
                result.append(cleanNumber[startIndex])
                startIndex = cleanNumber.index(after: startIndex)
            } else {
                result.append(char)
            }
        }
        
        return result
    }
}

#Preview {
    struct PhoneNumberPreview: View {
            @State private var navigationPath = NavigationPath()

            var body: some View {
                NavigationStack(path: $navigationPath) {
                    PhoneNumberView(navigationPath: $navigationPath).environmentObject(AuthViewModel())
                        .navigationDestination(for: String.self) { destination in
                                            switch destination {
                                            case "Personal Details":
                                                PersonalDetailsView(navigationPath: $navigationPath)
                                            default:
                                                EmptyView()
                                            }
                                        }
                }
            }
        }
    
    return PhoneNumberPreview()
}
