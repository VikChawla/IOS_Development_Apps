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
        try! realm.write {
            realm.add(obj)
        
            }
    }
    
}
