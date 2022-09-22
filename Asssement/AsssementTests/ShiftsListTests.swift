
//  Created by Abdeltawab Mohamed on 22/09/2022.
//


@testable import Asssement
import XCTest
import Foundation
import ComposableArchitecture

final class ShiftsListTests: XCTestCase {
    private let scheduler = DispatchQueue.immediate
    private let shifts: [ShiftUIModel] = [.mock, .mock]
    
    private lazy var environment = ShiftsListViewCore.Environment(
        fetchShifts: { _ in Effect(value: self.shifts) },
        mainQueue: scheduler.eraseToAnyScheduler()
    )
    
    
    func test_onAppear() {
        let store = TestStore(
            initialState:
                ShiftsListViewCore.State(
                    currentTitle: "Testing Title",
                    isLoading: true,
                    dateToRequest: Date(),
                    currentDate: Date(),
                    shifts: []) ,
            reducer: ShiftsListViewCore.reducer,
            environment: environment
        )
        
        store.send(.onAppear)
        
//        store.receive(.fetchShifts(dateString: Date().toYearMonthDayFormate))
        //TODO: To complete 

    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
