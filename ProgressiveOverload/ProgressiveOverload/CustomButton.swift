//
//  CustomButton.swift
//  ProgressiveOverload
//
//  Created by Vik Chawla on 7/6/20.
//  Copyright © 2020 Vik Chawla. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    
    func setupButton() {
        setShadow()
        setTitleColor(UIColor(red: 0/255.0, green: 122/255.0, blue: 255/255.0, alpha: 1.0), for: .normal)
        
        backgroundColor      = #colorLiteral(red: 0.929725945, green: 0.9298816919, blue: 0.9297055006, alpha: 1)
        titleLabel?.font     = UIFont(name: "Avenir Black", size: 18)
        layer.cornerRadius   = 25
        layer.borderWidth    = 1.0
        layer.borderColor    = UIColor.darkGray.cgColor
    }
    
    
    private func setShadow() {
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowOffset  = CGSize(width: 0.0, height: 6.0)
        layer.shadowRadius  = 8
        layer.shadowOpacity = 0.2
        clipsToBounds       = true
        layer.masksToBounds = false
    }
    
    
    func shake() {
        let shake           = CABasicAnimation(keyPath: "position")
        shake.duration      = 0.1
        shake.repeatCount   = 2
        shake.autoreverses  = true
        
        let fromPoint       = CGPoint(x: center.x - 8, y: center.y)
        let fromValue       = NSValue(cgPoint: fromPoint)
        
        let toPoint         = CGPoint(x: center.x + 8, y: center.y)
        let toValue         = NSValue(cgPoint: toPoint)
        
        shake.fromValue     = fromValue
        shake.toValue       = toValue
        
        layer.add(shake, forKey: "position")
    }
}
