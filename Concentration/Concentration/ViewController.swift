//
//  ViewController.swift
//  Concentration
//
//  Created by Vik Chawla on 4/29/20.
//  Copyright © 2020 Vik Chawla. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    lazy var  game = Concentration(pairsOfCards: (cards.count + 1)/2)
    
    var counter = 0
    {
        didSet{
            updateLabel()
           
        }
    }
    
    private func updateLabel()
    {
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 50),NSAttributedString.Key.foregroundColor: UIColor.systemPurple ]
                   let attributedString = NSAttributedString(string: "Flips: \(counter)", attributes:attributes)
                   flipCounter.attributedText = attributedString
    }
    @IBOutlet var cards: [UIButton]!
    
    @IBOutlet weak var flipCounter: UILabel!
    {
        didSet{
            updateLabel()
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton)
    {
        counter = counter + 1
        if let cardNumber = cards.firstIndex(of: sender)
        {
           // cards[cardNumber].setTitle(emojis[cardNumber], for: UIControl.State.normal)
            // flip(withEmoji: emojis[cardNumber], on: sender)
            //chooseCard(
            
            game.chooseCard(at: cardNumber)
            updateViewFromControler()
            
        }
        else{
            print("nope")
        }
    
        
    
        
    }
    
    @IBAction func newGame(_ sender: UIButton)
    {
        

        
        game.newGame()
        counter = 0
        updateViewFromControler()
        
    }
    
    
    func updateViewFromControler()
    {
        if(cards != nil)
        {
            
        
            for i in cards.indices
            {
                let card = cards[i]
                let gameCard = game.cards[i]
                
                if(gameCard.isFaceUp)
                {
                    card.setTitle(emojiChooser(for: gameCard), for: UIControl.State.normal)
                                   card.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                   
                }
                else
                {
                    card.setTitle("", for: UIControl.State.normal)
                    
                    card.backgroundColor = gameCard.isMatched ? #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 0): UIColor.systemPurple

                                  
                }
                
                
            }
        }
    }
    var theme: [String] = ["🥂", "🤯", "🍻", "🚬", "🍾", "🥃", "💅🏽", "👑"]
    
    

    var emoji = [Int: String]()
    
    func emojiChooser(for card: Card) -> String
    {
       
            if emoji[card.identifier] == nil, theme.count > 0
            {
                let randomIndex = Int(arc4random_uniform(UInt32(theme.count)))
                emoji[card.identifier] = theme.remove(at:randomIndex)
            }
       

       
        return emoji[card.identifier] ?? "no emoji"
       
        
    }
    
    
}

