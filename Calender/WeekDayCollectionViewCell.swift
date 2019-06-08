//
//  WeekDayCollectionViewCell.swift
//  Calender
//
//  Created by Mohammad Ilkhani on 6/6/19.
//  Copyright © 2019 mohamad. All rights reserved.
//

import UIKit

class WeekDayCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var dayNumberLabel: UILabel!
    @IBOutlet weak var backgroundColorView: UIView!
    
    @IBOutlet weak var backgroundViewTrainling: NSLayoutConstraint!
    @IBOutlet weak var backgroundViewLeading: NSLayoutConstraint!
    
    var day: Day = Day(date: Date(), state: .DayState_NotSelected) {
        didSet {
            dayNumberLabel.text = "\(day.dayOfMonth)"
            dayNameLabel.text = day.dayName
        }
    }
    
    func configureCell(day: Day) {
        self.day = day
        checkBackgroundColor()
    }
    
    func checkBackgroundColor() {
        
        switch day.state {
        case .DayState_NotSelected:
            dayNumberLabel.layer.cornerRadius = 0
            dayNumberLabel.backgroundColor = .clear
            break
            
        case .DayState_SelectedJustOne:
            dayNumberLabel.roundCorners(corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner], radius: dayNumberLabel.frame.size.height / 2)
            dayNumberLabel.backgroundColor = .blue
            break
            
        case .DayState_SelectedAsStart:
            dayNumberLabel.roundCorners(corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner], radius: dayNumberLabel.frame.size.height / 2)
            dayNumberLabel.backgroundColor = .blue
            break
            
        case .DayState_SelectedInRange:
            dayNumberLabel.layer.cornerRadius = 0
            dayNumberLabel.backgroundColor = .blue
            break
            
        case .DayState_SelectedAsEnd:
            dayNumberLabel.roundCorners(corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner], radius: dayNumberLabel.frame.size.height / 2)
            dayNumberLabel.backgroundColor = .blue
            break
        }
    }
}
