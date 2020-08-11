//
//  WorkouitsCollectionViewCell.swift
//  ProgressiveOverload
//
//  Created by Vik Chawla on 7/6/20.
//  Copyright © 2020 Vik Chawla. All rights reserved.
//

import UIKit
protocol CustomCellUpdater: class { // the name of the protocol you can put any
    func updateTableView()
}
class WorkouitsCollectionViewCell: UICollectionViewCell
{
    
    weak var delegate: CustomCellUpdater?
    @IBOutlet weak var featuredImageView: UIImageView!
    
    @IBOutlet weak var interestTitleLabel: UILabel!
    @IBOutlet weak var backgroundColorView: UIView!
    
    @IBOutlet weak var backgroundColorView2: UIVisualEffectView!{
        didSet{
            backgroundColorView2.layer.cornerRadius = backgroundColorView2.bounds.width/2.0
            backgroundColorView2.layer.masksToBounds = true
        }
    }
    var exerciseList = ExerciseListModel()
    var interest: Interest? {
        didSet{
            self.updateUI()
           
        }
    }
    private func updateUI()
    {
        if let interest = interest {
            featuredImageView.image = interest.featuredImage
            interestTitleLabel.text = interest.title
            backgroundColorView.backgroundColor = interest.color
        }
        else{
            featuredImageView.image = nil
            interestTitleLabel.text = nil
            backgroundColorView.backgroundColor = nil
        }
        
    }
    @IBOutlet weak var deleteButtonBackgroundView: UIVisualEffectView!{
        didSet{
            deleteButtonBackgroundView.layer.cornerRadius = deleteButtonBackgroundView.bounds.width/2.0
                              deleteButtonBackgroundView.layer.masksToBounds = true
        }
    }
    
    @IBAction func clickedDeleteCell(_ sender: Any)
    {
        let alert = UIAlertController(title: "Delete \(interestTitleLabel.text!)? 😲", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            self.exerciseList.removeRoutine(name: self.interestTitleLabel.text!)
            self.delegate?.updateTableView()
          }))
       UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func clickedInfo(_ sender: Any)
    {
        let alert = UIAlertController(title: "💪 \(interestTitleLabel.text!) 💪 ", message: correctMessage(routineName: interestTitleLabel.text!), preferredStyle: .alert)
        
         alert.addAction(UIAlertAction(title: "Sounds Good!", style: .default, handler: { (UIAlertAction) in
             
           }))
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    
    override func layoutSubviews()
    {
        
            super.layoutSubviews()
            self.layer.cornerRadius = 3.0
            layer.shadowRadius = 2
            layer.shadowOpacity = 0.8
            layer.shadowOffset = CGSize(width: 5, height: 10)
            self.clipsToBounds = false
            
       
    }
    
    func correctMessage(routineName: String) -> String
    {
       if routineName == "Beginner Full Body A"
             {
                 return "\n\n Based off of a variation of GSLP, Starting Strength, and Strong Lifts 5x5 \n\n Monday: Routine A\n Wed: Routine B\nFriday: Routine A\n\n Start very light\nAdd 5 pounds every lifting session to upper body lifts\nAdd 10 pounds every lifting session for lower body\n1x5 for deadlift\n3x5 for compounds\n8-12 for isolations (curls/push-downs) "
             }
             
              else if routineName == "Beginner Full Body B"
              {
                 return  "\n\n Based off of a variation of GSLP, Starting Strength, and Strong Lifts 5x5 \n\n Monday: Routine A\n Wed: Routine B\nFriday: Routine A\n\n Start very light\nAdd 5 pounds every lifting session to upper body lifts\nAdd 10 pounds every lifting session for lower body\n1x5 for deadlift\n3x5 for compounds\n8-12 for isolations (curls/push-downs) "
              }
              else if routineName == "Intermediate Push"
              {
               return "\n\n Based off of a variation of Coolcicada's and Jeff Nipards PPL \n\n 3x4-6 for big compounds\n3x8-12 for isolations"
              }
              else if routineName == "Intermediate  Pull"
              {
                  return "\n\n Based off of a variation of Coolcicada's and Jeff Nipards PPL \n\n 1x5 for Deadlift\n3x4-6 for big compounds\n3x8-12 for isolations"
              }
              
              else if routineName == "Intermediate Legs"
              {
                 return "\n\n Based off of a variation of Coolcicada's and Jeff Nipards PPL \n\n3x4-6 for big compounds\n3x8-12 for isolations"
              }
              return "rip"
    }
}
