import SwiftUI

struct ProfileDetailView: View {
    let userInformation: User
    let onMatchedList: Bool
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var cardsViewModel: CardsViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: 0x4A90E2), Color(hex: 0x9013FE)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 25) {
                Spacer().frame(height: 80)
                
                Text(userInformation.name)
                    .font(.largeTitle).bold()
                    .foregroundColor(.white)
                
                HStack(spacing: 20) {
                    GenderBubble(gender: userInformation.gender)
                    AgeBubble(age: userInformation.age)
                }
                
                Spacer()
                
                if onMatchedList {
                    VStack(spacing: 20) {
                        NavigationLink(
                            destination: ChatView(
                                viewModel: MessagingViewModel(recipientId: userInformation.id),
                                recipientName: userInformation.name
                            )
                        ) {
                            Text("Message \(userInformation.name)")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue.opacity(0.7))
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                        .padding(.horizontal)
                        
                        ButtonView(title: "Block", background: .red) {
                            Task {
                                try await cardsViewModel.block(otherUser: userInformation)
                            }
                        }
                        .frame(height: 50)
                        .padding(.horizontal)
                    }
                }
            }
            .padding()
            
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.title)
                    }
                    .padding(.leading, 16)
                    
                    Spacer()
                    
                    Text("Matched!")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Spacer().frame(width: 44)
                }
                .padding(.horizontal)
                .frame(height: 60)
                .background(Color.clear)
                .overlay(
                    Divider()
                        .background(Color.white.opacity(0.3)),
                    alignment: .bottom
                )
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}

struct GenderBubble: View {
    let gender: String
    
    var body: some View {
        VStack {
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
            Text(gender)
                .font(.headline)
                .foregroundColor(.white)
        }
        .padding()
        .frame(width: 100)
        .background(Color.white.opacity(0.15))
        .cornerRadius(15)
    }
}

struct AgeBubble: View {
    let age: Int
    
    var body: some View {
        VStack {
            Text("\(age)")
                .font(.largeTitle).bold()
                .foregroundColor(.white)
            Text("years old")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.7))
        }
        .padding()
        .frame(width: 100)
        .background(Color.white.opacity(0.15))
        .cornerRadius(15)
    }
}

struct LocationBubble: View {
    let location: String
    
    var body: some View {
        HStack {
            Image(systemName: "mappin.and.ellipse")
                .foregroundColor(.white)
                .padding(.trailing, 5)
            
            Text(location)
                .font(.body)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(15)
        .padding(.horizontal, 16)
    }
}

struct ProfileInfoBubble: View {
    let title: String
    let text: String
    
    var body: some View {
        VStack(spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white.opacity(0.9))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
            Text(text)
                .font(.body)
                .foregroundColor(.white)
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(15)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}


#Preview {
    ProfileDetailView(userInformation: User(id: "1", email: "alex@example.com", name: "Alex", age: 26, gender: "Male", phoneNumber: "+1 212 555 1212", schoolWork: "", bio: "", social: "", drugs: "", petFriendly: true), onMatchedList: true)
}

