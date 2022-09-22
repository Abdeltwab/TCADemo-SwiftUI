//
//  SegmentView.swift
//  Asssement
//
//  Created by Abdeltawab Mohamed on 15/09/2022.
//

import ComposableArchitecture
import SwiftUI


struct ShiftsListExtraaActionsView: View {
    
    private let filterTitle = AppString.filtersTitle
    private let filterIcon = Image.appImage(.filter)
    private let mapTitle = AppString.mapTitle
    private let mapIcon = Image.appImage(.mapPin)
    
    var filtersButtonAction: () -> Void
    var mapButtonAction: () -> Void

    init(
        filtersButtonAction: @escaping () -> Void,
        mapButtonAction: @escaping () -> Void
    ){
        self.filtersButtonAction = filtersButtonAction
        self.mapButtonAction = mapButtonAction
    }
    
    var body: some View {
        Capsule()
            .fill(.white)
            .frame(width: 250, height: 50)
            .shadow(color: .gray,
                    radius: .appSpacing(.xsss),
                    y: .appSpacing(.sx))
            .overlay(
                HStack {
                    ActionButton(title: filterTitle,
                                 image: filterIcon,
                                 action: {
                        filtersButtonAction()
                    })
                    Divider()
                        .background(Color.black)
                        .padding(.vertical, .appSpacing(.xsss))
                    ActionButton(title: mapTitle,
                                 image: mapIcon,
                                 action: {
                        mapButtonAction()
                    })
                }
            )
    }
}

struct ShiftsListExtraaActionsView_Previews: PreviewProvider {
    static var previews: some View {
        ShiftsListExtraaActionsView(
            filtersButtonAction: {},
            mapButtonAction: {})
        .previewLayout(.sizeThatFits)
    }
}
