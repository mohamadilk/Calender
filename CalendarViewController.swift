//
//  ViewController.swift
//  Calendar
//
//  Created by Mohammad Ilkhani on 6/5/19.
//  Copyright © 2019 mohamad. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var monthName: UILabel!
    @IBOutlet weak var collectionViewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var buttomVIew: ButtomView!
    
    
    var currentSelectedMonth = ""
    var selectedAnHour = false
    let month = Month()
    
    private let sectionInsets = UIEdgeInsets(top: 0,
                                             left: 0,
                                             bottom: 0,
                                             right: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.separatorColor = .clear
        
        collectionView.dataSource = self
        collectionView.delegate = self
        let truncatingReminder = (self.view.frame.width) .truncatingRemainder(dividingBy: 7)
        if (truncatingReminder != 0){
            collectionViewWidth.constant = self.view.frame.width - truncatingReminder
        }else{
            collectionViewWidth.constant = self.view.frame.width
        }
        initialViews()
    }
    
    func initialViews() {
        currentSelectedMonth = month.days[0].monthName
        self.navigationItem.title = "Set the Date"
        
        let monthAttr = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)]
        let monthStr = NSAttributedString(string: month.days[0].monthName, attributes: monthAttr)
        
        let yearAttr = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        let yearStr = NSAttributedString(string: " \(month.years[0])", attributes: yearAttr)
        
        let finalStr = NSMutableAttributedString(attributedString: monthStr)
        finalStr.append(yearStr)
        
        monthName.attributedText = finalStr
        buttomVIew.heightConstraint.constant = 0
        buttomVIew.delegate = self
    }
    
}

// TableView Delegate and Datasource
extension CalendarViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.width / 6 * 4 * 0.6
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 60
        }
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 60))
            view.backgroundColor = .white
            
            let topBorder = UIView(frame: CGRect(x: 0, y: 5, width: tableView.frame.size.width, height: 1))
            let buttomBorder = UIView(frame: CGRect(x: 0, y: 59, width: tableView.frame.size.width, height: 1))
            topBorder.backgroundColor = UIColor.UltralightGray()
            buttomBorder.backgroundColor = UIColor.UltralightGray()
            
            let chooseDateLabel = UILabel(frame: CGRect(x: 10, y: 13, width: tableView.frame.size.width, height: 15))
            chooseDateLabel.text = "Choose a start and end hour"
            chooseDateLabel.textColor = .lightGray
            chooseDateLabel.font = UIFont.boldSystemFont(ofSize: 14)
            
            
            let dayDetailLabel = UILabel(frame: CGRect(x: 10, y: 25, width: tableView.frame.size.width, height: 35))
            dayDetailLabel.text = month.days[section].dayTitle
            dayDetailLabel.font = UIFont.boldSystemFont(ofSize: 17)
            
            view.addSubview(chooseDateLabel)
            view.addSubview(dayDetailLabel)
            view.addSubview(topBorder)
            view.addSubview(buttomBorder)
            
            return view
        }
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        view.backgroundColor = .white
        
        let dayDetailLabel = UILabel(frame: CGRect(x: 10, y: 5, width: tableView.frame.size.width, height: 35))
        dayDetailLabel.text = month.days[section].dayTitle
        dayDetailLabel.font = UIFont.boldSystemFont(ofSize: 17)
        view.addSubview(dayDetailLabel)
        
        return view
    }
}

extension CalendarViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return month.days.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayHoursTableViewCell", for: indexPath) as! DayHoursTableViewCell
        cell.configure(day: month.days[indexPath.section], index: indexPath.section)
        cell.delegate = self
        return cell
    }
}

// CollectionView Delegate and Datasource
extension CalendarViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tableView.scrollToRow(at: IndexPath(row: 0, section: indexPath.row), at: .top, animated: true)
    }
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let availableWidth = collectionView.frame.width
        let widthPerItem = availableWidth / 7
        
        return CGSize(width: widthPerItem, height: widthPerItem)
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

extension CalendarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return month.days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeekDayCollectionViewCell", for: indexPath) as! WeekDayCollectionViewCell
        cell.configureCell(day: month.days[indexPath.row])
        if indexPath.row == 0 && !selectedAnHour {
            cell.setAsJustOneSelected()
        }
        return cell
    }
}

// ScrollView Delegate
extension CalendarViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let _ = scrollView as? UICollectionView {
            let visibleIndexes = collectionView.indexPathsForVisibleItems
            
            if visibleIndexes.count > 0 {
                let sortedArray = visibleIndexes.sorted {$0.row < $1.row}
                
                guard let item = collectionView.cellForItem(at: sortedArray[0]) else { return }
                if let item = item as? WeekDayCollectionViewCell {
                    if currentSelectedMonth == item.day.monthName { return }
                    
                    currentSelectedMonth = item.day.monthName
                    let monthAttr = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)]
                    let monthStr = NSAttributedString(string: item.day.monthName, attributes: monthAttr)
                    
                    let yearAttr = [NSAttributedString.Key.foregroundColor: UIColor.gray]
                    let yearStr = NSAttributedString(string: " \(month.years[item.day.dayOfMonth - 1])", attributes: yearAttr)
                    
                    let finalStr = NSMutableAttributedString(attributedString: monthStr)
                    finalStr.append(yearStr)
                    
                    self.monthName.fadeTransition(0.2)
                    self.monthName.attributedText = finalStr
                    
                }
            }
        }
    }
}

// Additional Delegates
extension CalendarViewController: DayHoursTableViewCellDelegate {
    func didSelect(hour: Int, day: Day, index: Int) {
        selectedAnHour = true
        if let cell = collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as? WeekDayCollectionViewCell {
            cell.setAsNotSelected()
        }
        month.updateSelectedTimes(hourIndex: hour, dayIndex: index)
        updateVisibleCells()
        buttomVIew.updateView(selectedHours: month.selectedHours, totalTime: month.includedTimes.count)
    }
    
    func updateVisibleCells() {
        collectionView.reloadData()
        
        guard let tableCells = tableView.indexPathsForVisibleRows else { return }
        
        for index in 0 ... tableCells.count - 1 {
            let cell = tableView.cellForRow(at: tableCells[index]) as? DayHoursTableViewCell
            cell?.configure(day: month.days[tableCells[index].section], index: tableCells[index].section)
        }
    }
}

extension CalendarViewController: ButtomViewDelegate {
    func didConfirmDates() {
        let alert = UIAlertController(title: "Success!", message: "Did Select Hours:\n\(month.selectedHours.firstHour!.hour) to \(month.selectedHours.secondHour!.hour) ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
