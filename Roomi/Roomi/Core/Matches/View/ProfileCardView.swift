//
//  ProfileCardView.swift
//  Roomi
//
//  Created by Khang Chung on 10/31/24.
//

import SwiftUI

struct ProfileCardView: View {
    let userInformation: User
    @State private var profileImage: UIImage? = nil
    @State private var isLoadingImage: Bool = true
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.15))
                .frame(height: 200)
                .overlay(
                    VStack {
                        // Display profile image or stock image
                        if let image = profileImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                                .clipShape(Circle())
                                .shadow(radius: 10)
                        } else if isLoadingImage {
                            ProgressView() // Show loading spinner
                                .frame(height: 100)
                        } else {
                            Image(systemName: "person.crop.circle") // Fallback stock image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                                .clipShape(Circle())
                                .shadow(radius: 10)
                        }
                        Text(userInformation.name)
                            .font(.title2).bold()
                            .foregroundColor(.white)
                        
                        Text("\(userInformation.age) years old")
                            .foregroundColor(.white.opacity(0.7))
                            .padding(.bottom, 10)
                    }
                )
                .shadow(radius: 10)
                .padding(.horizontal)
        }
        .onAppear {
            fetchProfileImage()
        }
    }
}
        
private extension ProfileCardView {
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

struct ProfileImageView: View {
    let image: String
    var size: CGFloat = 80
    
    var body: some View {
        Image(systemName: image)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .padding()
            .background(Color.white.opacity(0.15))
            .clipShape(Circle())
            .shadow(radius: 10)
    }
}
