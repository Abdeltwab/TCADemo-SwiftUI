//
//  JobsSectionModel.swift
//  Asssement
//
//  Created by Abdeltawab Mohamed on 18/09/2022.
//

import ServiceFrameWork
import CoreLocation

fileprivate enum Constant {
    ///Dump place holder
    static let placeHolderImgString = "https://tmpr-photos.ams3.digitaloceanspaces.com/hero/21105.jpg"
}

struct ShiftUIModel {
    let item: Shift
    var jobLocation: CLLocation {
        return CLLocation(
            latitude: item.job.address.coordinate.coordinate.longitude,
            longitude: item.job.address.coordinate.coordinate.latitude)
    }
    var imageURL: URL{
        item.job.imageURL ?? URL(string: Constant.placeHolderImgString)!
    }
}

extension ShiftUIModel : Equatable {}
