
import ComposableArchitecture
import SwiftUI

struct ShiftView: View {
    
    let store: Store<ShiftViewCore.State, ShiftViewCore.Action>
    @ObservedObject var viewStore: ViewStore<ShiftViewCore.State, ShiftViewCore.Action>
    init(store: Store<ShiftViewCore.State, ShiftViewCore.Action>) {
        self.store = store
        viewStore = ViewStore(self.store)
    }

    var body: some View {
        VStack(alignment: .leading ,
               spacing: .appSpacing(.xxxs))
        {
            ZStack(alignment: .bottom) {
                AsyncImage(
                    url: viewStore.state.shift.imageURL,
                    placeholder: { ProgressView() }
                )
                .scaledToFit()
                
                HStack{
                    Spacer()
                    ShiftSalaryView(salary: "\(viewStore.state.shift.item.earningsPerHour)")
                }
            }
            jobDetailsView
        }
    }
}


extension ShiftView {
    
    var jobDetailsView: some View {
        VStack(alignment : .leading) {
            Text("")
            HStack {
                Text(viewStore.state.shift.item.job.category.uppercased())
                Text(".")
                Text("\(viewStore.state.distance). km")
            }
            .font(.appFont(.semiBold, relativeTo: .body))
            .foregroundColor(.appColor(.darkPurple))
            Text(viewStore.state.shift.item.job.clientName)
                .font(.appFont(.semiBold, relativeTo: .headline))
            HStack {
                Text("\(viewStore.state.shift.item.startsAt.toString(formate: .hourMinute))") // TODO: fix date
                Text("-")
                Text("\(viewStore.state.shift.item.endsAt.toString(formate: .hourMinute))") // TODO: fix date
            }
            .font(.appFont(.regular, relativeTo: .body))
        }
    }
}

/*
struct JobItemView_Previews: PreviewProvider {
    static var previews: some View {
        ShiftView(store:
            .init(initialState:
                    .init(shift: Shift(from: Decode)),
                reducer: ShiftViewCore.reducer,
                environment: .init()))
            .previewLayout(.sizeThatFits)
    }
}

 */
