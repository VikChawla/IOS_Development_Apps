//
//  LiftingViewController.swift
//  ProgressiveOverload
//
//  Created by Vik Chawla on 6/22/20.
//  Copyright © 2020 Vik Chawla. All rights reserved.
//

import UIKit

class LiftingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
   var setsByReps = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return setsByReps.count
    }
    var counter = 1
    var count: [Int] = []
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if let lbl = cell?.contentView.viewWithTag(101) as? UILabel{
            lbl.text = setsByReps[indexPath.row]
        }
        if let lbl2 = cell?.contentView.viewWithTag(103) as? UILabel{
          //  lbl2.text = String(setsByReps.count)
            count.append(counter)
            
            lbl2.text = String(count.count)
            counter += 1
               }
        if let btnDelete = cell?.contentView.viewWithTag(102)  as? UIButton {
            btnDelete.addTarget(self, action: #selector(deleteRow(_ :)), for: .touchUpOutside)
        }
        return cell!
    }
    
    @IBOutlet weak var weightText: UITextField!
    
    @IBOutlet weak var repsText: UITextField!
    
    @IBAction func showAnalysis(_ sender: Any)
    {
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
       {
           weightText.resignFirstResponder()
           repsText.resignFirstResponder()
    }
    @IBAction func addRow(_ sender: Any)
    {
        var scheme = "0"
        if weightText.text != "", repsText.text != ""{
            scheme = weightText.text! + " x " + repsText.text!
        }
        setsByReps.insert(scheme, at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .bottom)
        
    }
    
    func tableView(_tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 196.0
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //let important = (at: indexPath)
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
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

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        liftNamee.text = exerciseName
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
   
    var exerciseName = ""
   
    
    @IBOutlet weak var liftNamee: UILabel!
        
    
    @IBOutlet weak var tableView: UITableView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
