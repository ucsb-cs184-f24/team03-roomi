//
//  CardView.swift
//  Roomi
//
//  Created by Alec Morrison on 11/7/24.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var viewModel: CardsViewModel
    @State private var xOffset: CGFloat = 0
    @State private var degrees: Double = 0
    @State private var isExpanded: Bool = false
    @State private var profileImage: UIImage? = nil
    @State private var isLoadingImage: Bool = true

    let model: CardModel

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: 0x4A90E2), Color(hex: 0x9013FE)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .clipShape(RoundedRectangle(cornerRadius: 15))

            VStack(spacing: 20) {
                Spacer()
                
                
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
                    

                Text(model.user.name)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)

                HStack(spacing: 20) {
                    GenderBubble(gender: model.user.gender)
                    AgeBubble(age: model.user.age)
                }
                
                if isExpanded {
                    VStack(spacing: 12) {
                        LocationBubble(location: model.user.schoolWork)
                        ProfileInfoBubble(title: "Bio", text: model.user.bio)
                        ProfileInfoBubble(title: "Social", text: model.user.social)
                        HStack(spacing: 20){
                            ProfileInfoBubble(title: "Alcohol/420", text: model.user.drugs)
                            ProfileInfoBubble(title: "Pet Friendly", text: model.user.petFriendly ? "Yes" : "No")
                        }
                    }
                    .transition(.slide)
                }

                Spacer()
            }
            .padding(.horizontal, 20)
            
        }
        .frame(
            width: isExpanded ? SizeConstants.cardWidth * 1.2 : SizeConstants.cardWidth,
            height: isExpanded ? UIScreen.main.bounds.height * 1.1: SizeConstants.cardHeight
        )
        .offset(y: isExpanded ? 50 : 0)
        .padding(.horizontal, isExpanded ? 0 : 20)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 2)
        .offset(x: xOffset)
        .rotationEffect(.degrees(degrees))
        .animation(.easeInOut, value: isExpanded)
        .gesture(
            DragGesture()
                .onChanged(onDragChanged)
                .onEnded(onDragEnded)
        )
        .onTapGesture {
            isExpanded.toggle()
        }
        .onReceive(viewModel.$buttonSwipeAction, perform: { action in
            onRecieveSwipeAction(action)
        })
        .onAppear {
            fetchProfileImage()
        }
    }
}

private extension CardView {
    func fetchProfileImage() {
        guard let imageKey = model.user.imageKey else {
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




#Preview {
    ZStack {
        Color.gray
        CardView(model: CardModel(user: MockData.users[1]))
            .environmentObject(CardsViewModel())
    }
}




private extension CardView {
    func returnToCenter() {
        xOffset = 0
        degrees = 0
    }
    
    func swipeRight() {
        withAnimation {
            xOffset = 500
            degrees = 12
        } completion: {
            viewModel.removeCard(model)
            Task {
                try await viewModel.like(otherUser: model.user)
            }
        }
    }
    
    func swipeLeft() {
        withAnimation{
            xOffset = -500
            degrees = -12
        } completion: {
            viewModel.removeCard(model)
            Task {
                try await viewModel.dislike(otherUser: model.user)
            }
        }
    }
    
    func onRecieveSwipeAction(_ action: SwipeAction?) {
        guard let action else { return }
        
        let topCard = viewModel.cardModels.last
        
        if topCard == model {
            switch action {
            case .reject:
                swipeLeft()
            case .like:
                swipeRight()
            }
        }
    }
}

private extension CardView {
    func onDragChanged(_ value: _ChangedGesture<DragGesture>.Value) {
        xOffset = value.translation.width
        degrees = Double(value.translation.width/50)
    }
    
    func onDragEnded(_ value: _ChangedGesture<DragGesture>.Value) {
        let width = value.translation.width
        if abs(width) <= abs(SizeConstants.screenCutoff) {
            returnToCenter()
            return
        }
        
        if width >= SizeConstants.screenCutoff {
            swipeRight()
        } else {
            swipeLeft()
        }
        
    }
}


#Preview {
    
    ZStack{
        Color.gray
        CardView(model: CardModel(user: MockData.users[1]))
            .environmentObject(CardsViewModel())
    }
}
