//
//  Hour.swift
//  Calendar
//
//  Created by Mohammad Ilkhani on 6/6/19.
//  Copyright © 2019 mohamad. All rights reserved.
//

import Foundation

enum HourState {
    case HourState_NotSelected
    case HourState_SelectedJustOne
    case HourState_SelectedAsStart
    case HourState_SelectedAsEnd
    case HourState_SelectedInRange
}

struct Hour {
    
    let hour: String
    let date: Date
    let selectable: Bool
    var state: HourState
    
    init(hour: String, date: Date, selectable: Bool, state: HourState) {
        self.hour = hour
        self.date = date
        self.selectable = selectable
        self.state = state
    }
}
