//
//  themeViewController.swift
//  Concentration
//
//  Created by Vik Chawla on 5/28/20.
//  Copyright © 2020 Vik Chawla. All rights reserved.
//

import UIKit

//
//  ThemeViewController.swift
//  Concentration
//
//  Created by Vik Chawla on 5/28/20.
//  Copyright © 2020 Vik Chawla. All rights reserved.
//

import UIKit

class themeViewController: UIViewController, UISplitViewControllerDelegate {

    
    
    let themes = [
        "Party": ["🥂", "🤯", "🍻", "🚬", "🍾", "🥃", "💅🏽", "👑"],
        "Gains" : ["🍗", "🍔", "🥗", "🍳", "🥓", "🍌", "🥦", "💪🏾"],
        "Animals" : ["🐷", "🐽", "🙈", "🐣", "🦄", "🐳", "🐖", "🦃"]
    ]
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool
        {
            if let cvc = secondaryViewController as? ViewController{
                if cvc.theme == nil
                {
                    return true
                }
            }
            return false
        }
       
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "Choose Theme"
        {
            if let button = sender as? UIButton
            {
                let theme = button.currentTitle
                
                if let cvc = segue.destination as? ViewController
                {
                    cvc.theme = themes[theme!] ?? ["", ""]
                   
                }
            }
            
        }
    }

}
