import SwiftUI

struct ProfileDetailView: View {
    let userInformation: User
    @Environment(\.presentationMode) var presentationMode
    @State private var profileImage: UIImage? = nil
    @State private var isLoadingImage: Bool = true

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: 0x4A90E2), Color(hex: 0x9013FE)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 25) {
                Spacer().frame(height: 80)
                
                // Profile Picture
                if let image = profileImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                } else if isLoadingImage {
                    ProgressView() // Loading spinner
                        .frame(width: 150, height: 150)
                } else {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                }
                
                Text(userInformation.name)
                    .font(.largeTitle).bold()
                    .foregroundColor(.white)
                
                HStack(spacing: 20) {
                    GenderBubble(gender: userInformation.gender)
                    AgeBubble(age: userInformation.age)
                }
                
                Spacer()
            }
            .padding()
            
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.title)
                    }
                    .padding(.leading, 16)
                    
                    Spacer()
                    
                    Text(userInformation.name)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Spacer().frame(width: 44)
                }
                .padding(.horizontal)
                .frame(height: 60)
                .background(Color.clear)
                .overlay(
                    Divider()
                        .background(Color.white.opacity(0.3)),
                    alignment: .bottom
                )
                
                Spacer()
            }
        }
        .onAppear {
            fetchProfileImage()
        }
        .navigationBarHidden(true)
    }
}

struct GenderBubble: View {
    let gender: String
    
    var body: some View {
        VStack {
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
            Text(gender)
                .font(.headline)
                .foregroundColor(.white)
        }
        .padding()
        .frame(width: 100)
        .background(Color.white.opacity(0.15))
        .cornerRadius(15)
    }
}

struct AgeBubble: View {
    let age: Int
    
    var body: some View {
        VStack {
            Text("\(age)")
                .font(.largeTitle).bold()
                .foregroundColor(.white)
            Text("years old")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.7))
        }
        .padding()
        .frame(width: 100)
        .background(Color.white.opacity(0.15))
        .cornerRadius(15)
    }
}


private extension ProfileDetailView {
    func fetchProfileImage() {
        guard let imageKey = userInformation.imageKey else {
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
