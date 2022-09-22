//
//  CLLocation+.swift
//  Asssement
//
//  Created by Abdeltawab Mohamed on 22/09/2022.
//

import CoreLocation

extension CLLocation {
    
    func distanceFrom(_ point: CLLocation) -> Double {
         self.distance(from: point) / 1000
    }
}
