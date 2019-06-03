//
//  WeekDayCollectionViewCell.swift
//  Calender
//
//  Created by Mohammad Ilkhani on 6/3/19.
//  Copyright © 2019 mohamad. All rights reserved.
//

import UIKit

class WeekDayCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var dayNumberLabel: UILabel!
    
    var day: Day = Day(date: Date(), state: .DayState_NotSelected) {
        didSet {
            dayNumberLabel.text = "\(day.dayOfMonth)"
            dayNameLabel.text = day.dayName
        }
    }
    
    func configureCell(day: Day) {
        self.day = day
    }
}
