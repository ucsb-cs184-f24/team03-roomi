//
//  SearchView.swift
//  Roomi
//
//  Created by Benjamin Conte on 10/26/24.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var model = SearchViewModel()
    var body: some View {
        NavigationView {
            List (model.profileList) { profile in
                ProfileCard(profileInformation: profile)
            }
        }
    }
    
    init() {
        model.getProfiles()
    }
}

#Preview {
    SearchView()
}
