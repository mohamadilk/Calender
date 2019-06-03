//
//  HourCollectionViewCell.swift
//  Calender
//
//  Created by Mohammad Ilkhani on 6/2/19.
//  Copyright © 2019 mohamad. All rights reserved.
//

import UIKit

class HourCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var availabalityImage: UIImageView!
    
    func configure(hour: Hour) {
        timeLabel.text = hour.hour
        
        if !hour.selectable {
            timeLabel.alpha = 0.5
            availabalityImage.isHidden = false
        }
    }
    
}
