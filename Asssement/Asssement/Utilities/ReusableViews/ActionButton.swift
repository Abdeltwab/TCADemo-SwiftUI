//
//  ActionButton.swift
//  Asssement
//
//  Created by Abdeltawab Mohamed on 18/09/2022.
//

import SwiftUI

struct ActionButton: View {
    
    var title: String
    var image: Image
    var action: () -> Void
    
    init(
        title: String,
        image: Image,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.image = image
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: .appSpacing(.xss)){
                image
                    .resizable()
                    .frame(
                        width: .appSpacing(.mm),
                        height: .appSpacing(.mm),
                        alignment: .center)
                Text(title)
            }
            .foregroundColor(.black)
            .font(.appFont(.semiBold, relativeTo: .body))
        }
        .padding()

    }
}


struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ActionButton(
            title: "Filters",
            image: .appImage(.mapPin),
            action: {})
        .previewLayout(.sizeThatFits)
    }
}
