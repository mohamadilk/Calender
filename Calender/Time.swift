//
//  Time.swift
//  Calender
//
//  Created by mohamad ilk on 3/17/1398 AP.
//  Copyright © 1398 AP mohamad. All rights reserved.
//

import Foundation

class Time {
    
    let dayIndex: Int
    let hourIndex: Int
    
    init(dayIndex: Int, hourIndex: Int) {
        self.dayIndex = dayIndex
        self.hourIndex = hourIndex
    }
}

extension Time: Equatable {
    static func == (lhs: Time, rhs: Time) -> Bool {
        return lhs.dayIndex == rhs.dayIndex && lhs.hourIndex == rhs.hourIndex
    }
    
    static func < (lhs: Time, rhs: Time) -> Bool {
        if lhs.dayIndex == rhs.dayIndex { return lhs.hourIndex < rhs.hourIndex }
        return lhs.dayIndex < rhs.dayIndex
    }
    
    static func > (lhs: Time, rhs: Time) -> Bool {
        if lhs.dayIndex == rhs.dayIndex { return lhs.hourIndex > rhs.hourIndex }
        return lhs.dayIndex > rhs.dayIndex
    }
}
