//
//  valuesTextField.swift
//  ProgressiveOverload
//
//  Created by Vik Chawla on 6/16/20.
//  Copyright © 2020 Vik Chawla. All rights reserved.
//

import UIKit

class valuesTextField: UITextField, UITextFieldDelegate{

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        print(12321312)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
  
   
    
    
    
}
