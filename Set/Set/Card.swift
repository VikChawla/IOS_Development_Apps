//
//  Card.swift
//  Set
//
//  Created by Vik Chawla on 5/9/20.
//  Copyright © 2020 Vik Chawla. All rights reserved.
//

import Foundation

struct Card: CustomStringConvertible {
    var description: String {
        return "\(suit), \(rank)"
    }
    var suit : Suit
    var rank : Rank
    
    enum Suit: String
    {
        case hearts = "♥"
        case clubs = "♣"
        case diamonds = "♦"
        case spades = "♠"
    
   static var allSuits = [Suit.hearts, .clubs, .diamonds, .spades]
    }
    
    enum Rank: Int{
        case ace = 1
        case two = 2
        case three = 3
        case four = 4
        case five = 5
        case six = 6
        case seven = 7
        case eight = 8
        case nine = 9
        case ten = 10
        case jack = 11
        case queen = 12
        case king  = 13
        
        
        static var allRanks = [Rank.ace, .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .jack, .queen,.king]
        
    }
    
}
