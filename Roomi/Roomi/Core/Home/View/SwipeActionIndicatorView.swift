//
//  SwipeActionIndicatorView.swift
//  Roomi
//
//  Created by Alec Morrison on 11/8/24.
//

import SwiftUI

struct SwipeActionIndicatorView: View {
    @Binding var xOffset: CGFloat
    
    var body: some View {
        HStack{
            Image(systemName: "checkmark.bubble")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.green)
                .opacity(xOffset / SizeConstants.screenCutoff)
            
            Spacer()
            
            Image(systemName: "xmark.app")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.red)
                .opacity(Double(xOffset / SizeConstants.screenCutoff) * -1)
        }
        .padding(40)
    }
}

#Preview {
    SwipeActionIndicatorView(xOffset: .constant(20))
}
