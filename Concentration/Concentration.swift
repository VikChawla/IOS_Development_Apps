//
//  Concentration.swift
//  Concentration
//
//  Created by Vik Chawla on 4/30/20.
//  Copyright © 2020 Vik Chawla. All rights reserved.
//

import Foundation

class Concentration{
   private(set) var cards = [Card]()
    
    init(pairsOfCards: Int)
    {
        for _ in 1...pairsOfCards
        {
            let card = Card()
            cards.append(card)
            cards.append(card)
           // print(cards)
        }
         
        for i in 0..<cards.count
        {
            let number = cards.count.arc4random
            let temp = cards[i]
            cards[i] = cards[number]
            cards[number] = temp
        }
       
    }
     
    var oneCardIndex: Int?
    {
        get{
            var foundIndex: Int?
            
            for i in cards.indices
            {
                if(cards[i].isFaceUp)
                {
                    if(foundIndex == nil)
                    {
                        foundIndex = i
                    }
                    else
                    {
                        foundIndex = nil
                    }
                }
                
            }
            return foundIndex
        }
        
    }
    
   func chooseCard(at index: Int)
    {
        if !cards[index].isMatched
        {
            if let matchIndex = oneCardIndex, matchIndex != index
            {
                if cards[matchIndex].identifier == cards[index].identifier
                {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                
            }
            
            else{
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                
            }
        }       
            
     }
    
     func newGame()
     {
        for i in cards.indices
        {
            cards[i].isFaceUp = false
            cards[i].isMatched = false
            
            
        }
        
        for i in cards.indices
        {
            let number = cards.count.arc4random
            let temp = cards[i]
            cards[i] = cards[number]
            cards[number] = temp
        }
    }
    
        
       
        
        
}


extension Int {
    var arc4random: Int{
        return Int(arc4random_uniform(UInt32(self)))
    }
}
    
    
    
    
    
    

