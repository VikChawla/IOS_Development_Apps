//
//  RoutineViewController.swift
//  ProgressiveOverload
//
//  Created by Vik Chawla on 7/9/20.
//  Copyright © 2020 Vik Chawla. All rights reserved.
//

import UIKit
import RealmSwift

class RoutineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    var exerciseList = ExerciseListModel()
    
  //  var nameArr = ["Bench press", "Incline Dumbell Press", "Calf Raises", "Decline Bench Press", "Chest Flys", "Bench press", "Incline Dumbell Press", "Calf Raises", "Decline Bench Press", "Chest Flys"]
    lazy var nameArr = exerciseList.getExerciseList(routineName: titleOfVC)
    var selectedIndex = -1
    var iscollapse = false
    var titleOfVC = String()
    var selectedTime = 180
    lazy var routine = exerciseList.getRoutine(exerciseName: titleOfVC)
    var isCustom = true
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.delegate = self
                tableView.dataSource = self
           
          adjustLargeTitleSize()
       
        
        
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.selectedIndex == indexPath.row && iscollapse == true{
            return 386
        }
        else{
            return 50
        }
    }
    
    
    @IBAction func addButton(_ sender: Any)
    {
        if(isCustom){
            let alert = UIAlertController(title: "Add Exercise", message: nil, preferredStyle: .alert)
            alert.addTextField {
                (exerciseTF) in exerciseTF.placeholder = "Enter Exercise"
            }
            let action = UIAlertAction(title: "Add", style:.default) {(_) in
                guard let exercise = alert.textFields?.first?.text else{
                    return
                }
                
                self.add(exercise)
                
            }
            let actionCancle = UIAlertAction(title: "Cancle", style: .cancel)
            alert.addAction(actionCancle)
            
            alert.addAction(action)
            present(alert, animated:true)
        }
        
    }
    @IBAction func clickedTimer(_ sender: Any)
    {
        let alert = UIAlertController(title: "Choose Time", message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        createTimePicker()
        let pickerFrame = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 160))
        alert.view.addSubview(pickerFrame)
        pickerFrame.dataSource = self
        pickerFrame.delegate = self
          alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
              alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
              
                self.tableView.reloadData()
                }))
        self.present(alert,animated: true, completion: nil )
       
    }
    
    func add(_ exercise: String)
    {
       
        print(exercise)
        exerciseList.addExercise(exercise: exercise, name: titleOfVC)
        nameArr = exerciseList.getExerciseList(routineName: titleOfVC)
        let index = nameArr.count - 1
        let indexPath = IndexPath(row: index, section:0)
        tableView.insertRows(at: [indexPath], with: .top)
        //routine.exercises.append(exercise)
        
        
        //exerciseList.updateRoutine(routine: routine)
       
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        if self.selectedIndex == indexPath.row && iscollapse == true{
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        
                
        guard editingStyle == .delete else {return}
        print(indexPath.row)
        print(routine.exercises)
        //var exerciseToDelete = Array(routine.exercises)[indexPath.row]
        //routine.exercises.remove(at: indexPath.row)
        //print("asdasd")
        //nameArr.remove(at: indexPath.row)
        
        exerciseList.removeExercise(name: titleOfVC, pos: indexPath.row)
        nameArr = exerciseList.getExerciseList(routineName: titleOfVC)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
          
        
      
    }
 
    @IBOutlet weak var tableView: UITableView!
    
    
  
    
    
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArr.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RoutineTableViewCell
        /*
        cell.exercise.text! = nameArr[indexPath.row]
        cell.imageIMG.image = UIImage(named: "\(imageArr[indexPath.row])")
 */
        
        cell.tableView.cellForRow(at: indexPath)
        cell.label.text = nameArr[indexPath.row]
        cell.profileChosenTimer = selectedTime
        print(nameArr)
        print(nameArr[indexPath.row])
        
        
        return cell
     }
     var prevLifts = [String]()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
          
        tableView.deselectRow(at: indexPath, animated: true)
        if selectedIndex == indexPath.row
        {
            if self.iscollapse == false
            {
                self.iscollapse = true
            }
        
        else{
            self.iscollapse = false
            }
        }
        else{
            self.iscollapse = true
        }
        self.selectedIndex = indexPath.row
        
       
        
        
      tableView.reloadRows(at: [indexPath], with: .automatic)
        let cell = tableView.cellForRow(at: indexPath) as! RoutineTableViewCell
               print("hit here even?")
        cell.prevLifts = cell.routineModel.findPrevious(exercise: nameArr[indexPath.row], prevNum: 1)!
        cell.setsByReps = cell.routineModel.getCurrentLifts()
      
        print(cell.setsByReps)
       
        //cell.
          
    
    }
    
   var textFieldForTime = UITextField()
    
    let times = ["5:00","4:00", "3:00", "2:30", "2:00","1:30", "1:00", "0:30"]
    
    func createTimePicker(){
        let timePicker = UIPickerView()
        timePicker.delegate = self
        textFieldForTime.inputView = timePicker
        
    }
}

extension UIViewController {
  func adjustLargeTitleSize() {
    guard let title = title, #available(iOS 11.0, *) else { return }

    let maxWidth = UIScreen.main.bounds.size.width - 60
    var fontSize = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
    var width = title.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]).width

    while width > maxWidth {
      fontSize -= 1
        width = title.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]).width
    }

    navigationController?.navigationBar.largeTitleTextAttributes =
        [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize)
    ]
  }
}




extension RoutineViewController: UIPickerViewDelegate, UIPickerViewDataSource
{
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        times.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        times[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedTime = calcTime(time: times[row])
        
    }
    
    func calcTime(time: String) -> Int
    {
        print("coming here??")
        if time == "5:00"
        {
            return 300
        }
        else if time == "4:00"
        {
            return 240
        }
        else if time == "3:00"
        {
            return 180
        }
        else if time == "2:30"
        {
            return 150
        }
        else if time == "2:00"
        {
            return 120
        }
        else if time == "1:30"
        {
            return 90
        }
        else if time == "1:00"
        {
            return 60
        }
        else if time == "0:30"
        {
            return 30
        }
        return 180
    }
    
}
