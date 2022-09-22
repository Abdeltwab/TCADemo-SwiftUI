//
//  OpenSansFont.swift
//  Asssement
//
//  Created by Abdeltawab Mohamed on 18/09/2022.
//

import SwiftUI

enum OpenSansFont: String, CaseIterable {
    case regular = "OpenSans-Regular"
    case bold = "OpenSans-Bold"
    case semiBold = "OpenSans-SemiBold"
}

extension OpenSansFont {
    static func registerFonts() {
        OpenSansFont.allCases.forEach {
            registerFont(bundle: .main, fontName: $0.rawValue, fontExtension: "ttf")
        }
    }

    static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
              let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
              let font = CGFont(fontDataProvider)
        else {
            fatalError("Couldn't create font from data")
        }

        var error: Unmanaged<CFError>?

        CTFontManagerRegisterGraphicsFont(font, &error)
    }
}
