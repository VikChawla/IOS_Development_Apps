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
            
            Interest(title: "Chest Day", featuredImage: UIImage(named: "workoutStuff")!, color: UIColor(red: 80/255.0, green: 180/255.0, blue: 220/255.0, alpha: 0.8)),
            Interest(title: "Leg Day", featuredImage: UIImage(named: "f11")!, color: UIColor(red: 36/255.0, green: 156/255.0, blue: 212/255.0, alpha: 0.8)),
            Interest(title: "Arm Day", featuredImage: UIImage(named: "f22")!, color: UIColor(red: 115/255.0, green: 193/255.0, blue: 229/255.0, alpha: 0.8)),
            Interest(title: "Back Day", featuredImage: UIImage(named: "f44")!, color: UIColor(red: 158/255.0, green: 213/255.0, blue: 236/255.0, alpha: 0.8)),
            
            Interest(title: "Forearm Day", featuredImage: UIImage(named: "f55")!, color: UIColor(red: 55/255.0, green: 167/255.0, blue: 220/255.0, alpha: 0.8)),
            Interest(title: "Traps/Bicep/Glutes Day", featuredImage: UIImage(named: "f66")!, color: UIColor(red: 69/255.0, green: 172/255.0, blue: 220/255.0, alpha: 0.8)),
            Interest(title: "UpperBody Power Day", featuredImage: UIImage(named: "f77")!, color: UIColor(red: 39/255.0, green: 164/255.0, blue: 212/255.0, alpha: 0.8)),
            Interest(title: "LowerBody Hypertrophy Day", featuredImage: UIImage(named: "f88")!, color: UIColor(red: 52/255.0, green: 164/255.0, blue: 212/255.0, alpha: 0.8)),
            Interest(title: "UpperBody Power Day", featuredImage: UIImage(named: "f99")!, color: UIColor(red: 44/255.0, green: 156/255.0, blue: 212/255.0, alpha: 0.8)),
            Interest(title: "LowerBody Hypertrophy Day", featuredImage: UIImage(named: "f100")!, color: UIColor(red: 69/255.0, green: 172/255.0, blue: 220/255.0, alpha: 0.8)),
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
            Interest(title: "Beginner Full Body A", featuredImage: UIImage(named: "beginner")!, color: UIColor(red: 100/255.0, green: 173/255.0, blue: 255/255.0, alpha: 0.8)),
                       Interest(title: "Beginner Full Body B", featuredImage: UIImage(named: "beginner")!, color: UIColor(red: 100/255.0, green: 173/255.0, blue: 255/255.0, alpha: 0.8)),
                       Interest(title: "Intermediate Push", featuredImage: UIImage(named: "Intermediate")!, color: UIColor(red: 100/255.0, green: 156/255.0, blue: 212/255.0, alpha: 0.8)),
                       Interest(title: "Intermediate  Pull", featuredImage: UIImage(named: "Intermediate")!, color: UIColor(red: 100/255.0, green: 156/255.0, blue: 212/255.0, alpha: 0.8)),
                       Interest(title: "Intermediate Legs", featuredImage: UIImage(named: "Intermediate")!, color: UIColor(red: 100/255.0, green: 156/255.0, blue: 212/255.0, alpha: 0.8)),
                       
        ]
        }
    }
}
