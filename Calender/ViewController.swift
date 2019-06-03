//
//  ViewController.swift
//  Calender
//
//  Created by Mohammad Ilkhani on 6/2/19.
//  Copyright © 2019 mohamad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var tableViewDatasource = TableViewDatasource()
    var collectionViewDatasource = CollectionViewDatasource()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = tableViewDatasource
        tableView.delegate = self
        collectionView.dataSource = collectionViewDatasource
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.width / 6 * 4 * 0.6
    }
}
