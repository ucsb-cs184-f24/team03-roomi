import SwiftUI

struct SwipeActionButtonsView: View {
    @EnvironmentObject var viewModel: CardsViewModel
    
    var body: some View {
        HStack(spacing: UIScreen.main.bounds.width - 150) {
            Button {
                viewModel.buttonSwipeAction = .reject
            } label: {
                Image(systemName: "xmark")
                    .foregroundStyle(.white)
                    .background {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 48, height: 48)
                            .shadow(radius: 6)
                    }
            }
            .frame(width: 48, height: 48)
            
            Button {
                viewModel.buttonSwipeAction = .like
            } label: {
                Image(systemName: "checkmark")
                    .foregroundStyle(.white)
                    .background {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 48, height: 48)
                            .shadow(radius: 6)
                    }
            }
            .frame(width: 48, height: 48)
        }
    }
}

#Preview {
    SwipeActionButtonsView()
        .environmentObject(CardsViewModel())
}
