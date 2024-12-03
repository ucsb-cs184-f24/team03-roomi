import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var profileImage: UIImage? = nil
    @State private var isLoadingImage: Bool = true

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
                        if isLoadingImage {
                            ProgressView() // Show loading spinner
                        } else if let image = profileImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
                        } else {
                            Circle()
                                .fill(Color.gray)
                                .frame(width: 150, height: 150)
                        }

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
                    }
                }
                .padding()
                .frame(maxHeight: .infinity, alignment: .top)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: UpdateProfileView(user: viewModel.currentUser)) {
                        Text("Edit")
                            .foregroundStyle(.white)
                    }
                }
            }
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
