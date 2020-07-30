//
//  ExerciseModel.swift
//  ProgressiveOverload
//
//  Created by Vik Chawla on 7/22/20.
//  Copyright © 2020 Vik Chawla. All rights reserved.
//

import Foundation
import RealmSwift

class ExerciseModel: Object {
    @objc dynamic var exercise: String?
    @objc dynamic var date: String?
    @objc dynamic var setsByReps: String?
   
    /*
    override required init(exercise: String, date: String, setsByReps: [String])
    {
        self.exercise = exercise
        self.date = date
        self.setsByReps = setsByReps
    }
    */
    override required init() {
        //fatalError("init() has not been implemented")
    }
    
    func setDatetoCurr(){
       let formatter = DateFormatter()
       formatter.timeZone = .current
       formatter.locale = .current
       formatter.dateFormat = "MM/dd/yyyy"
       formatter.dateStyle = .full
       formatter.timeStyle = .full
      let date = Date()
        self.date = formatter.string(from: date)
    }
    
    
    
}
