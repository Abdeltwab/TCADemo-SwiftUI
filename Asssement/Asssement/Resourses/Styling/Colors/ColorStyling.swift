//
//  ColorStyling.swift
//  Asssement
//
//  Created by Abdeltawab Mohamed on 18/09/2022.
//

import SwiftUI

enum AppColor: String {
    // HEX: #6d25df
    case darkPurple
    // HEX: #00ff87
    case lightGreen
    
}


extension Color {
    static func appColor(_ color: AppColor) -> Color {
        return Color(color.rawValue, bundle: .main)
    }
}

