//
//  WeekDayCollectionViewCell.swift
//  Calendar
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
            setAsNotSelected()
            break
            
        case .DayState_SelectedJustOne:
            setAsJustOneSelected()
            break
            
        case .DayState_SelectedAsStart:
            setAsSelectedAsStart()
            break
            
        case .DayState_SelectedInRange:
            setAsSelectedInRange()
            break
            
        case .DayState_SelectedAsEnd:
            setAsSelectedAsEnd()
            break
        }
    }
    
    func setAsJustOneSelected() {
        backgroundColorView.roundCorners(corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner], radius: backgroundColorView.frame.size.height / 2)
        backgroundViewTrainling.constant = (self.frame.size.width - backgroundColorView.frame.size.height) / 2
        backgroundViewLeading.constant = (self.frame.size.width - backgroundColorView.frame.size.height) / 2
        backgroundColorView.isHidden = false
    }
    
    func setAsNotSelected() {
        backgroundColorView.layer.cornerRadius = 0
        backgroundColorView.isHidden = true
    }
    
    func setAsSelectedAsStart() {
        backgroundColorView.roundCorners(corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner], radius: backgroundColorView.frame.size.height / 2)
        backgroundViewTrainling.constant = 0
        backgroundViewLeading.constant = (self.frame.size.width - backgroundColorView.frame.size.height) / 2
        backgroundColorView.isHidden = false
    }
    
    func setAsSelectedInRange() {
        backgroundColorView.layer.cornerRadius = 0
        backgroundViewTrainling.constant = 0
        backgroundViewLeading.constant = 0
        backgroundColorView.isHidden = false
    }
    
    func setAsSelectedAsEnd() {
        backgroundColorView.roundCorners(corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner], radius: backgroundColorView.frame.size.height / 2)
        backgroundViewTrainling.constant = (self.frame.size.width - backgroundColorView.frame.size.height) / 2 - 2
        backgroundViewLeading.constant = 0
        backgroundColorView.isHidden = false
    }
}
