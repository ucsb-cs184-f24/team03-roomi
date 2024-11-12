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
        VStack {
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
    }
}

#Preview {
    CardStackView()
        .environmentObject(CardsViewModel(service: CardService()))
}
