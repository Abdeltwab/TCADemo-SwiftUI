//
//  Date+Extension.swift
//  Asssement
//
//  Created by Abdeltawab Mohamed on 21/09/2022.
//

import Foundation

enum DateFormate: String {
    case hourMinute = "HH:mm"
    case yearMonthDay = "yyyy-MM-dd"
    case dayNameDayMonth = "EEEE dd MMMM"
}

extension Date {
    
    func toString(formate: DateFormate) -> String {
        let formater = DateFormatter(format: formate.rawValue)
        return formater.string(from: self)
    }
    
    func toString(dateFormatter: DateFormatter) -> String {
        return dateFormatter.string(from: self)
    }
    
    
    var toYearMonthDayFormate: String {
        self.toString(formate: .yearMonthDay)
    }
    
    var dayAfter: Date {
        Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
  
}

extension DateFormatter {
    convenience init(format: String) {
        self.init()
        dateFormat = format
        locale = Locale.current
    }
}
