//
//  DateHandler.swift
//  Calender
//
//  Created by Mohammad Ilkhani on 6/3/19.
//  Copyright © 2019 mohamad. All rights reserved.
//

import UIKit

class DateHandler {

    static let dateFormatter = DateFormatter()
    
    static func oneMonthDates() -> [Day] {
        
        var tempDate = Date()
        var array = [Day(date: tempDate, state: .DayState_NotSelected)]
        let toDate = Calendar.current.date(byAdding: .day, value: 29, to: tempDate)!
        
        while tempDate < toDate {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(Day(date: tempDate, state: .DayState_NotSelected))
        }
        
        return array
    }
    
    static func weekdaySymbols(day: Int) -> String {
        return dateFormatter.shortWeekdaySymbols[day - 1]
    }
}
