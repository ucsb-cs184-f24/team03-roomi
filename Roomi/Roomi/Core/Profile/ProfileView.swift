import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var profileImage: UIImage? = nil
    @State private var isLoadingImage: Bool = true

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
                            if isLoadingImage {
                                ProgressView() // Show loading spinner
                                    .frame(width: 150, height: 150)
                            } else if let image = profileImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 150)
                                    .clipShape(Circle())
                                    .shadow(radius: 10)
                            } else {
                                Circle()
                                    .fill(Color.gray)
                                    .frame(width: 150, height: 150)
                            }

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
                                if let schoolWork = user.schoolWork, !schoolWork.isEmpty {
                                    LocationBubble(location: schoolWork)
                                }
                                if let bio = user.bio, !bio.isEmpty {
                                    ProfileInfoBubble(title: "Bio", text: bio)
                                }
                                if let social = user.social, !social.isEmpty {
                                    ProfileInfoBubble(title: "Social", text: social)
                                }
                                ProfileInfoBubble(title: "Alcohol/420", text: user.drugs)
                                ProfileInfoBubble(title: "Pet Friendly", text: (user.petFriendly) ? "Yes" : "No")
                            }

                            // Logout Button
                            ButtonView(title: "Logout", background: .red) {
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
        .onAppear {
            fetchImage()
        }
    }

    /// Fetch the Base64 image string from Redis, decode it, and display it
    private func fetchImage() {
        guard let user = viewModel.currentUser, let imageKey = user.imageKey else {
            print("User or image key is missing.")
            self.isLoadingImage = false
            return
        }

        RedisManager.shared.fetchBase64Image(for: imageKey) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let base64String):
                    if let base64String = base64String,
                       let imageData = Data(base64Encoded: base64String),
                       let image = UIImage(data: imageData) {
                        self.profileImage = image
                    } else {
                        print("Failed to decode image data for key: \(imageKey)")
                    }
                    self.isLoadingImage = false
                case .failure(let error):
                    print("Error fetching image: \(error)")
                    self.isLoadingImage = false
                }
            }
        }
    }
}
