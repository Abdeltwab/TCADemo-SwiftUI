//
//  AppString.swift
//  Asssement
//
//  Created by Abdeltawab Mohamed on 18/09/2022.
//

import Foundation

//MARK: - General
enum AppString {
    static let loginTitle = AppString.tr("Localizable", "login_title")
    static let signupTitle = AppString.tr("Localizable", "signup_title")
}

// MARK: - JobList View
extension AppString {
    static let mapTitle = AppString.tr("Localizable", "map_title")
    static let filtersTitle = AppString.tr("Localizable", "filters_title")
}


extension AppString {
    static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
        let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
        return String(format: format, locale: Locale.current, arguments: args)
    }
}

private final class BundleToken {
    static let bundle: Bundle = {
        #if SWIFT_PACKAGE
            return Bundle.main
        #else
            return Bundle(for: BundleToken.self)
        #endif
    }()
}
