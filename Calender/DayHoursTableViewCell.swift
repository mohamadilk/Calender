//
//  DayHoursTableViewCell.swift
//  Calender
//
//  Created by Mohammad Ilkhani on 6/5/19.
//  Copyright © 2019 mohamad. All rights reserved.
//

import UIKit

protocol DayHoursTableViewCellDelegate {
    func didSelect(hour: Int, day: Day, index: Int)
}

class DayHoursTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var day = Day(date: Date(), state: .DayState_NotSelected)
    var index: Int?
    var delegate: DayHoursTableViewCellDelegate?
    
    private let itemPerRow:CGFloat = 6.0
    private let sectionInsets = UIEdgeInsets(top: 0,
                                             left: 0,
                                             bottom: 0,
                                             right: 0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false

    }
    
    func configure(day: Day, index: Int) {
        self.day = day
        self.index = index
        collectionView.reloadData()
    }
    
}

// UICollectionView Delegate and Datasource
extension DayHoursTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let availableWidth = collectionView.frame.width
        let widthPerItem = availableWidth / 6
        
        return CGSize(width: widthPerItem, height: widthPerItem * 0.6)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.bottom
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

extension DayHoursTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return day.hours.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourCollectionCell", for: indexPath) as! HourCollectionViewCell        
        cell.configure(hour: day.hours[indexPath.row])
        return cell
    }
}

extension DayHoursTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if day.hours[indexPath.row].selectable == false { return }
        delegate?.didSelect(hour: indexPath.row, day: day, index: index!)
    }
}
