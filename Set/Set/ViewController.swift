//
//  ViewController.swift
//  Set
//
//  Created by Vik Chawla on 5/9/20.
//  Copyright © 2020 Vik Chawla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var deck = Deck()
 
    lazy var animator = UIDynamicAnimator(referenceView: view)
    lazy var cardBehavior = CardBehavior(in: animator)
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
        var cards = [Card]()
        for _ in 1...((cardViews.count + 1)/2)
        {
            let card = deck.chooseCard()!
            cards += [card, card]
        }
        // Do any additional setup after loading the view.
        
        for cardView in cardViews{
            cardView.isFaceUp = false
            let card = cards.remove(at: cards.count.arc4random)
            cardView.rank = card.rank.rawValue
            cardView.suit = card.suit.rawValue
            cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flipCard(_:))))
            
            cardBehavior.addItem(cardView)
        }
    }
    private var faceUpCards: [cardView] {
        return cardViews.filter {$0.isFaceUp && !$0.isHidden}
    }
    
    private var faceUpCardsMatch: Bool{
        return faceUpCards.count == 2 && faceUpCards[0].rank == faceUpCards[1].rank && faceUpCards[0].suit == faceUpCards[0].suit
    }
    
    
    @objc func flipCard(_ recog: UITapGestureRecognizer)
    {
        switch recog.state {
        case .ended:
            if let viewOfCard = recog.view as? cardView, faceUpCards.count < 2
            {
               
                UIView.transition(with: viewOfCard, duration: 0.5, options: [.transitionFlipFromTop], animations: {viewOfCard.isFaceUp = !viewOfCard.isFaceUp},
                                  completion: {
                                    finished in
                                    if self.faceUpCardsMatch
                                    {
                                        self.faceUpCards.forEach{viewOfCard in
                                            UIView.transition(with: viewOfCard, duration: 1.0, options:[]
                                                , animations: {
                                                    self.faceUpCards.forEach{
                                                        $0.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
                                                    }
                                                },
                                                  completion: { position in
                                                    UIView.transition(with: viewOfCard, duration: 1.0,
                                                        options:[],
                                                        animations: {
                                                            self.faceUpCards.forEach{                                     $0.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
                                                                $0.alpha = 0
                                                            }
                                                            
                                                    }
                                            )
                                                    
                                        }
                                                    
                                                    )
                                                    
                                                    
                                            }
                                            
                                            
                                        }
                })
            }
            else if self.faceUpCards.count == 2
                  {
                    self.faceUpCards.forEach{viewOfCard in
                      UIView.transition(with: viewOfCard, duration: 1.0, options: [.transitionFlipFromTop], animations: {viewOfCard.isFaceUp = false})
                        }
                                                              
                    }
                
            
            
        default:
            break
            
        }
    }
    
    
    @IBOutlet var cardViews: [cardView]!
    
    @IBOutlet var cardView: cardView!
    {
        didSet
        {
             
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
            swipe.direction  = [.right, .left]
            cardView.addGestureRecognizer(swipe)
            let pinch = UIPinchGestureRecognizer(target: cardView, action: #selector(cardView.pinchFaceCard(recognized:)))
            cardView.addGestureRecognizer(pinch)
            
        }
    }
    
    @IBAction func tapToFlip(_ sender: UITapGestureRecognizer) {
        cardView.isFaceUp = !cardView.isFaceUp
    }
    @objc func nextCard()
    {
        if let card  = deck.chooseCard()
        {
            cardView.rank  = card.rank.rawValue
            cardView.suit = card.suit.rawValue
        }
    }
    

}

extension Float {
    var random: Float{
        return Float(arc4random_uniform(UInt32(self)))
    }
}
