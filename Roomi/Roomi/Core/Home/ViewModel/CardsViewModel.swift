//
//  CardsViewModel.swift
//  Roomi
//
//  Created by Alec Morrison on 11/8/24.
//

import Foundation

@MainActor
class CardsViewModel: ObservableObject {
    @Published var cardModels = [CardModel]()
    @Published var buttonSwipeAction: SwipeAction?
    
    private let service: CardService
    
    init(service: CardService){
        self.service = service
        Task { await fetchCardModels() }
    }
    
    
    func fetchCardModels() async {
        do {
            self.cardModels = try await service.fetchCardModels()
        } catch {
            print("DEBUG: Failed to fetch cards with error: \(error)")
        }
        
    }
    
    
    func removeCard(_ card: CardModel) {
        guard let index = cardModels.firstIndex(where: { $0.id == card.id }) else {return}
        cardModels.remove(at: index)
        buttonSwipeAction = nil
    }
}