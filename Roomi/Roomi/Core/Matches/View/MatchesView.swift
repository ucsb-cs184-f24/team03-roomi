import SwiftUI

struct MatchesView: View {
    @EnvironmentObject var cardsViewModel: CardsViewModel
    @State private var selectedTab: MatchTab = .matches
    
    enum MatchTab: String, CaseIterable {
        case matches = "Matches"
        case likes = "Likes"
    }
    
    var displayedProfiles: [User] {
        switch selectedTab {
        case .matches:
            return cardsViewModel.matchList
        case .likes:
            return cardsViewModel.likedList
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                MatchTabPicker(selectedTab: $selectedTab)
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(displayedProfiles) { user in
                            NavigationLink(destination: ProfileDetailView(userInformation: user, onMatchedList: selectedTab == .matches)) {
                                ProfileCardView(userInformation: user)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color(hex: 0x4A90E2), Color(hex: 0x9013FE)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
            )
            .navigationBarTitleDisplayMode(.inline)
        }.onAppear {
            Task {
                try await cardsViewModel.getAllMatches()
                try await cardsViewModel.getAllLikes()
            }
        }
        .refreshable {
            Task {
                try await cardsViewModel.getAllMatches()
                try await cardsViewModel.getAllLikes()
            }
        }
        
    }
}

struct MatchTabPicker: View {
    @Binding var selectedTab: MatchesView.MatchTab
    
    var body: some View {
        Picker("", selection: $selectedTab) {
            ForEach(MatchesView.MatchTab.allCases, id: \.self) { tab in
                Text(tab.rawValue)
                    .tag(tab)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
}

#Preview {
    MatchesView()
        .environmentObject(CardsViewModel())
}
