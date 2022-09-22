//
//  AppCore.swift
//  Asssement
//
//  Created by Abdeltawab Mohamed on 20/09/2022.
//

import ComposableArchitecture
import ServiceFrameWork
import SwiftUI
import CoreLocation
import LocationProvider

struct Dependencies {
    let shiftsAPIService: ShiftsListAPIService
    let shiftsStore: ShiftsListStore
    let locationManger: LocationProvider

    init() {
        shiftsAPIService = DefaultShiftsListAPIService()
        shiftsStore = DefaultShiftsListStore(shiftListApiService: shiftsAPIService)
        locationManger = LocationProvider()
    }
}

let dependencies = Dependencies()

struct AppState {
    var jobSection = ShiftsListViewCore.State(shifts: [])
}

enum AppAction {
    case jobSection(ShiftsListViewCore.Action)
}

struct AppEnvironment {
    var fetchShifts: (_ date: String) -> Effect<[ShiftUIModel], Never>
    var mainQueue: AnySchedulerOf<DispatchQueue>
    var userLocation: Effect <CLLocation?, Never>
}

extension AppEnvironment {
    public static var live: AppEnvironment {
        AppEnvironment(
            fetchShifts: { date in
                Effect.task {
                    try await dependencies.shiftsStore.fetchShifts(date: date).map { ShiftUIModel(item: $0) }
                }
                .eraseToEffect()
            },
            mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
            userLocation: {
                do {
                    try dependencies.locationManger.start()
                }
                catch {
                    print("No location access.")
                    dependencies.locationManger.requestAuthorization()
                }
                return Effect.task {
                    dependencies.locationManger.location
                }
                .eraseToEffect()
            }()
        )
    }

    var jobSection: ShiftsListViewCore.Environment {
        .init(
            fetchShifts: fetchShifts,
            userLocation: userLocation,
            mainQueue: mainQueue
        )
    }
}

extension AppEnvironment {
}

let appReducer: Reducer<AppState, AppAction, AppEnvironment> =
    ShiftsListViewCore.reducer.pullback(
        state: \.jobSection,
        action: /AppAction.jobSection,
        environment: \.jobSection)
