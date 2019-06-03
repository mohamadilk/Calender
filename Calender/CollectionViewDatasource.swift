//
//  CollectionViewDatasource.swift
//  Calender
//
//  Created by Mohammad Ilkhani on 6/2/19.
//  Copyright © 2019 mohamad. All rights reserved.
//

import UIKit

class CollectionViewDatasource: NSObject, UICollectionViewDataSource {
    
    let currentDate = Calendar.current.component(.day, from: Date())
    let datesArray = DateHandler.oneMonthDates()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeekDayCollectionViewCell", for: indexPath) as! WeekDayCollectionViewCell
        cell.configureCell(day: datesArray[indexPath.row])
        return cell
    }
}
