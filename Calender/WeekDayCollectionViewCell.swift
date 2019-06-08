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
            backgroundColorView.layer.cornerRadius = 0
            backgroundColorView.isHidden = true
            break
            
        case .DayState_SelectedJustOne:
            backgroundColorView.roundCorners(corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner], radius: backgroundColorView.frame.size.height / 2)
            backgroundViewTrainling.constant = (self.frame.size.width - backgroundColorView.frame.size.height) / 2
            backgroundViewLeading.constant = (self.frame.size.width - backgroundColorView.frame.size.height) / 2
            backgroundColorView.isHidden = false
            break
            
        case .DayState_SelectedAsStart:
            backgroundColorView.roundCorners(corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner], radius: backgroundColorView.frame.size.height / 2)
            backgroundViewTrainling.constant = 0
            backgroundViewLeading.constant = (self.frame.size.width - backgroundColorView.frame.size.height) / 2
            backgroundColorView.isHidden = false
            break
            
        case .DayState_SelectedInRange:
            backgroundColorView.layer.cornerRadius = 0
            backgroundViewTrainling.constant = 0
            backgroundViewLeading.constant = 0
            backgroundColorView.isHidden = false
            break
            
        case .DayState_SelectedAsEnd:
            backgroundColorView.roundCorners(corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner], radius: backgroundColorView.frame.size.height / 2)
            backgroundViewTrainling.constant = (self.frame.size.width - backgroundColorView.frame.size.height) / 2 - 2
            backgroundViewLeading.constant = 0
            backgroundColorView.isHidden = false
            break
        }
    }
}
