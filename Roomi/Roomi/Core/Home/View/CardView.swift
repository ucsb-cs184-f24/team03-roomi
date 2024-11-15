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
    
    let model: CardModel

    var body: some View {
        ZStack {
            ZStack(alignment: .top){
                
                Rectangle()
                    .fill(.white)
//                    .fill(LinearGradient(
//                        gradient: Gradient(colors: [Color(hex: 0x4A90E2), Color(hex: 0x9013FE)]),
//                        startPoint: .top,
//                        endPoint: .bottom
//                    ))
                
                 //TODO - make the info in here a scrollview
                
                VStack {
                    Text(model.user.name)
                    Text(model.user.email)
                    Text("\(model.user.age)")
                    Text(model.user.gender)
                    Text(model.user.phoneNumber)
                }
                
                SwipeActionIndicatorView(xOffset: $xOffset)
            }
        }
        .onReceive(viewModel.$buttonSwipeAction, perform: { action in
            onRecieveSwipeAction(action)
        })
        .frame(width: SizeConstants.cardWidth, height: SizeConstants.cardHeight)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .offset(x: xOffset)
        .rotationEffect(.degrees(degrees))
        .animation(.snappy, value: xOffset)
        .gesture(
            DragGesture()
                .onChanged(onDragChanged)
                .onEnded(onDragEnded)
        )
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
