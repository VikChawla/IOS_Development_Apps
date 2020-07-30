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
    
 
    var nameArr = ["Bench press", "Incline Dumbell Press", "Calf Raises", "Decline Bench Press", "Chest Flys", "Bench press", "Incline Dumbell Press", "Calf Raises", "Decline Bench Press", "Chest Flys"]
   
    var selectedIndex = -1
    var iscollapse = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.delegate = self
                tableView.dataSource = self
           
          adjustLargeTitleSize()
        
        
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.selectedIndex == indexPath.row && iscollapse == true{
            return 400
        }
        else{
            return 50
        }
    }
    
    @IBAction func addButton(_ sender: Any)
    {
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
        
        alert.addAction(action)
        present(alert, animated:true)
    }
    
    func add(_ exercise: String)
    {
        let index = 0
        nameArr.insert(exercise, at:index)
        
        let indexPath = IndexPath(row: index, section:0)
        tableView.insertRows(at: [indexPath], with: .top)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       guard editingStyle == .delete else {return}
        nameArr.remove(at: indexPath.row)
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
        
        return cell
     }
     var prevLifts = [String]()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
        cell.prevLifts = cell.routineModel.findPrevious(exercise: nameArr[indexPath.row])!
        cell.setsByReps = cell.routineModel.getCurrentLifts()
       
        //cell.
          
    
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
