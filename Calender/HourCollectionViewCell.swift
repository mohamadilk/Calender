//
//  HourCollectionViewCell.swift
//  Calender
//
//  Created by Mohammad Ilkhani on 6/5/19.
//  Copyright © 2019 mohamad. All rights reserved.
//

import UIKit

class HourCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var availabalityImage: UIImageView!
    
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
            timeLabel.backgroundColor = .clear
            return
        }
        
        switch hour!.state {
        case .HourState_NotSelected:
            timeLabel.layer.cornerRadius = 0
            timeLabel.backgroundColor = .clear
            break

        case .HourState_SelectedJustOne:
            timeLabel.roundCorners(corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner], radius: timeLabel.frame.size.height / 2)
            timeLabel.backgroundColor = .red
            break
            
            
        case .HourState_SelectedAsStart:
            timeLabel.roundCorners(corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner], radius: timeLabel.frame.size.height / 2)
            timeLabel.backgroundColor = .red
            break
            
        case .HourState_SelectedInRange:
            timeLabel.layer.cornerRadius = 0
            timeLabel.backgroundColor = .red
            break
            
        case .HourState_SelectedAsEnd:
            timeLabel.roundCorners(corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner], radius: timeLabel.frame.size.height / 2)
            timeLabel.backgroundColor = .red
            break
        }
    }
    
}
