//
//  ButtomView.swift
//  Calender
//
//  Created by mohamad ilk on 3/17/1398 AP.
//  Copyright © 1398 AP mohamad. All rights reserved.
//

import UIKit

protocol ButtomViewDelegate {
    func didConfirmDates()
}

class ButtomView: UIView {
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var startHour: UILabel!
    @IBOutlet weak var endHour: UILabel!
    
    @IBOutlet weak var totalDuration: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var setDateButton: UIButton!
    
    var delegate: ButtomViewDelegate?
    
    override func layoutSubviews() {
        clipsToBounds = true
        setDateButton.clipsToBounds = true
        setDateButton.layer.cornerRadius = 4
    }
    
    func updateView(selectedHours: (firstHour: Hour?, secondHour: Hour?), totalTime: Int?) {
        var constant: CGFloat = 0
        if (selectedHours.firstHour == nil) && (selectedHours.secondHour == nil) {
            constant = 0
            startHour.text = ""
        } else if (selectedHours.firstHour != nil) && (selectedHours.secondHour == nil) {
            startHour.text = selectedHours.firstHour!.hour
            endHour.text = "Choose end hour"
            constant = 60
        } else if (selectedHours.firstHour != nil) && (selectedHours.secondHour != nil) {
            endHour.text = selectedHours.secondHour?.hour
            totalDuration.text = "/\(totalTime!) hour"
            totalPrice.text = "\(totalTime! * 300)$"
            constant = 100
        }
        self.heightConstraint.constant = constant
        let animator = UIViewPropertyAnimator(duration: 0.2, curve: .linear, animations: {
            self.layoutIfNeeded()
        })
        animator.startAnimation()
    }
    
    @IBAction func setDate(_ sender: UIButton) {
        delegate?.didConfirmDates()
    }
}
