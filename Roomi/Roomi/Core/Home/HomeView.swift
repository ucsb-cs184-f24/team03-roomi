//
//  HomeView.swift
//  Roomi
//
//  Created by Anderson Lee on 10/22/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            Text("Welcome to Roomi!")
            NavigationBarView()
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(AuthViewModel())
}
