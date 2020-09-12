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
    
    func findPrevious(exercise: String, prevNum: Int ) -> [String]?
       {
        // print(Realm.Configuration.defaultConfiguration.fileURL)
        
        var currLiftsTemp = [String]()
        var currLiftsObjectsTemp = [ExerciseModel]()
        
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = .current
        formatter.dateStyle = .full
        formatter.timeStyle = .full
        
        let formatterDate = DateFormatter()
        formatterDate.timeZone = .current
        formatterDate.locale = .current
                   //formatter.dateFormat = "y-MM-dd H:m:ss.SSSS"//"y-MM-dd H:m:ss.SSSS"//"MM/dd/yy
        
        formatterDate.dateStyle = .full
        
        
        
           
        var results =   realm.objects(ExerciseModel.self).filter("exercise = '\(exercise)'")
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
      //  for i in 0..<prevNum
       // {
        //var resLoop = [String]()
           for i in 0..<resultsArr.count
           {
              
                var dateOne =  formatter.date(from: resultsArr[i].date!)
                dateOne = removeTimeStamp(fromDate: dateOne!)
                //print(dateOne)
                //print(currDate)
                
                if(dateOne == currDate)
                {
                    currLiftsTemp.append(resultsArr[i].setsByReps!)
                    currLiftsObjectsTemp.append(resultsArr[i])
                    
                }
                
                let dateOneCurr = dateOne
               
            
                
                
           
                    if(dateOne != currDate)
                    {
                        var count = i
                         
                        while(dateOne == dateOneCurr && count < resultsArr.count)
                        {
                            res.append(resultsArr[count].setsByReps!)
                         
                          
                            if(count + 1 < resultsArr.count){
                                count = count + 1
                                dateOne = formatter.date(from: resultsArr[count].date!)
                                 dateOne = removeTimeStamp(fromDate: dateOne!)
                            }
                            else{
                                break
                            }
                             
                           
                        }
                        
                        currLifts = currLiftsTemp
                        currLiftsObjects = currLiftsObjectsTemp
                       
                     //   print(res.reversed())
                        return res.reversed()
                        //break
                    }
                    
            
           
           }
           
           
        
        currLifts = currLiftsTemp
        currLiftsObjects = currLiftsObjectsTemp
            return [""]
        
       // return res.reversed()

           
       }
    
    func findCurrent(exercise: String) -> [String]
    {
        let formatterDate = DateFormatter()
        formatterDate.timeZone = .current
        formatterDate.locale = .current
        formatterDate.dateStyle = .full
        
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = .current
        formatter.dateStyle = .full
        formatter.timeStyle = .full
        
        var results =   realm.objects(ExerciseModel.self).filter("exercise = '\(exercise)'")
        let todaysDate = Date()
        let todaysDate2 = removeTimeStamp(fromDate: todaysDate)
        let todaysDateString = formatterDate.string(from: todaysDate2)
        print(todaysDateString)
        results = results.filter("date CONTAINS '\(todaysDateString)'")
        var resultsArr = Array(results)
        resultsArr = resultsArr.sorted(by:
        {
            return formatter.date(from: $0.date ?? "")?.compare(formatter.date(from: $1.date ?? "")!) == .orderedDescending
        
        })
        for i in 0..<resultsArr.count{
            currLifts.append(resultsArr[i].setsByReps!)
        }
        
        return currLifts.reversed()
    }
    
    
    func findPreviousButton(exercise: String, prevNum: Int )
    {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = .current
                          //formatter.dateFormat = "y-MM-dd H:m:ss.SSSS"//"y-MM-dd H:m:ss.SSSS"//"MM/dd/yy
               
        formatter.dateStyle = .full
        formatter.timeStyle = .full
        
        let results =   realm.objects(ExerciseModel.self).filter("exercise = '\(exercise)'")
        
       // if(results.count <= 0 ) //{return [""]}
        var counter = 0;
        
        
       
        while(counter != prevNum)
        {
            
        }
        
        
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
