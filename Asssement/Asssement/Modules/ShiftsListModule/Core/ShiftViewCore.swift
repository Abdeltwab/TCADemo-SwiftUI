//
//  ShiftViewCore.swift
//  Asssement
//
//  Created by Abdeltawab Mohamed on 21/09/2022.
//

import SwiftUI
import CoreLocation
import ServiceFrameWork
import ComposableArchitecture


struct ShiftViewCore: Equatable {

    struct State: Equatable, Identifiable {
        var id: UUID { UUID(uuidString: shift.item.id) ?? UUID()}
        var shift: ShiftUIModel
        var myLocation : CLLocation?
        var distance: String {
            let distance = myLocation?.distanceFrom(shift.jobLocation) ?? 12.0 // dummy error handling
            return "\( Int(distance))"
        }
    }

    enum Action {
        case jobSelected
    }

    struct Environment: Equatable {}

    static let reducer = Reducer<State, Action, Environment> { _, action, _ in
        switch action {
        case .jobSelected:
            return .none
        }
    }
}
