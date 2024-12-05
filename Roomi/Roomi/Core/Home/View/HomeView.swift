import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var selectedTab: Int = 1
    @State private var showTabBar: Bool = false
    
    let tabs = [
        (title: "Matches", image: "person.fill"),
        (title: "Home", image: "house.fill"),
        (title: "Profile", image: "gearshape.fill"),
        (title: "", image: "message.fill")
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: backgroundColors(for: selectedTab)),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                if selectedTab == 0 {
                    MatchesView()
                } else if selectedTab == 1 {
                    CardStackView()
                } else if selectedTab == 2 {
                    ProfileView()
                } else if selectedTab == 3 {
                    NavigationView
                    {
                        ChatListView()
                    }
                }
                
                Spacer()
                
                VStack(spacing: 0) {
                    
                    HStack {
                        ForEach(0..<tabs.count, id: \.self) { index in
                            Spacer()
                            
                            Button(action: {
                                withAnimation {
                                    selectedTab = index
                                }
                            }) {
                                VStack {
                                    Image(systemName: tabs[index].image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: selectedTab == index ? 30 : 24, height: selectedTab == index ? 30 : 24)
                                        .foregroundColor(.white)
                                        .scaleEffect(selectedTab == index ? 1.1 : 1.0)
                                        .animation(.spring(), value: selectedTab == index)
                                    
                                    Text(tabs[index].title)
                                        .font(.caption2)
                                        .foregroundColor(.white)
                                }
                            }
                            .frame(maxWidth: selectedTab == index ? 80 : 50)
                            .animation(.easeInOut, value: selectedTab == index)
                            
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.bottom, 5)
                }
                .background(Color.clear)
                .transition(.opacity)
                .frame(height: 60)
            }
        }
    }
    
    func backgroundColors(for tab: Int) -> [Color] {
        return [Color.blue, Color.purple]
    }
}

extension Color {
    init(hex: UInt) {
        self.init(
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255
        )
    }
}

#Preview {
    HomeView()
        .environmentObject(AuthViewModel())
        .environmentObject(CardsViewModel())
}
