//
//  ContentView.swift
//  Asssement
//
//  Created by Abdeltawab Mohamed on 15/09/2022.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    let store: Store<AppState, AppAction>
    var body: some View {
//        JobListView(
//            store: self.store.scope(
//                state: { $0.jobList} ,
//                action: { .jobList($0) }
//            )
//        )
        
        ShiftsListView(
            store: self.store.scope(
                state: { $0.jobSection} ,
                action: { .jobSection($0) }
            )
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static let store = Store<AppState, AppAction>(
      initialState: AppState(),
      reducer: appReducer,
      environment: .live
    )
    
    static var previews: some View {
        ContentView(store: store)
    }
}
