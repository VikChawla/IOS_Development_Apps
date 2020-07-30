//
//  ViewController.swift
//  ProgressiveOverload
//
//  Created by Vik Chawla on 6/16/20.
//  Copyright © 2020 Vik Chawla. All rights reserved.
//

import UIKit
import SideMenu

class ViewController: UIViewController {
 var menu: SideMenuNavigationController?
    override func viewDidLoad() {
        super.viewDidLoad()
        weightTextField.delegate = self
        repsTextField.delegate = self
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: true)
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    
    @IBAction func didTapMenu(){
        present(menu!, animated: true)
    }
   
    
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var repsTextField: UITextField!
    
    
    @IBOutlet weak var maxLifts: UITextView!
    
    func textFieldDidEndEditing(_ textField: UITextField)
      {
          print("done edittinginasdinasodia")
          
      }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        weightTextField.resignFirstResponder()
        repsTextField.resignFirstResponder()
        let model = calculationModel(weightGiven: Int(weightTextField.text ?? "1") ?? 1, repsGiven: Int(repsTextField.text ?? "1") ?? 1)
        let listOfMaxes = model.calculatePotentials()
        maxLifts.text = printMaxes(arr: listOfMaxes)
        //"Your Max is: \(listOfMaxes)\nsad and the size is \n\(listOfMaxes.count)"
       // maxLifts.text = "Your Max is: \(calculationModel.init(weightGiven: Int(weightTextField.text!)!, repsGiven: //Int(repsTextField.text!)!).calculateMax())"
    }
  
    func printMaxes(arr : [Int]) -> String
  {
    var res = ""
    var count = 0
    var everyThird = 1
    
    for i in arr
    {
       
        var toAppend = ""
        if everyThird  >= 2, i >= 10
        {
            toAppend = "    " + String(i) + "                "
            everyThird = 0
            print(i)
        }
        else if everyThird >= 2
        {
            everyThird = 0
            toAppend = "     " + String(i) + "                "
            print(String(i) + "idk")
        }
        else{
            toAppend = "     " + String(i) + "                "
            everyThird += 1
            print(String(i) + "fail")
        }
        
        
        res.append(toAppend)
        count += 1
        if( count == 3)
        {
            res.append("\n")
            count = 0
        }
        
        
    }
    
    return res
    
  }
    
    
    
    
 
   
    

}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
             textField.resignFirstResponder()
             return true
         }
    
}


class MenuListController: UITableViewController{
    
    
    var items = ["PotentialMax", "Statistics"]
    
    
   override func viewDidLoad() {
        super.viewDidLoad()
    tableView.backgroundColor  = #colorLiteral(red: 0.8998979404, green: 0.8998979404, blue: 0.8998979404, alpha: 1)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        cell.backgroundColor = #colorLiteral(red: 0.9303181153, green: 0.9303181153, blue: 0.9303181153, alpha: 1)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     //  tableView.deselectRow(at: indexPath, animated: true)
      if( items[indexPath.row] == "Statistics")
      {
          tableView.deselectRow(at: indexPath, animated: true)
        let storyBoard: UIStoryboard = UIStoryboard(name: "statistics", bundle: nil)
        let balanceViewController = storyBoard.instantiateViewController(withIdentifier: "Statistics") as! StatisticsView
        self.present(balanceViewController, animated: true, completion: nil)

       // self.navigationController?.pushViewController(, animated: true)
    }
        
    }
}
