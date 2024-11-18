//
//  ProfileView.swift
//  Roomi
//
//  Created by Anderson Lee on 10/19/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(hex: 0x4A90E2), Color(hex: 0x9013FE)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
                VStack {
                    if let user = viewModel.currentUser {
                        Circle()
                            .fill(Color.gray) // Set the fill color to grey
                            .frame(width: 150, height: 150) // Set the size of the circle
                        
                        Text(user.name)
                            .font(.largeTitle).bold()
                            .foregroundColor(.white)
                        
                        HStack {
                            GenderBubble(gender: user.gender)
                            AgeBubble(age: user.age)
                        }
                        
                        Spacer()
                        ButtonView(title: "Logout", background: .red) {
                            viewModel.signOut()
                        }
                        .frame(width: 100, height: 40)
                        
                        ButtonView(title: "Delete Account", background: .red) {
                            viewModel.signOut()
                        }
                        .frame(width: 200, height: 40)
                    }
                }
                .padding()
                .frame(maxHeight: .infinity, alignment: .top)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ProfileCreationView()) {
                        Text("Edit")
                            .foregroundStyle(.white)
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthViewModel())
}
