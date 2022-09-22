//
//  ShiftsListViewCoreView.swift
//  Asssement
//
//  Created by Abdeltawab Mohamed on 18/09/2022.
//

import ComposableArchitecture
import SwiftUI
import LocationProvider

struct ShiftsListView: View {
    let store: Store<ShiftsListViewCore.State, ShiftsListViewCore.Action>
    @ObservedObject var viewStore: ViewStore<ShiftsListViewCore.State, ShiftsListViewCore.Action>
    init(store: Store<ShiftsListViewCore.State, ShiftsListViewCore.Action>) {
        self.store = store
        viewStore = ViewStore(self.store)
    }
    @State private var isShowingDetailView = false

    var body: some View {
//        NavigationView {
//            VStack {
//                NavigationLink(destination: Text("Second View"),
//                               isActive: $isShowingDetailView) { EmptyView() }
//                Button("Tap to show detail") {
//                    self.isShowingDetailView = true
//                }
//            }
//            .navigationTitle("Navigation")
//        }

        
       NavigationView {

           VStack(alignment: .leading) {
               Text(viewStore.state.currentTitle)
                   .font(.appFont(.semiBold, relativeTo: .headline))
                   .padding(.horizontal, 12)
               
               ZStack(alignment: .bottom) {
                   
                   List {
                       ForEach(viewStore.state.shifts) { shiftState in
                           ShiftView(store: .init(initialState: shiftState,
                                                  reducer: ShiftViewCore.reducer,
                                                  environment: .init()))
                           .onAppear {
                               //                                viewStore.send(.checkIfTitleNeedUpdate(shiftState))
                               viewStore.send(.loadMoreShiftsIfNeeded(shiftState))
                           }
                       }
                   }
                   .listStyle(.plain)
                   
                   ShiftsListExtraaActionsView {
                       viewStore.send(.goToScreen(.filters))
                   } mapButtonAction: {
                       viewStore.send(.goToScreen(.map))
                   }
                   .padding(.bottom, 40)
               }
               
               HStack(alignment: .center) {
                   Spacer()
                   AuthenticationView(
                    signUpButtonAction: {
                        viewStore.send(.goToScreen(.signup))
                    },
                    loginButtonAction: {
                        viewStore.send(.goToScreen(.login))
                    })
                   Spacer()
               }
               .padding(.horizontal)
               NavigationLink(
                destination: Text(viewStore.currentScreen.title),
                isActive: viewStore.binding(
                    get: \.activateNavigation,
                    send: ShiftsListViewCore.Action.activateNavigation)) {
                    EmptyView() }
           }
        .onAppear {
            viewStore.send(.onAppear)
        }
        .refreshable {
            await viewStore.send(.onAppear)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
          
        }
        
    }
}

/*
 struct ShiftsListViewCoreView_Previews: PreviewProvider {
     static var previews: some View {
         ShiftsListViewCoreView(store:
                 .init(
                     initialState:
                             .init(id: UUID(),
                                   title: "Sunday 8 September",
                                   jobs: .mock),
                     reducer: ShiftsListViewCore.reducer,
                     environment: .init(
                         fetchShifts: AppEnvironment.live.fetchShifts,
                         provider: .live,
                         mainQueue: .main.eraseToAnyScheduler()))
         )
     }
 }
 */
