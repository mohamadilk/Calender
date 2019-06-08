//
//  HourCollectionViewCell.swift
//  Calendar
//
//  Created by Mohammad Ilkhani on 6/5/19.
//  Copyright © 2019 mohamad. All rights reserved.
//

import UIKit

class HourCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var availabalityImage: UIImageView!
    @IBOutlet weak var backgroundColorView: UIView!
    
    @IBOutlet weak var backgroundViewLeading: NSLayoutConstraint!
    @IBOutlet weak var backgroundViewTrailing: NSLayoutConstraint!
    
    var hour: Hour?
    
    func configure(hour: Hour) {
        self.hour = hour
        timeLabel.text = hour.hour
        
        if !hour.selectable {
            timeLabel.alpha = 0.5
            availabalityImage.isHidden = false
        } else {
            timeLabel.alpha = 1.0
            availabalityImage.isHidden = true
        }
        checkBackgroundColor()
    }
    
    func checkBackgroundColor() {
        
        if !hour!.selectable {
            timeLabel.layer.cornerRadius = 0
            backgroundColorView.isHidden = true
            return
        }
        
        switch hour!.state {
        case .HourState_NotSelected:
            backgroundColorView.layer.cornerRadius = 0
            backgroundColorView.isHidden = true
            break
            
        case .HourState_SelectedJustOne:
            backgroundColorView.roundCorners(corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner], radius: backgroundColorView.frame.size.height / 2)
            backgroundViewTrailing.constant = (self.frame.size.width - backgroundColorView.frame.size.height) / 2 - 10
            backgroundViewLeading.constant = (self.frame.size.width - backgroundColorView.frame.size.height) / 2 - 10
            backgroundColorView.isHidden = false
            break
            
        case .HourState_SelectedAsStart:
            backgroundColorView.roundCorners(corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner], radius: backgroundColorView.frame.size.height / 2)
            backgroundViewTrailing.constant = 0
            backgroundViewLeading.constant = (self.frame.size.width - backgroundColorView.frame.size.height) / 2 - 10
            backgroundColorView.isHidden = false
            break
            
        case .HourState_SelectedInRange:
            backgroundColorView.layer.cornerRadius = 0
            backgroundViewTrailing.constant = 0
            backgroundViewLeading.constant = 0
            backgroundColorView.isHidden = false
            break
            
        case .HourState_SelectedAsEnd:
            backgroundColorView.roundCorners(corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner], radius: backgroundColorView.frame.size.height / 2)
            backgroundViewTrailing.constant = (self.frame.size.width - backgroundColorView.frame.size.height) / 2 - 10
            backgroundViewLeading.constant = 0
            backgroundColorView.isHidden = false
            break
        }
    }
    
}
