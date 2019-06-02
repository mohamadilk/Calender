//
//  CollectionViewDatasource.swift
//  Calender
//
//  Created by Mohammad Ilkhani on 6/2/19.
//  Copyright © 2019 mohamad. All rights reserved.
//

import UIKit

class CollectionViewDatasource: NSObject, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath)
        return cell
    }
    

}
