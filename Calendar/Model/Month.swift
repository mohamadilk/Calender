//
//  Month.swift
//  Calendar
//
//  Created by Mohammad Ilkhani on 6/6/19.
//  Copyright © 2019 mohamad. All rights reserved.
//

import Foundation

class Month {
    
    var days: [Day]
    let years: [Int]
    var selectedHours: (firstHour: Hour?, secondHour: Hour?) = (firstHour: nil, secondHour: nil)
    var includedTimes: Array<Time> = Array()
    
    init() {
        self.days = Month.oneMonthDates()
        self.years = Month.years(days: self.days)
    }
    
    func updateSelectedTimes(hourIndex: Int, dayIndex: Int) {
        let newTime = Time(dayIndex: dayIndex, hourIndex: hourIndex)
        
        if selectedHours.firstHour == nil { // No hour has been selected
            selectedHours.firstHour = days[newTime.dayIndex].hours[newTime.hourIndex]
            includedTimes.append(Time(dayIndex: newTime.dayIndex, hourIndex: newTime.hourIndex))
            
        } else if selectedHours.secondHour == nil { // First hour has been selected, go for second
            if newTime == includedTimes.first! { // Deselect first hour
                updateRemovedHours(array: includedTimes)
                includedTimes.removeAll()
                selectedHours.firstHour = nil
                
            } else if newTime < includedTimes.first! { // Replace first hour
                updateFirstSelectedHour(newTime: newTime)
                
            } else { // did select second Hour
                selectedHours.secondHour = days[newTime.dayIndex].hours[newTime.hourIndex]
                secondHourUpdatedTo(newTime: newTime)
            }
        } else { // Selected both hours, update them
            if newTime < includedTimes.first! { // New hour is in an earlear time, remove all selected days and insert new one
                updateFirstSelectedHour(newTime: newTime)
                
            } else if newTime > includedTimes.last! { // New hour is later, add new hours
                selectedHours.secondHour = days[newTime.dayIndex].hours[newTime.hourIndex]
                secondHourUpdatedTo(newTime: newTime)
                
            } else if newTime == includedTimes.first! {
                selectedHours.secondHour = nil
                removeExteraHoursTo(newTime: newTime)
                
            } else { // New hour is in current range
                selectedHours.secondHour = days[newTime.dayIndex].hours[newTime.hourIndex]
                removeExteraHoursTo(newTime: newTime)
            }
        }
        updateStates()
    }
    
    func updateFirstSelectedHour(newTime: Time) {
        updateRemovedHours(array: includedTimes)
        includedTimes.removeAll()
        selectedHours.firstHour = days[newTime.dayIndex].hours[newTime.hourIndex]
        selectedHours.secondHour = nil
        includedTimes.append(Time(dayIndex: newTime.dayIndex, hourIndex: newTime.hourIndex))
    }
    
    func secondHourUpdatedTo(newTime: Time) {
        if newTime.dayIndex == includedTimes.last!.dayIndex { // New hour is in last current selected date, just hours needs to get updated
            addNewHoursToCurrentLastDay(newTime: newTime)
        } else if newTime.dayIndex == includedTimes.last!.dayIndex + 1 { // New hour is in the next day
            fillCurrentLastDay()
            addNewHoursToNextDay(newTime: newTime)
        } else { // There are some days in between
            fillCurrentLastDay()
            addNewHoursToMiddleDaysBetween(lowerBound: includedTimes.last!.dayIndex + 1, upperBound: newTime.dayIndex - 1)
            addNewHoursToNextDay(newTime: newTime)
        }
    }
    
    func addNewHoursToCurrentLastDay(newTime: Time) { // Adds some days based on newHour
        for hour in (includedTimes.last!.hourIndex + 1) ... newTime.hourIndex {
            includedTimes.append(Time(dayIndex: newTime.dayIndex, hourIndex: hour))
        }
    }
    
    func fillCurrentLastDay() { // fills new hours till last hour of day
        for hour in (includedTimes.last!.hourIndex + 1) ... 23{
            includedTimes.append(Time(dayIndex: includedTimes.last!.dayIndex, hourIndex: hour))
        }
    }
    
    func addNewHoursToNextDay(newTime: Time) { // Adds new hours from zero till newTime in last day
        for hour in 0 ... newTime.hourIndex {
            includedTimes.append(Time(dayIndex: newTime.dayIndex, hourIndex: hour))
        }
    }
    
    func addNewHoursToMiddleDaysBetween(lowerBound: Int, upperBound: Int) {
        for day in lowerBound ... upperBound {
            for hour in 0 ... 23 {
                includedTimes.append(Time(dayIndex: day, hourIndex: hour))
            }
        }
    }
    
    func removeExteraHoursTo(newTime: Time) {
        let tempTimeArray = includedTimes
        var removedObjects = [Time]()
        
        for time in tempTimeArray {
            if time > newTime {
                removedObjects.append(time)
                let index = includedTimes.index(of:time)
                includedTimes.remove(at: index!)
            }
        }
        updateRemovedHours(array: removedObjects)
    }
    
    func updateRemovedHours(array: Array<Time>) {
        for time in array {
            days[time.dayIndex].state = .DayState_NotSelected
        }
        for time in array {
            days[time.dayIndex].hours[time.hourIndex].state = .HourState_NotSelected
        }
    }
    
    func updateStates() {
        updateDayStatesForSelectedHours()
        updateHourStatesForSelectedHours()
    }
    
    func updateDayStatesForSelectedHours() {
        
        var daysArray = [Int]()
        
        for time in includedTimes {
            daysArray.append(time.dayIndex)
        }
        
        var uniqueDyas = Array(Set(daysArray))
        uniqueDyas.sort()
        
        switch uniqueDyas.count {
        case 0:
            break
            
        case 1:
            days[uniqueDyas.first!].state = .DayState_SelectedJustOne
            break
            
        case 2:
            days[uniqueDyas.first!].state = .DayState_SelectedAsStart
            days[uniqueDyas.last!].state = .DayState_SelectedAsEnd
            break
            
        default:
            days[uniqueDyas.first!].state = .DayState_SelectedAsStart
            days[uniqueDyas.last!].state = .DayState_SelectedAsEnd
            
            for day in uniqueDyas {
                if day != uniqueDyas.first! && day != uniqueDyas.last! {
                    days[day].state = .DayState_SelectedInRange
                }
            }
            break
        }
    }
    
    func updateHourStatesForSelectedHours() {
        switch includedTimes.count {
        case 0:
            break
            
        case 1:
            days[includedTimes.first!.dayIndex].hours[includedTimes.first!.hourIndex].state = .HourState_SelectedJustOne
            break
            
        case 2:
            days[includedTimes.first!.dayIndex].hours[includedTimes.first!.hourIndex].state = .HourState_SelectedAsStart
            days[includedTimes.last!.dayIndex].hours[includedTimes.last!.hourIndex].state = .HourState_SelectedAsEnd
            break
            
        default:
            days[includedTimes.first!.dayIndex].hours[includedTimes.first!.hourIndex].state = .HourState_SelectedAsStart
            days[includedTimes.last!.dayIndex].hours[includedTimes.last!.hourIndex].state = .HourState_SelectedAsEnd
            
            for time in includedTimes {
                if time != includedTimes.first! && time != includedTimes.last! {
                    days[time.dayIndex].hours[time.hourIndex].state = .HourState_SelectedInRange
                }
            }
            break
        }
    }
}

extension  Month {
    
    static let dateFormatter = DateFormatter()
    
    static func oneMonthDates() -> [Day] {
        
        var tempDate = Date()
        var array = [Day(date: tempDate, state: .DayState_NotSelected)]
        let toDate = Calendar.current.date(byAdding: .day, value: 29, to: tempDate)!
        
        while tempDate < toDate {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(Day(date: tempDate, state: .DayState_NotSelected))
        }
        
        return array
    }
    
    static func years(days: [Day]) -> [Int] {
        var years = [Int]()
        for day in days {
            years.append(Calendar.current.component(.year, from: day.date))
        }
        return years
    }
}
