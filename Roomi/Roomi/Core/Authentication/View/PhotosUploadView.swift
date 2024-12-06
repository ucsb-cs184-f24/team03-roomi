//
//  PhotosUploadView.swift
//  Roomi
//
//  Created by Alec Morrison on 11/27/24.
//

import SwiftUI

struct PhotosUploadView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var cardsViewModel: CardsViewModel
    @Environment(\.presentationMode) var presentationMode
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        
        ZStack{
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: 0x4A90E2), Color(hex: 0x9013FE)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack{
                Text("Upload Photos Page")
                
                
                ButtonView(title: "Create Profile"){
                    Task {
                        navigationPath = NavigationPath()
                        viewModel.loadingState = true
                        try await viewModel.signUp()
                        cardsViewModel.initialize()
                    }
                }
                .frame(height: 50)
                .padding()
            }
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
    struct PhotosUploadPreview: View {
            @State private var navigationPath = NavigationPath()

            var body: some View {
                NavigationStack(path: $navigationPath) {
                    PhotosUploadView(navigationPath: $navigationPath).environmentObject(AuthViewModel())
                }
            }
        }
    
    return PhotosUploadPreview()
}
