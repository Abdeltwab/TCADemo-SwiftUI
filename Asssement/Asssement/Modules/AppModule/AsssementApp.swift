//
//  AsssementApp.swift
//  Asssement
//
//  Created by Abdeltawab Mohamed on 15/09/2022.
//

import SwiftUI
import ComposableArchitecture

@main
struct AsssementApp: App {
    let appStore = Store<AppState, AppAction>(
      initialState: AppState(),
      reducer: appReducer,
      environment: .live
    )
    
    var body: some Scene {
        WindowGroup {
            ContentView(store: appStore)
        }
    }
}
