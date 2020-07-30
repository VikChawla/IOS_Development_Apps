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
    func findPrevious(exercise: String) -> [String]?
       {
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
          let formatter = DateFormatter()
                   formatter.timeZone = .current
                   formatter.locale = .current
                   formatter.dateFormat = "MM/dd/yyyy"
                 formatter.dateStyle = .full
                 formatter.timeStyle = .full
                 
           print(exercise)
           let results =   realm.objects(ExerciseModel.self).filter("exercise = '\(exercise)'")
        if(results.count <= 0 ) {return [""]}
           print(results.count)
           var resultsArr = Array(results)
           resultsArr = resultsArr.sorted(by:
               {
                   
                   return formatter.date(from: $0.date ?? "")?.compare(formatter.date(from: $1.date ?? "")!) == .orderedDescending
                    //  $0.date.compare($1.date) == .orderedDescending
                  })
           
           
           var currDateFirst = Date()
        
      var currDate2 = formatter.string(from: currDateFirst)
        var currDate = formatter.date(from: currDate2)
        currDate = removeTimeStamp(fromDate: currDate!)
           var previousDate = Date()
           for i in 0..<resultsArr.count - 1
           {
              
               var dateOne =  formatter.date(from: resultsArr[i].date!)
               dateOne = removeTimeStamp(fromDate: dateOne!)
              // print(dateOne)
               var dateTwo =  formatter.date(from: resultsArr[i + 1].date!)
               dateTwo = removeTimeStamp(fromDate: dateTwo!)
            if(dateOne == currDate)
            {
                currLifts.append(resultsArr[i].setsByReps!)
            }
            if(i == resultsArr.count - 1 && dateTwo == currDate)
            {
                currLifts.append(resultsArr[i + 1].setsByReps!)
            }
               if( dateOne!.compare((dateTwo!)) == .orderedDescending )
               {
                   
                   print(dateTwo)
                   print("done?")
                   previousDate = dateTwo!
                   break;
               }
           }
           var res = [String]()
           for i in 0..<resultsArr.count
           {
               var date = formatter.date(from:resultsArr[i].date!)
               date = removeTimeStamp(fromDate: date!)
               if date == previousDate
               {
                   res.append(resultsArr[i].setsByReps!)
               }
               
           }
           print(res.reversed())
           return res.reversed()
              
               
           
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
            return [""]
        }
        else{
            
            return currLifts.reversed()

        }
        
    }
    
    public func removeTimeStamp(fromDate: Date) -> Date {
           guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: fromDate)) else {
               fatalError("Failed to strip time from Date object")
           }
           return date
       }
}
