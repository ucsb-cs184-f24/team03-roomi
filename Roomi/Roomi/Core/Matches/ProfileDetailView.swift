import SwiftUI

struct ProfileDetailView: View {
    let profile: Profile
    @Environment(\.presentationMode) var presentationMode
    
    var compatibilityScore: Int {
        calculateCompatibilityScore()
    }

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: 0x4A90E2), Color(hex: 0x9013FE)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 25) {
                    Spacer().frame(height: 80)
                    
                    ProfileImageView(image: profile.image, size: 120)
                    
                    Text(profile.name)
                        .font(.largeTitle).bold()
                        .foregroundColor(.white)
                    
                    HStack(spacing: 20) {
                        GenderBubble(gender: profile.gender)
                        AgeBubble(age: profile.age)
                    }
                    
                    LocationBubble(location: profile.location)
                    
                    ProfileInfoBubble(title: "About Me", text: profile.bio)
                    
                    CompatibilityScoreBubble(score: compatibilityScore)
                    
                    Spacer()
                }
                .padding()
            }
            
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
                    
                    Text(profile.name)
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
    
    func calculateCompatibilityScore() -> Int {
        var score = 0
        
        if profile.location == "San Francisco, CA" || profile.location == "Los Angeles, CA" {
            score += 30
        }
        if profile.age >= 25 && profile.age <= 30 || profile.gender == "Female" {
            score += 20
        }
        if profile.bio.contains("hiking") || profile.bio.contains("outdoor") {
            score += 10
        }
        
        return min(score, 100)
    }
}

struct CompatibilityScoreBubble: View {
    let score: Int
    
    var body: some View {
        VStack {
            Text("Compatibility Score")
                .font(.headline)
                .foregroundColor(.white.opacity(0.9))
            Text("\(score)%")
                .font(.largeTitle).bold()
                .foregroundColor(score >= 50 ? .green : .red)
        }
        .padding()
        .background(Color.white.opacity(0.15))
        .cornerRadius(15)
    }
}

struct GenderBubble: View {
    let gender: String

    var body: some View {
        VStack {
            Image(systemName: gender == "Male" ? "person.fill" : "person.fill.badge.plus")
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
