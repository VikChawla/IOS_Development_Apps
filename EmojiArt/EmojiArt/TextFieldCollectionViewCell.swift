//
//  TextFieldCollectionViewCell.swift
//  EmojiArt
//
//  Created by Vik Chawla on 6/6/20.
//  Copyright © 2020 Vik Chawla. All rights reserved.
//

import UIKit

class TextFieldCollectionViewCell: UICollectionViewCell, UITextFieldDelegate {
    
    
    @IBOutlet weak var textField: UITextField!{
        didSet{
            textField.delegate = self
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
