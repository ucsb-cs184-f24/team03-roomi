import SwiftUI

@MainActor
struct MatchesView: View {
    @State private var selectedTab: MatchTab = .matches
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var searchViewModel: SearchViewModel


    enum MatchTab: String, CaseIterable {
        case matches = "Matches"
        case likes = "Likes"
    }

    var displayedProfiles: [User] {
        switch selectedTab {
        case .matches:
            return searchViewModel.matchList
        case .likes:
            return searchViewModel.likedList
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                MatchTabPicker(selectedTab: $selectedTab)

                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(displayedProfiles) { user in
                            NavigationLink(destination: ProfileDetailView(userInformation: user)) {
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
        }
        .onAppear {
            Task {
                await searchViewModel.getAllMatches()
                await searchViewModel.getAllLikes()
            }
        }
        .refreshable {
            Task {
                await searchViewModel.getAllMatches()
                await searchViewModel.getAllLikes()
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
        .environmentObject(AuthViewModel())
        .environmentObject(SearchViewModel())
}
