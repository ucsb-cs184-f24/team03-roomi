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
            
            ZStack {
                
                LinearGradient(
                    gradient: Gradient(colors: [Color(hex: 0x4A90E2), Color(hex: 0x9013FE)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack {
                    Text("New Here?")
                        .foregroundColor(Color(.white))
                        .fontWeight(.heavy)
                        .font(.largeTitle)
                        .padding(.bottom, 100)
                    Text("Sign Up")
                        .foregroundColor(Color(.white))
                        .fontWeight(.heavy)
                    
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
                                .foregroundColor(Color.blue.opacity(0.7))
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
                            .foregroundColor(Color(.white))
                        Text("Login")
                            .foregroundColor(Color(.white))
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
                
                
                
                if viewModel.loadingState {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        ProgressView("Creating Profile...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                }
                
            }
        }
    }
}

#Preview {
    SignUpView()
        .environmentObject(AuthViewModel())
}
