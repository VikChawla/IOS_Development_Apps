//
//  RoutineTableViewCell.swift
//  ProgressiveOverload
//
//  Created by Vik Chawla on 7/9/20.
//  Copyright © 2020 Vik Chawla. All rights reserved.
//

import UIKit

class RoutineTableViewCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate
{
   var routineModel = RoutineModel()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var timerDisplayed = 0
    var profileChosenTimer = 180
    var timer = Timer()
    var timerRunning = true
    @IBOutlet weak var label: UILabel!
    
    
    @IBOutlet weak var timerButton: UIButton!
    

    
    @IBAction func timerAction(_ sender: Any)
    {
        if(timerRunning){
            timerRunning = false
        }
        else{
            timerRunning = true
        }
        
        if(timerRunning == false)
        {
            timerButton.setImage(nil, for: [])
            timerButton.setTitle(toDisplay(currVal: 0, chosenTime: profileChosenTimer), for: []) //edit chosen time when profile made
            timerButton.setTitleColor(#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), for: [])
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        }
        else{
            timer.invalidate()
            timerDisplayed = 0
             timerButton.setTitle(nil, for: [])
             timerButton.setImage(UIImage(systemName: "timer"), for: [])
        }
    }
    
    @objc func fireTimer()
    {
        
        timerDisplayed += 1
        timerButton.setImage(nil, for: [])
        timerButton.setTitle(toDisplay(currVal: timerDisplayed, chosenTime: profileChosenTimer), for: [])
        timerButton.setTitleColor(#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), for: [])
      // print(timerDisplayed)
        if(timerDisplayed == profileChosenTimer)
        {
            timerRunning = false
            timerDisplayed = 0
            timer.invalidate()
        }
    }
    
    //l0l most aids math for this but works somehow
    func toDisplay(currVal: Int, chosenTime:Int) -> String
    {
       
        let time = Double(chosenTime) - 59
        let remaning =  time - Double(currVal)
        let hour = ceil(remaning/60)
        
        let mins = 59 - ((hour * 60) - remaning)
     //   let mins = remaning - (hour * 60)
        var minsFinal = ""
        if(mins < 10 )
        {
            minsFinal = "0" + String(Int(mins))
        }
        else
        {
            minsFinal = String(Int(mins))
            
        }
        
        return String(Int(hour)) + ":" + minsFinal
        
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    {
        didSet{
            tableView.dataSource = self
            tableView.delegate = self
            tableView.bounces = false
            tableView.alwaysBounceVertical = false
          
        }
    }
    var setsByReps = [String]()
    {
        didSet{
                  // self.tableView.reloadData()
                   
                   tableView.reloadData()
               }
    }
   
  //  var cellSetsByReps = [[ExerciseModel.]]
    
    
    @IBOutlet weak var weightText: UITextField!
    
    @IBOutlet weak var repsText: UITextField!
    
    /*
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
        {
            weightText.resignFirstResponder()
            repsText.resignFirstResponder()
     }
 */
    var  prevLifts = [String]()
    
    
    @IBAction func addRow(_ sender: Any)
    {
        //self.tableView.reloadData()
        var scheme = "0"
        if weightText.text != "", repsText.text != ""{
            scheme = weightText.text! + " x " + repsText.text!
        }
        
        prevLifts.insert("", at: prevLifts.count)
        setsByReps.insert(scheme, at: setsByReps.count)
        let exerciseModel = ExerciseModel()
        exerciseModel.setDatetoCurr()
        exerciseModel.exercise = label.text!
        exerciseModel.setsByReps = scheme
        routineModel.realmWriteAll(obj: exerciseModel)
        if(setsByReps.count == prevLifts.count)
        {
             tableView.insertRows(at: [IndexPath(row: max(setsByReps.count, prevLifts.count) - 1, section: 0)], with: .automatic)
        }
       
        repsText.resignFirstResponder()
        
        
    }
    /*
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        repsText.resignFirstResponder()
        weightText.resignFirstResponder()
    }
    */
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
   {
    
    print(max(prevLifts.count, setsByReps.count))
    print("this is count")
  //  return  max(prevLifts.count, setsByReps.count)
    //return prevLifts.count
    return max(prevLifts.count, setsByReps.count)
      }
    
    
      
    
    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
      {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")// as! RoutineTableViewCell2
        cell?.backgroundColor = .systemGray6
        if let lbl = cell?.contentView.viewWithTag(101) as? UILabel{
            if (indexPath.row < setsByReps.count)
            {
                lbl.text = setsByReps[indexPath.row]
            }
            else{
                lbl.text = ""
            }
        }
        
        if let lbl2 = cell?.contentView.viewWithTag(103) as? UILabel{
            lbl2.text = String(indexPath.row + 1) + "."
        }
        
        if let lbl3 = cell?.contentView.viewWithTag(102) as? UILabel{
            if(indexPath.row < prevLifts.count)
            {
                 lbl3.text = prevLifts[indexPath.row]
            }
           else
            {
                lbl3.text = ""
            }
        }
      //    cell.exerciseName = label.text!
        
      //  cell.previousLabel.text = prevLifts[indexPath.row]
          
                    
              
       
        print(label.text! + "sadasdas")
                    
              
      //  cell.setNumberLabel.text = nil
   
  //      cell.setNumberLabel.text = String(indexPath.row + 1) + "."
        
    //    cell.todayLabel.text = nil
     //   cell.todayLabel.text = setsByReps[indexPath.row]
        
      
       // cell.setsbyReps = setsByReps[indexPath.row]
        return cell!
      }
    
    
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction
    {
        let action = UIContextualAction(style: .destructive, title: "Delete") {(action, view, completion) in
            self.setsByReps.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
            self.tableView.reloadData()
        }
        action.image = #imageLiteral(resourceName: "Trash")
        action.backgroundColor = .red
        return action
    }
    
    @objc func deleteRow(_ sender: UIButton)
       {
           let point = sender.convert(CGPoint.zero, to: tableView)
          guard let indexPath = tableView.indexPathForRow(at: point) else
           {
               return
           }
           
           setsByReps.remove(at: indexPath.row)
           
           tableView.deleteRows(at: [indexPath], with: .left)
       }
    
   
    
    
}
