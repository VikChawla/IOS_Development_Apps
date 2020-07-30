//
//  Deck.swift
//  Set
//
//  Created by Vik Chawla on 5/9/20.
//  Copyright © 2020 Vik Chawla. All rights reserved.
//

import Foundation

struct Deck
{
    var deck = [Card]()
    
    
    init() {
        
   
        for i in Card.Suit.allSuits
        {
            for j in Card.Rank.allRanks
            {
                let addCard = Card.init(suit: i, rank: j)
                deck.append(addCard)
            }
        }
        
    }
    
  mutating func chooseCard() -> Card?
   {
        if(deck.count > 0)
        {
            return deck.remove(at:  deck.count.arc4random)
        
        }
        return nil
    }
    
}

extension Int {
    var arc4random: Int{
        return Int(arc4random_uniform(UInt32(self)))
    }
}

extension Float {
    var arc4random: Float{
        return Float(arc4random_uniform(UInt32(self)))
    }
}
