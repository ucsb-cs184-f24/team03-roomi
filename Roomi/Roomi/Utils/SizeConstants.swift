//
//  SizeConstants.swift
//  Roomi
//
//  Created by Alec Morrison on 11/8/24.
//

import SwiftUI

struct SizeConstants {
    static var screenCutoff: CGFloat {
        (UIScreen.main.bounds.width / 2) * 1
    }
    
    static var cardWidth: CGFloat {
        UIScreen.main.bounds.width - 20
    }
    
    static var cardHeight: CGFloat {
        UIScreen.main.bounds.height / 1.45
    }
}
