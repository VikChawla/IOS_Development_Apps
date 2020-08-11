//
//  ExerciseListModel.swift
//  ProgressiveOverload
//
//  Created by Vik Chawla on 8/4/20.
//  Copyright © 2020 Vik Chawla. All rights reserved.
//

import Foundation
import RealmSwift
class ExerciseListModel
{
    var realm = try! Realm()
    
    
   
    
    
    
    func realmWriteAll(obj: Routine )
    {
         print(Realm.Configuration.defaultConfiguration.fileURL)
        try! realm.write {
            realm.add(obj)
        
            }
    }
    
    func getExercises() -> [Routine]
    {
        let results = realm.objects(Routine.self)
        return Array(results)
    }
    
    func getExerciseList(routineName: String) -> [String]
    {
        if(reccWorkout(routineName: routineName)){
            return getReccWorkoutExerciseList(routineName: routineName)
            
        }
        let results =  realm.objects(Routine.self).filter("name = '\(routineName)'")
        if(results.count <= 0)
        {
            return [String]()
        }
        else{
            let resultsArr = Array(results)
                 return Array(resultsArr[0].exercises)
        }
     
        
        
    }
    
    func addExercise(exercise: String, name:String)
    {
        let objectInRealm = realm.objects(Routine.self).filter("name = '\(name)'")
        print(objectInRealm)
        print("in exerciseModel \(exercise)")
        if(objectInRealm.count > 0)
        {
            print("hit >= 1")
            let obj = objectInRealm.first
            
            try! realm.write{
                
                print("routineexercises")
                obj!.exercises.append(exercise)
                print(obj?.exercises)
            }
        }
        
    }
    
    func removeRoutine(name: String)
    {
        let objectInRealm = realm.objects(Routine.self).filter("name = '\(name)'")
        print(objectInRealm)
        try! realm.write {
            realm.delete(objectInRealm.first!)
           
        }
    }
    func removeExercise(name:String, pos:Int)
    {
        let objectInRealm = realm.objects(Routine.self).filter("name = '\(name)'")
        let obj = objectInRealm.first
        try! realm.write{
            obj?.exercises.remove(at: pos)
        }
    }
    func getRoutine(exerciseName: String) -> Routine
    {
      let results =   realm.objects(Routine.self).filter("name = '\(exerciseName)'")
        if(results.count > 0)
        {
            return results.first!
        }
        
        else{
            let res = Routine()
            res.name = exerciseName
            return res
        }
    }
    
    func reccWorkout(routineName: String) -> Bool
    {
        let list = Interest.fetchInterests(isRecommend: true)
        for i in 0..<list.count
        {
            if list[i].title == routineName {
                return true
            }
        }
        return false
    }
    
    func getReccWorkoutExerciseList(routineName: String) -> [String]
    {
       
       if routineName == "Beginner Full Body A"
       {
            return ["Squat", "Bench Press", "Barbell Row", "Barbell Curls"]
       }
       
        else if routineName == "Beginner Full Body B"
        {
            return ["Deadlift", "Overhead-Press", "Pull-Up", "Tricep-Pushdown"]
        }
        else if routineName == "Intermediate Push"
        {
            return ["Bench Press", "Overhead-Press", "Incline Dumbell Bench", "Lateral-Raises", "Tricep-Pushdowns"]
        }
        else if routineName == "Intermediate  Pull"
        {
            return ["Deadlift", "Barbell-Rows", "Pull-Ups", "Face-Pulls", "Barbell-Curls"]
        }
        
        else if routineName == "Intermediate Legs"
        {
            return ["Squat", "Leg-Press", "Hamstring-Curls", "Calf-Raises"]
        }
        return ["rip"]
    }
}
