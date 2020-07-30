//
//  calculationModel.swift
//  ProgressiveOverload
//
//  Created by Vik Chawla on 6/16/20.
//  Copyright © 2020 Vik Chawla. All rights reserved.
//

import Foundation

class calculationModel
{
   private var weight = 0
    private var reps = 0
    private var range = 0
    
    init(weightGiven: Int, repsGiven: Int)
    {
        weight = weightGiven
        reps = repsGiven
    }
    
    func calculateMax() -> Int
    {
        let max  = (Double(weight) * Double(reps) * 0.0333 + Double(weight)).rounded()
        return Int(max)
    }
    
    func calcPotentialMax(potentialWeight: Int, potentialReps: Int) -> Int
    {
        let max  = (Double(potentialWeight) * Double(potentialReps) * 0.0333 + Double(potentialWeight)).rounded()
        return Int(max)
    }
    
    func calculatePotentials() -> [Int]
    {
        var res: [Int] = [weight, reps, calculateMax()]
        let currMax = calculateMax()
        for currWeight in 1...weight + weight/2
        {
            for currReps in 2...15
            {
                let potentialMax  = calcPotentialMax(potentialWeight: currWeight, potentialReps: currReps)
                if currWeight%5 == 0,  potentialMax > currMax, potentialMax <= currMax + 20
                {
                    res.append(currWeight)
                    res.append(currReps)
                    res.append(potentialMax)
                    break;
                }
            }
        }
      
        return res
    }

}
