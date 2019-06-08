//
//  Day.swift
//  Calender
//
//  Created by Mohammad Ilkhani on 6/6/19.
//  Copyright © 2019 mohamad. All rights reserved.
//

import Foundation

enum DayState {
    case DayState_NotSelected
    case DayState_SelectedJustOne
    case DayState_SelectedAsStart
    case DayState_SelectedAsEnd
    case DayState_SelectedInRange
}

struct Day {
    
    let date: Date
    let dayOfMonth: Int
    let dayName: String
    let fullDayName: String
    var state: DayState
    var hours = [Hour]()
    let dayTitle: String
    let monthName: String
 
    static let dateFormatter = DateFormatter()

    init(date: Date, state: DayState) {
        
        self.date = date
        self.state = state
        self.dayOfMonth = Calendar.current.component(.day, from: date)
        self.dayName = Day.dateFormatter.shortWeekdaySymbols[Calendar.current.component(.weekday, from: date) - 1]
        self.fullDayName = Day.dateFormatter.weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1]
        self.monthName = Day.monthName(date: self.date)
        self.dayTitle = "\(dayOfMonth)th, \(monthName), \(fullDayName)"
        
        for i in 0...23 {
            let time = i  < 10 ? "0\(i):00" : "\(i):00"
            let selectable = i < 12 ? true : false
            let hour = Hour(hour: time, date: self.date, selectable: selectable, state: .HourState_NotSelected)
            
            self.hours.append(hour)
        }
    }
}

extension Day {
    static func monthName(date: Date) -> String {
        dateFormatter.dateFormat = "LLLL"
        let month = dateFormatter.string(from: date)
        return month
    }
}
