//
//  Day.swift
//  Calender
//
//  Created by Mohammad Ilkhani on 6/3/19.
//  Copyright © 2019 mohamad. All rights reserved.
//

import Foundation

enum DayState {
    case DayState_NotSelected
    case DayState_SelectedAsStart
    case DayState_SelectedAsEnd
    case DayState_SelectedInRange
}

struct Day {
    
    let date: Date
    let dayOfMonth: Int
    let dayName: String
    var state: DayState
    var hours = [Hour]()
 
    init(date: Date, state: DayState) {
        self.date = date
        self.state = state
        self.dayOfMonth = Calendar.current.component(.day, from: date)
        self.dayName = DateHandler.weekdaySymbols(day: Calendar.current.component(.weekday, from: date))
        
        for i in 0...23 {
            let time = i  < 10 ? "0\(i):00" : "\(i):00"
            let selectable = i < 12 ? true : false
            let hour = Hour(hour: time, selectable: selectable, state: .HourState_NotSelected)
            
            self.hours.append(hour)
        }
        print("")
    }
}
