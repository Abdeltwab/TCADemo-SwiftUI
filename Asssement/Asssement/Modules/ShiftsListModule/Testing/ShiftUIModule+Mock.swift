//
//  ShiftUIModule+Mock.swift
//  Asssement
//
//  Created by Abdeltawab Mohamed on 22/09/2022.
//

import Foundation
import CoreLocation
import ServiceFrameWork

extension ShiftUIModel {
    static var  mock: ShiftUIModel {
        ShiftUIModel(item: .mock)
    }
}

extension Shift {
    static var mock: Shift {
        Shift(id: "randomShiftID",
              startsAt: Date(),
              endsAt: Date().dayAfter,
              earningsPerHour: "15.0",
              job: .mock)
    }
}


extension Job {
    static var mock: Job {
        let url = URL(string: "https://tmpr-photos.ams3.digitaloceanspaces.com/hero/21105.jpg")
        return Job(clientName: "Temper",
            imageURL: url,
            category: "Working",
            address: .mock)
    }
}


extension Address {
    static var mock: Address {
        let location = CLLocation(latitude: 51.687627,
                                    longitude: 5.306105)

       return Address(coordinate: location)
    }
}
