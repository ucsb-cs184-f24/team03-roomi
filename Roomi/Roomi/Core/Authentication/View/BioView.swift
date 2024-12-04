//
//  BioView.swift
//  Roomi
//
//  Created by Alec Morrison on 11/26/24.
//

import SwiftUI

struct BioView: View {
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
            
            VStack{
                Text("Lets Get to Know You...")
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .font(.title)
                    .padding(.bottom, 50)
                
                
                
                //TODO - edit view model User Model to have the new fields
                
                // name input
                Image(systemName: "briefcase.fill")
                    //.font(.subheadline)
                    .foregroundColor(.white)
                    .padding()
                
                TextField("School/Work", text: $viewModel.potentialUser.schoolWork)
                    .padding()
                    .frame(height: 55)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                    .onChange(of: viewModel.potentialUser.schoolWork) {
                        showError = false
                    }
                
                // bio input
                Text("Tell Us About Yourself...")
                    //.font(.headline)
                    .foregroundColor(.white)
                    .padding()
                
                TextEditor(text: $viewModel.potentialUser.bio)
                    .padding()
                    .frame(height: 200)
                    .opacity(0.8)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                    .onChange(of: viewModel.potentialUser.bio) {
                        showError = false
                    }
                
                
                // next button
                Button(action: {
                    if (viewModel.potentialUser.schoolWork.isEmpty || viewModel.potentialUser.bio.isEmpty) {
                        showError = true
                    }
                    else {
                        navigationPath.append("Social Details")
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
                    Text("Fill All Fields")
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
    struct BioPreview: View {
            @State private var navigationPath = NavigationPath()

            var body: some View {
                NavigationStack(path: $navigationPath) {
                    BioView(navigationPath: $navigationPath).environmentObject(AuthViewModel())
                    .navigationDestination(for: String.self) { destination in
                        switch destination {
                        case "Social Details":
                            SocialDetailsView(navigationPath: $navigationPath)
                        default:
                            EmptyView()
                        }
                    }
                }
            }
        }
    
    return BioPreview()
}
