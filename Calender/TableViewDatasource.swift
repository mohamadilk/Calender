//
//  TableViewDatasource.swift
//  Calender
//
//  Created by Mohammad Ilkhani on 6/2/19.
//  Copyright © 2019 mohamad. All rights reserved.
//

import UIKit

class TableViewDatasource: NSObject, UITableViewDataSource {
    
    var objects = [Any]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayHoursTableViewCell", for: indexPath)
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
}
