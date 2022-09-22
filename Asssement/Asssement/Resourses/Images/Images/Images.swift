//
//  Images.swift
//  Asssement
//
//  Created by Abdeltawab Mohamed on 18/09/2022.
//

import SwiftUI

enum CustomImage: String, ImageProvider {
    case mapPin
    case filter
    case test
    
    var name: String {
        rawValue
    }

    var bundle: Bundle {
        .main
    }
}

enum SystemImage: String {
    case none
}


extension Image {
    static func appImage(_ image: CustomImage) -> Image {
        Image(image.name, bundle: image.bundle)
    }

    static func appImage(_ systemImage: SystemImage) -> Image {
        Image(systemName: systemImage.rawValue)
    }
}


protocol ImageProvider {
    var name: String { get }
    var bundle: Bundle { get }
}

