import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        NavigationView {
            ZStack {
                // Gradient Background
                LinearGradient(
                    gradient: Gradient(colors: [Color(hex: 0x4A90E2), Color(hex: 0x9013FE)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea() // Ensure gradient fills the entire screen
                
                ScrollView {
                    VStack(spacing: 16) {
                        if let user = viewModel.currentUser {
                            // Profile Picture
                            Circle()
                                .fill(Color.gray)
                                .frame(width: 150, height: 150)

                            // User Name
                            Text(user.name)
                                .font(.largeTitle).bold()
                                .foregroundColor(.white)

                            // Gender and Age
                            HStack {
                                GenderBubble(gender: user.gender)
                                AgeBubble(age: user.age)
                            }

                            // Additional Profile Info
                            VStack(spacing: 12) {
                                LocationBubble(location: user.schoolWork)
                                ProfileInfoBubble(title: "Bio", text: user.bio)
                                ProfileInfoBubble(title: "Social", text: user.social)
                                ProfileInfoBubble(title: "Alcohol/420", text: user.drugs)
                                ProfileInfoBubble(title: "Pet Friendly", text: (user.petFriendly) ? "Yes" : "No")
                            }

                            // Logout Button
                            ButtonView(title: "Logout") {
                                viewModel.signOut()
                            }
                            .frame(width: 100, height: 40)
                            .padding(.top, 20)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .top) // Align content to top
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: UpdateProfileView(user: viewModel.currentUser)) {
                        Text("Edit")
                            .foregroundColor(.white) // Ensure the text matches the theme
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline) // Use inline title for compact bar
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthViewModel())
}
