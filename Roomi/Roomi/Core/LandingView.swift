//
//  LandingView.swift
//  Roomi
//
//  Created by Benjamin Conte on 10/17/24.
//

import SwiftUI

struct LandingView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        VStack {
            Text("Welcome to Roomi!")
                .font(.title)
                .bold()
            
            Text(viewModel.userSession?.email ?? "No user session")
        }
    }
}

#Preview {
    LandingView()
}
