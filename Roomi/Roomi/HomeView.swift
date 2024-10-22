import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel

    var body: some View {
        TabView {
            VStack {
                Text("Welcome to Roomi!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 40)

                if let email = viewModel.user?.email {
                    Text("Signed in as \(email)")
                        .font(.headline)
                        .padding(.top, 10)
                }

                Spacer()
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .background(Color(.systemGray6).edgesIgnoringSafeArea(.top))

            VStack {
                Text("Your Profile")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 40)

                Text("Profile details go here.")
                    .padding()

                Spacer()
            }
            .tabItem {
                Label("Profile", systemImage: "person.fill")
            }
            .background(Color(.systemGray6).edgesIgnoringSafeArea(.top))

            // Settings Tab with Sign Out Button
            VStack {
                Text("Settings")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 40)

                Text("Settings options go here.")
                    .padding()

                Spacer()

                Button(action: {
                    viewModel.signOut()
                }) {
                    Text("Sign Out")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                .frame(height: 55)
                .padding(.bottom, 40)
            }
            .tabItem {
                Label("Settings", systemImage: "gearshape.fill")
            }
            .background(Color(.systemGray6).edgesIgnoringSafeArea(.top))
        }
        .accentColor(.blue)
    }
}

#Preview {
    HomeView()
        .environmentObject(AuthenticationViewModel())
}
