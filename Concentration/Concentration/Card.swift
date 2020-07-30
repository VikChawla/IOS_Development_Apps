//
//  Card.swift
//  Concentration
//
//  Created by Vik Chawla on 4/30/20.
//  Copyright © 2020 Vik Chawla. All rights reserved.
//

import Foundation

struct Card
{
    var isMatched = false
    var identifier: Int
    var isFaceUp = false
    
    static var currentIdent = 0
   // static var indent = currentIdent + 1
    static func getIdentifier() -> Int
    {
        currentIdent = currentIdent + 1
        return currentIdent
    }
    
    
    
    init()
    {
        self.identifier  =  Card.getIdentifier()
        
    }
    
    
}
