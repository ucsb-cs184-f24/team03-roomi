//
//  SocialDetailsView.swift
//  Roomi
//
//  Created by Alec Morrison on 11/27/24.
//

import SwiftUI

struct SocialDetailsView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        ZStack{
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: 0x4A90E2), Color(hex: 0x9013FE)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack{
                Text("Your Preferences...")
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .font(.title)
                    .padding(.bottom, 50)
                
                
                // gender input
                Text("Social")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                Picker("Select Gender", selection: $viewModel.potentialUser.social) {
                    ForEach(["Introverted", "Both", "Extroverted"], id: \.self) { gender in
                        Text(gender)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)
                .padding()
                
                // drug input
                Text("Alcohol / 420")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                Picker("Select Drugs", selection: $viewModel.potentialUser.drugs) {
                    ForEach(["Neither", "420 Only", "Alc Only", "Both"], id: \.self) { drug in
                        Text(drug)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)
                .padding()
                
                
                // pet input
                Text("Pet Friendly")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                Picker("Select Pets", selection: $viewModel.potentialUser.petFriendly) {
                    Text("Yes").tag(true)
                    Text("No").tag(false)
                }
                .pickerStyle(SegmentedPickerStyle())
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)
                .padding()
                
                
                
                // next button
                Button(action: {
                    navigationPath.append("Photos Upload")
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.gray.opacity(0.7))
                            .frame(height: 50)
                        
                        Text("Next")
                            .foregroundColor(Color.white)
                            .bold()
                    }
                }
                .padding()
            }
            
        }
        
        .navigationBarBackButtonHidden(true)
        .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack {
                                Image(systemName: "arrow.left.circle.fill")
                                    .foregroundColor(.white)
                                Text("Back")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
    }
}

#Preview {
    struct SocialDetailsPreview: View {
            @State private var navigationPath = NavigationPath()

            var body: some View {
                NavigationStack(path: $navigationPath) {
                    SocialDetailsView(navigationPath: $navigationPath).environmentObject(AuthViewModel())
                        .navigationDestination(for: String.self) { destination in
                            switch destination {
                            case "Photos Upload":
                                PhotosUploadView(navigationPath: $navigationPath)
                            default:
                                EmptyView()
                            }
                        }
                }
            }
        }
    
    return SocialDetailsPreview()
}
