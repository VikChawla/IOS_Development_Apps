//
//  RoutineModel.swift
//  ProgressiveOverload
//
//  Created by Vik Chawla on 7/28/20.
//  Copyright © 2020 Vik Chawla. All rights reserved.
//

import Foundation
import RealmSwift
class RoutineModel
{
    var realm = try! Realm()
    var currLifts = [String]()
    var currLiftsObjects = [ExerciseModel]()
    func findPrevious(exercise: String) -> [String]?
       {
        print("run once")
        var currLiftsTemp = [String]()
        var currLiftsObjectsTemp = [ExerciseModel]()
        
          let formatter = DateFormatter()
                   formatter.timeZone = .current
                   formatter.locale = .current
                   formatter.dateFormat = "MM/dd/yyyy"
                 formatter.dateStyle = .full
                 formatter.timeStyle = .full
                 
           
        let results =   realm.objects(ExerciseModel.self).filter("exercise = '\(exercise)'")
        if(results.count <= 0 ) {return [""]}
        
           var resultsArr = Array(results)
        
           resultsArr = resultsArr.sorted(by:
               {
                   
                   return formatter.date(from: $0.date ?? "")?.compare(formatter.date(from: $1.date ?? "")!) == .orderedDescending
                    //  $0.date.compare($1.date) == .orderedDescending
                  })
           
           
        let currDateFirst = Date()
        
        let currDate2 = formatter.string(from: currDateFirst)
        var currDate = formatter.date(from: currDate2)
        currDate = removeTimeStamp(fromDate: currDate!)
        var res = [String]()
           for i in 0..<resultsArr.count
           {
              
                var dateOne =  formatter.date(from: resultsArr[i].date!)
                dateOne = removeTimeStamp(fromDate: dateOne!)
                var currDateCount = i
            if(dateOne == currDate)
                {
                    currLiftsTemp.append(resultsArr[i].setsByReps!)
                    currLiftsObjectsTemp.append(resultsArr[i])
                }
                
                let dateOneCurr = dateOne
                
                
                if(dateOne != currDate)
                {
                    var count = i
                    while(dateOne == dateOneCurr && count + 1 < resultsArr.count)
                    {
                        res.append(resultsArr[count].setsByReps!)
                        count = count + 1
                      
                        
                        dateOne = formatter.date(from: resultsArr[count].date!)
                        dateOne = removeTimeStamp(fromDate: dateOne!)
                    }
                    currLifts = currLiftsTemp
                    currLiftsObjects = currLiftsObjectsTemp
                  
                    return res.reversed()
                   
                }
           }
            
        currLifts = currLiftsTemp
        currLiftsObjects = currLiftsObjectsTemp
                      
              
            return ["No Previous Lifts"]
           
       }
    
    func realmWriteAll(obj: ExerciseModel)
    {
        try! realm.write {
            realm.add(obj)
        
                }
    }
    
    func getCurrentLifts() -> [String]
    {
        if(currLifts.count == 0)
        {
            return [String]()
        }
        else{
            
            return currLifts.reversed()

        }
        
    }
    func getCurrentLiftsObjects() -> [ExerciseModel]
    {
      return  currLiftsObjects.reversed()
    }
    
    public func removeTimeStamp(fromDate: Date) -> Date {
           guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: fromDate)) else {
               fatalError("Failed to strip time from Date object")
           }
           return date
       }
    
    func remove(obj: ExerciseModel)
    {
        try! realm.write {
            realm.delete(obj)
           
        }
    }
}
