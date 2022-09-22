//
//  AppSpacing.swift
//  Asssement
//
//  Created by Abdeltawab Mohamed on 18/09/2022.
//

import SwiftUI

public enum AppSpacing {
    /// 80pt
    case xxxxl
    /// 64pt
    case xxxl
    /// 52pt
    case xxl
    /// 48pt
    case xl
    /// 44
    case xsl
    /// 32pt
    case l
    /// 24pt
    case m
    /// 20pt
    case mm
    /// 16pt
    case s
    /// 14pt
    case xxxxs
    /// 12pt
    case xxxs
    /// 10pt
    case xxs
    /// 8pt
    case xs
    /// 6pt
    case xss
    /// 4pt
    case xsss
    /// 2pt
    case sx
}

public extension CGFloat {

    //MARK: For Spacing

    static func appSpacing(_ spacing: AppSpacing) -> CGFloat {
        switch spacing {
        case .xxxxl:
            return 80
        case .xxxl:
            return 64
        case .xxl:
            return 52
        case .xl:
            return 48
        case .xsl:
            return 46
        case .l:
            return 32
        case .m:
            return 24
        case .mm:
            return 20
        case .s:
            return 16
        case .xxxxs:
            return 14
        case .xxxs:
            return 12
        case .xxs:
            return 10
        case .xs:
            return 8
        case .xss:
            return 6
        case .xsss:
            return 4
        case .sx:
            return 2
        }
    }
}

//public extension Double {
//
//    static func appSpacing(_ spacing: AppSpacing) -> Double {
//        Double(CGFloat.appSpacing(spacing))
//    }
//}

