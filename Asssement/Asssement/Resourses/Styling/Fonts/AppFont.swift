//
//  CustomFont.swift
//  Asssement
//
//  Created by Abdeltawab Mohamed on 18/09/2022.
//

import SwiftUI

private var isFontRegistered: Bool = false

extension Font.TextStyle {
    var size: CGFloat {
        switch self {
        /// 60pt
        case .largeTitle: return 60
        /// 40pt
        case .title: return 40
        /// 34pt
        case .title2: return 34
        /// 26pt
        case .title3: return 26
        /// 20pt
        case .headline: return 20
        /// 18pt
        case .body: return 18
        /// 16pt
        case .subheadline, .callout: return 16
        /// 14pt
        case .footnote: return 14
        /// 12pt
        case .caption, .caption2: return 12
        @unknown default:
            return 8
        }
    }
}


extension Font {
    
    static func appFont(_ font: OpenSansFont, relativeTo style: Font.TextStyle) -> Font {
        if !isFontRegistered {
            OpenSansFont.registerFonts()
            isFontRegistered.toggle()
        }
        return custom(font.rawValue, size: style.size, relativeTo: style)
    }
}
