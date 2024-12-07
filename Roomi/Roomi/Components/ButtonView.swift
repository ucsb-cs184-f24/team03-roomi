//
//  SignUpButtonView.swift
//  Roomi
//
//  Created by Anderson Lee on 10/19/24.
//

import SwiftUI

struct ButtonView: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button{
            // Button Action
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.gray.opacity(0.7))
                
                Text(title)
                    .foregroundColor(Color.white)
                    .bold()
            }
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(title: "Value"
                 ){
            //Action
        }
    }
}
