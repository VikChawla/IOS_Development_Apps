//
//  RoutineTableViewCell2.swift
//  ProgressiveOverload
//
//  Created by Vik Chawla on 7/16/20.
//  Copyright © 2020 Vik Chawla. All rights reserved.
//

import UIKit

class RoutineTableViewCell2: UITableViewCell {

    override func awakeFromNib()
    {
        super.awakeFromNib()
       
        // Initialization code
    }
    
  
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
      
    }
   
    @IBOutlet weak var previousLabel: UILabel!
   
    var exerciseName = ""
  
    @IBOutlet weak var setNumberLabel: UILabel!
    
    
    var setsbyReps  = ""
    
    let newLift = ExerciseModel()
    @IBOutlet weak var todayLabel: UILabel!
    {
     didSet{
       
          let date = Date()
          let formatter = DateFormatter()
          formatter.timeZone = .current
          formatter.locale = .current
          formatter.dateFormat = "MM/dd/yyyy"
        formatter.dateStyle = .full
        formatter.timeStyle = .full
        let stringOfDate = formatter.string(from: date)
       
        
           
            
        }
    }
    
   
        
        
        
       
       
        
   
    
    
   

}
