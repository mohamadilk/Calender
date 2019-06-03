//
//  Hour.swift
//  Calender
//
//  Created by Mohammad Ilkhani on 6/3/19.
//  Copyright © 2019 mohamad. All rights reserved.
//

import Foundation

enum HourState {
    case HourState_NotSelected
    case HourState_SelectedAsStart
    case HourState_SelectedAsEnd
    case HourState_SelectedInRange
}

struct Hour {
    
    let hour: String
    let selectable: Bool
    var state: HourState
    
    init(hour: String, selectable: Bool, state: HourState) {
        self.hour = hour
        self.selectable = selectable
        self.state = state
    }
}
