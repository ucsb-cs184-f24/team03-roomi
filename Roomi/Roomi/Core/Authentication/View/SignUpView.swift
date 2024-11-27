//
//  SignUpView.swift
//  Roomi
//
//  Created by Anderson Lee on 10/18/24.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var isValidInput: Bool = false
    @State private var navigationPath = NavigationPath() // Use NavigationPath
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                Text("Roomi")
                    .fontWeight(.heavy)
                    .font(.largeTitle)
                
                // display error message
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(Color.red)
                }
                
                // email and password inputs
                InputView(text: $viewModel.potentialUser.email, title: "Email", placeholder: "Enter Your Email")
                
                InputView(text: $viewModel.password, title: "Password", placeholder: "Enter Your Password", isSecureField: true)
                
                // button to validate and move to profile creation
                Button(action: {
                    if viewModel.validate() {
                        navigationPath.append("Phone Number")
                    } else {
                        print("Validation failed")
                    }
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.blue)
                            .frame(height: 50)
                        
                        Text("Sign Up")
                            .foregroundColor(Color.white)
                            .bold()
                    }
                }
                .padding()
                
                
                // button to switch back to login view
                Button (action: {
                    viewModel.loginState.toggle()
                    viewModel.errorMessage = ""
                }) {
                    Text("Already have an account?")
                    Text("Login")
                        .fontWeight(.bold)
                }
                
                Spacer().frame(height:20)
            }
            .navigationDestination(for: String.self) { destination in
                                switch destination {
                                case "Phone Number":
                                    PhoneNumberView(navigationPath: $navigationPath)
                                case "Personal Details":
                                    PersonalDetailsView(navigationPath: $navigationPath)
                                case "Bio":
                                    BioView(navigationPath: $navigationPath)
                                case "Social Details":
                                    SocialDetailsView(navigationPath: $navigationPath)
                                case "Photos Upload":
                                    PhotosUploadView(navigationPath: $navigationPath)
                                default:
                                    EmptyView()
                                }
                            }
            .padding()
        }
    }
}

#Preview {
    SignUpView()
        .environmentObject(AuthViewModel())
}
