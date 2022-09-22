//
//  ShiftsListViewCore.swift
//  Asssement
//
//  Created by Abdeltawab Mohamed on 21/09/2022.
//

import ComposableArchitecture
import ServiceFrameWork
import SwiftUI
import LocationProvider
import CoreLocation

struct ShiftsListViewCore: Equatable {
    struct State: Equatable {
        var currentTitle = ""
        var isLoading = false
        var dateToRequest = Date()
        var currentDate = Date()
        var shifts: IdentifiedArrayOf<ShiftViewCore.State>
        var myLocation : CLLocation?
        var currentScreen: CurrentScreen = .shiftList
        var activateNavigation = false
    }
    
    enum CurrentScreen{
        case shiftList
        case login
        case signup
        case filters
        case map
        
        var title: String {
            switch self {
            case .shiftList:
                return ""
            case .login:
                return "Login"
            case .signup:
                return "Sign UP "
            case .filters:
                return "Filters"
            case .map:
                return "Map"
            }
        }
    }
    
    enum Action {
        case onAppear
        case updateTitle
        case getUserLocation
        case goToScreen(CurrentScreen)
        case activateNavigation(Bool)
        case fetchShifts(dateString: String)
        case checkIfTitleNeedUpdate(ShiftViewCore.State)
        case shiftsList(Result<[ShiftUIModel], Never>)
        case userlocation(Result<CLLocation?, Never>)
        case loadMoreShiftsIfNeeded(ShiftViewCore.State)
        case jobAction(id: ShiftViewCore.State.ID,
                       action: ShiftViewCore.Action)
    }
    
    struct Environment {
        var fetchShifts: (_ date: String) -> Effect<[ShiftUIModel], Never>
        var userLocation: Effect <CLLocation?, Never>
        var mainQueue: AnySchedulerOf<DispatchQueue>
    }
    
    static let reducer = Reducer<State, Action, Environment>
        .combine(
            ShiftViewCore.reducer
                .forEach(
                    state: \.shifts,
                    action: /ShiftsListViewCore.Action.jobAction(id:action:),
                    environment: { _ in ShiftViewCore.Environment() }),
            Reducer { state, action, environment in
                switch action {
                case .onAppear:
                    state.activateNavigation = false
                    state.currentScreen = .shiftList
                    state.dateToRequest = Date()
                    state.currentDate = Date()
                    let today = state.dateToRequest.toYearMonthDayFormate
                    return .concatenate(
                        .init(value: .updateTitle),
                        .init(value: .getUserLocation),
                        .init(value: .fetchShifts(dateString: today))
                    )
                case let .fetchShifts(date):
                    state.isLoading = true
                    return environment.fetchShifts(date)
                        .receive(on: environment.mainQueue)
                        .catchToEffect()
                        .map(ShiftsListViewCore.Action.shiftsList)
                        .eraseToEffect()
                case let .shiftsList(.success(shifts)):
                    let newShifts = IdentifiedArray(
                        uniqueElements: shifts.map {
                            ShiftViewCore.State(
                                shift: $0,
                                myLocation: state.myLocation)
                        })
                    if state.shifts.isEmpty {
                        state.shifts = newShifts
                    } else {
                        state.shifts.append(contentsOf: newShifts)
                    }
                    state.isLoading = false
                    return .none
                case let .loadMoreShiftsIfNeeded(currentShiftState):
                    let thresholdIndex = state.shifts.index(state.shifts.endIndex, offsetBy: -1)
                    guard
                        let item = state.shifts.first(
                            where: { $0.shift.item.id == currentShiftState.shift.item.id }),
                        !state.isLoading
                    else {
                        return .none //  .init(value: .checkIfTitleNeedUpdate(currentShiftState))
                    }
                    let itemIndex = state.shifts.firstIndex(of: item)
                    if itemIndex == thresholdIndex {
                        state.dateToRequest = state.dateToRequest.dayAfter
                        state.currentDate = state.dateToRequest
                        let dayAfter = state.dateToRequest.toYearMonthDayFormate
                        return
                            .concatenate(
                                .init(value: .checkIfTitleNeedUpdate(currentShiftState)),
                                .init(value: .fetchShifts(dateString: dayAfter))
                            )
                    }
                    return .none
                case .getUserLocation :
                    return environment.userLocation
                        .receive(on: environment.mainQueue)
                        .catchToEffect()
                        .map(ShiftsListViewCore.Action.userlocation)
                        .eraseToEffect()
                case let .userlocation(.success(location)) :
                    state.myLocation = location
                    return .none
                case let .goToScreen(screen):
                    state.currentScreen = screen
                    return .init(value: .activateNavigation(true))
                case let .activateNavigation(status):
                    state.activateNavigation = status
                    return .none
                case let .checkIfTitleNeedUpdate(currentShiftState):
                    let currentStartDate = currentShiftState.shift.item.startsAt
                    if currentStartDate == state.currentDate {
                        return .none
                    }
                    state.currentDate = currentStartDate
                    return .init(value: .updateTitle)
                case .updateTitle :
                    state.currentTitle = state.currentDate.toString(formate: .dayNameDayMonth)
                    return .none
                case .userlocation(.failure) :
                    return .none
                case .jobAction:
                    return .none
                case .shiftsList:
                    return .none
                }
            }
        )
}
