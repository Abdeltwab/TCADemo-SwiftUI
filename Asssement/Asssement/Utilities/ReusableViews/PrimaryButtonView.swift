//
//  PrimaryButton.swift
//  Asssement
//
//  Created by Abdeltawab Mohamed on 15/09/2022.
//

import SwiftUI

struct PrimaryButtonView: View {
    var title: String
    var isFilled: Bool
    var action: () -> Void

    init(
        title: String,
        isFilled: Bool,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.isFilled = isFilled
        self.action = action
    }

    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.appFont(.semiBold, relativeTo: .headline))
                .foregroundColor(.black)
                .padding(.vertical, .appSpacing(.xxxs))
                .padding(.horizontal, .appSpacing(.xsl))
                .overlay(
                    RoundedRectangle(cornerRadius: .appSpacing(.xxs))
                        .stroke( isFilled ? .clear : Color.black,
                                 lineWidth: .appSpacing(.xsss))
                )
        }
        .background(isFilled ? Color.appColor(.lightGreen) : .clear)
        .cornerRadius(.appSpacing(.xxs))
    }
    
}

struct PrimaryButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButtonView(
            title: "Sign up",
            isFilled: false,
            action: {})
            .previewLayout(.sizeThatFits)
    }
}
