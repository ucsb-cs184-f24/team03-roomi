import SwiftUI

struct MatchesView: View {
    @State private var selectedTab: MatchTab = .matches

    enum MatchTab: String, CaseIterable {
        case matches = "Matches"
        case likes = "Likes"
    }

    let matchedProfiles = [
        Profile(name: "Alex", age: 26, gender: "Male", location: "San Francisco, CA", image: "person.fill", bio: "Loves hiking and outdoor adventures."),
        Profile(name: "Jordan", age: 29, gender: "Female", location: "Los Angeles, CA", image: "person.fill", bio: "Tech enthusiast and coffee lover."),
        Profile(name: "Taylor", age: 24, gender: "Female", location: "New York, NY", image: "person.fill", bio: "Aspiring artist and foodie.")
    ]

    let likedProfiles = [
        Profile(name: "Chris", age: 27, gender: "Male", location: "Austin, TX", image: "person.fill", bio: "Musician and part-time chef."),
        Profile(name: "Morgan", age: 30, gender: "Female", location: "Seattle, WA", image: "person.fill", bio: "Entrepreneur with a passion for travel.")
    ]

    var displayedProfiles: [Profile] {
        switch selectedTab {
        case .matches:
            return matchedProfiles
        case .likes:
            return likedProfiles
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                MatchTabPicker(selectedTab: $selectedTab)

                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(displayedProfiles) { profile in
                            NavigationLink(destination: ProfileDetailView(profile: profile)) {
                                ProfileCardView(profile: profile)
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
}
