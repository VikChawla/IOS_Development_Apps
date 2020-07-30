//
//  WorkoutViewController.swift
//  ProgressiveOverload
//
//  Created by Vik Chawla on 6/22/20.
//  Copyright © 2020 Vik Chawla. All rights reserved.
//

import UIKit

class WorkoutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var searchLifts = [String]()
    var searching = false
    var liftName = "didnt work"

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let lifts = ["Bench", "Squat", "Deadlift", "Overhead Press"]
    
    
    
}

extension WorkoutViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching
        {
            return searchLifts.count
        }
        else{
              return lifts.count
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if searching
        {
             cell?.textLabel?.text = searchLifts[indexPath.row]
        }
        else{
             cell?.textLabel?.text = lifts[indexPath.row]
        }
       
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! LiftingViewController
        vc.exerciseName = liftName
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        liftName = lifts[indexPath.row]
        //let vc = LiftingViewController()
        performSegue(withIdentifier: "showLift", sender: self)
        
     //   navigationController?.pushViewController(vc, animated: true)
    }
}


extension WorkoutViewController: UISearchBarDelegate
{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchLifts = lifts.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching   = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
        searchBar.resignFirstResponder()
        
    }
}
