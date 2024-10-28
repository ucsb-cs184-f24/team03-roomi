//
//  SignUpButtonView.swift
//  Roomi
//
//  Created by Anderson Lee on 10/19/24.
//

import SwiftUI

//struct ButtonView: View {
//    let title: String
//    let email: String
//    let password: String
//    @EnvironmentObject var viewModel: AuthViewModel
//    
//    var body: some View {
//        Button(title) {
//            Task {
//                do {
//                    if title == "Sign Up" {
//                        try await viewModel.signUp(withEmail: email, password: password)
//                    }
//                    else if title == "Sign In" {
//                        try await viewModel.login(withEmail: email, password: password)
//                    }
//                }
//            }
//        }
//            .frame(maxWidth: .infinity)
//            .frame(height: 55)
//            .background(Color.blue)
//            .foregroundStyle(.white)
//            .cornerRadius(10)
//    }
//}
//
//#Preview {
//    ButtonView(title: "", email: "", password: "")
//        .environmentObject(AuthViewModel())
//}


struct ButtonView: View {
    let title: String
    let background: Color
    let action: () -> Void
    
    var body: some View {
        Button{
            // Button Action
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(background)
                
                Text(title)
                    .foregroundColor(Color.white)
                    .bold()
            }
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(title: "Value",
                 background: .blue){
            //Action
        }
    }
}
