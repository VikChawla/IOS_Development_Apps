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
   var exerciseListModel = ExerciseListModel()

    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.reloadData()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var timerDisplayed = 0
    var profileChosenTimer = Int()
    var timer = Timer()
    var timerRunning = true
    @IBOutlet var label: UILabel!
    
    
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
            if #available(iOS 13.0, *) {
                timerButton.setImage(UIImage(named: "SF_timer-1"), for: [])
            } else {
                timerButton.setImage(UIImage(named: "SF_timer-1"), for: .normal)
            }
        }
    }
    
    @objc func fireTimer()
    {
        
        timerDisplayed += 1
        timerButton.setImage(nil, for: [])
        timerButton.setTitle(toDisplay(currVal: timerDisplayed, chosenTime: profileChosenTimer), for: [])
        timerButton.setTitleColor(#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), for: [])
     
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
       
        var scheme = "0"
        if weightText.text != "", repsText.text != ""{
            scheme = weightText.text! + " x " + repsText.text!
        }
        
      //  prevLifts.insert("", at: prevLifts.count)
        setsByReps.insert(scheme, at: setsByReps.count)
        let exerciseModel = ExerciseModel()
        exerciseModel.setDatetoCurr()
        exerciseModel.exercise = label.text!
        exerciseModel.setsByReps = scheme
       
        routineModel.realmWriteAll(obj: exerciseModel)
        /*
        if(setsByReps.count == prevLifts.count)
        {
             tableView.insertRows(at: [IndexPath(row: max(setsByReps.count, prevLifts.count) - 1, section: 0)], with: .automatic)
        }
 */
        self.tableView.reloadData()
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
    
   
    return max(prevLifts.count, setsByReps.count)
      }
    
    
      
    
    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
      {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")// as! RoutineTableViewCell2
        cell?.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)//.systemGray6
        if let lbl = cell?.contentView.viewWithTag(101) as? UILabel{
            if (indexPath.row < setsByReps.count)
            {
            
                lbl.text = setsByReps[indexPath.row]
                lbl.font = UIFont(name: "Avenir Light" , size: 17)
            }
            else{
            
                lbl.text = ""
            }
        }
        
        if let lbl2 = cell?.contentView.viewWithTag(103) as? UILabel{
            lbl2.text = String(indexPath.row + 1) + "."
             lbl2.font = UIFont(name: "Avenir Light" , size: 17)
        }
        
        if let lbl3 = cell?.contentView.viewWithTag(102) as? UILabel{
            if(indexPath.row < prevLifts.count)
            {
                 lbl3.text = prevLifts[indexPath.row]
                 lbl3.font = UIFont(name: "Avenir Light" , size: 17)
            }
           else
            {
                lbl3.text = ""
            }
        }
  
          
                    
              
       
       
                    
              
  
        return cell!
      }
    
    
    /*
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
    
   
    */
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        //routineModel.findPrevious(exercise: label.text!)
      
        if setsByReps.count <= 0 || indexPath.row >= setsByReps.count {
            return false
        }
        else{
            return true
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        guard editingStyle == .delete else {return}
      
        routineModel.findPrevious(exercise: label.text!, prevNum: 1)
       var listOfObjects =  routineModel.getCurrentLiftsObjects()
      
            setsByReps.remove(at: indexPath.row)
           // prevLifts.remove(at: prevLifts.count - 1 )
            let deletedSet = listOfObjects.remove(at: indexPath.row)
            routineModel.remove(obj: deletedSet )
            //tableView.deleteRows(at: [indexPath], with: .automatic)
        
       
        tableView.reloadData()
    }
    
    var prevCounter = 1
    var prevPrevVals = [String]()
    @IBOutlet weak var extraPrevButton: UIButton!
        
     /*
    @IBAction func findExtraPrev(_ sender: Any)
    {
        prevCounter = prevCounter + 1
        prevPrevVals = routineModel.findPrevious(exercise: label.text!,prevNum: prevCounter)!
            if(prevPrevVals.first == "")
            {
                extraPrevButton.setImage(UIImage(systemName: "arrowshape.turn.up.left"), for: .normal)
            }
            else{
                extraPrevButton.setImage(UIImage(systemName:  "arrowshape.turn.up.left.fill"), for: .normal)
            }
        
        
        prevLifts = prevPrevVals
        tableView.reloadData()
        
    }
    */
    
    
    
    
}
