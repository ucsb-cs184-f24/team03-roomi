//
//  CardStackView.swift
//  Roomi
//
//  Created by Alec Morrison on 11/8/24.
//

import SwiftUI

struct CardStackView: View {
    @EnvironmentObject var viewModel: CardsViewModel
    
    var body: some View {
        VStack (spacing: 20){
            ZStack{
                ForEach(viewModel.cardModels){ card in
                    CardView(model: card)
                }
            }
            
            if !viewModel.cardModels.isEmpty {
                SwipeActionButtonsView()
            }
        }
        .padding(.top, 20)
        .alert("🎉 It's a Match!", isPresented: $viewModel.isMatch) {
            Button("OK", role: .cancel) {
                viewModel.isMatch = false
            }
        } message: {
            Text(viewModel.matchMessage)
        }
    }
}

#Preview {
    CardStackView()
        .environmentObject(CardsViewModel())
}
