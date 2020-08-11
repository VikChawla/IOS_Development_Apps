//
//  Interest.swift
//  ProgressiveOverload
//
//  Created by Vik Chawla on 7/7/20.
//  Copyright © 2020 Vik Chawla. All rights reserved.
//

import Foundation
import UIKit

class Interest
{
    // MARK: - Public API
    var title = ""
    var featuredImage: UIImage
    var color: UIColor
    
    init(title: String, featuredImage: UIImage, color: UIColor)
    {
        self.title = title
        self.featuredImage = featuredImage
        self.color = color
    }
    
    // MARK: - Private
    // dummy data
    static func fetchInterests(isRecommend: Bool) -> [Interest]
    {
        let exerciseListModel = ExerciseListModel()
        let listOfRoutines = exerciseListModel.getExercises()
        var res = [Interest]()
        if isRecommend == false
        {
            let list =  [
            
            Interest(title: "Chest Day", featuredImage: UIImage(named: "f1")!, color: UIColor(red: 63/255.0, green: 71/255.0, blue: 80/255.0, alpha: 0.8)),
            Interest(title: "Leg Day", featuredImage: UIImage(named: "f2")!, color: UIColor(red: 240/255.0, green: 133/255.0, blue: 91/255.0, alpha: 0.8)),
            Interest(title: "Arm Day", featuredImage: UIImage(named: "f3")!, color: UIColor(red: 105/255.0, green: 80/255.0, blue: 227/255.0, alpha: 0.8)),
            Interest(title: "Back Day", featuredImage: UIImage(named: "f4")!, color: UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 0.8)),
            
            Interest(title: "Forearm Day", featuredImage: UIImage(named: "f5")!, color: UIColor(red: 245/255.0, green: 62/255.0, blue: 40/255.0, alpha: 0.8)),
            Interest(title: "Traps/Bicep/Glutes Day", featuredImage: UIImage(named: "f6")!, color: UIColor(red: 103/255.0, green: 217/255.0, blue: 87/255.0, alpha: 0.8)),
            Interest(title: "UpperBody Power Day", featuredImage: UIImage(named: "f7")!, color: UIColor(red: 63/255.0, green: 71/255.0, blue: 80/255.0, alpha: 0.8)),
            Interest(title: "LowerBody Hypertrophy Day", featuredImage: UIImage(named: "f8")!, color: UIColor(red: 240/255.0, green: 133/255.0, blue: 91/255.0, alpha: 0.8)),
            Interest(title: "UpperBody Power Day", featuredImage: UIImage(named: "f7")!, color: UIColor(red: 105/255.0, green: 80/255.0, blue: 227/255.0, alpha: 0.8)),
            Interest(title: "LowerBody Hypertrophy Day", featuredImage: UIImage(named: "f8")!, color: UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 0.8)),
        ]
            for i in 0..<listOfRoutines.count
            {
               
                    list[i].title = listOfRoutines[i].name ?? " "
                    res.append(list[i])

            }
            return res
        }
        
        else{
            return [
            Interest(title: "Beginner Full Body A", featuredImage: UIImage(named: "f1")!, color: UIColor(red: 240/255.0, green: 133/255.0, blue: 91/255.0, alpha: 0.8)),
                       Interest(title: "Beginner Full Body B", featuredImage: UIImage(named: "f1")!, color: UIColor(red: 240/255.0, green: 133/255.0, blue: 91/255.0, alpha: 0.8)),
                       Interest(title: "Intermediate Push", featuredImage: UIImage(named: "f4")!, color: UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 0.8)),
                       Interest(title: "Intermediate  Pull", featuredImage: UIImage(named: "f4")!, color: UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 0.8)),
                       Interest(title: "Intermediate Legs", featuredImage: UIImage(named: "f4")!, color: UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 0.8)),
                       
        ]
        }
    }
}
