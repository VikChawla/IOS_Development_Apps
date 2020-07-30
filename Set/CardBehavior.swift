//
//  CardBehavior.swift
//  Set
//
//  Created by Vik Chawla on 5/29/20.
//  Copyright © 2020 Vik Chawla. All rights reserved.
//

import UIKit

class CardBehavior: UIDynamicBehavior
{
    convenience init(in animator: UIDynamicAnimator)
    {
        self.init()
        animator.addBehavior(self)
    }
  //  lazy var animator = UIDynamicAnimator(referenceView: view)
    lazy var collisionBehavior: UICollisionBehavior =
        {
            let behavior = UICollisionBehavior()
            behavior.translatesReferenceBoundsIntoBoundary = true
           // animator.addBehavior(behavior)
            return behavior
        }()
    
    lazy var itemBehavior: UIDynamicItemBehavior = {
       let behavior = UIDynamicItemBehavior()
        behavior.allowsRotation = false
        behavior.elasticity = 1.0
        behavior.resistance = 0
    //    animator.addBehavior(behavior)
        return behavior
    }()
    
    private func push(_ item: UIDynamicItem)
    {
        let push =  UIPushBehavior(items:[item], mode: .instantaneous)
        push.angle = 1.0
        push.magnitude = 2.0
        push.action = { [unowned push, weak self] in
            self?.removeChildBehavior(push) }
        
        addChildBehavior(push)
        
        
    }
    func addItem( _ item: UIDynamicItem)
    {
        
        itemBehavior.addItem(item)
        collisionBehavior.addItem(item)
        push(item)
    }
    func removeItem(_ item: UIDynamicItem)
    {
        itemBehavior.removeItem(item)
               collisionBehavior.removeItem(item)
            
    }


    override init(){
        super.init()
        addChildBehavior(collisionBehavior)
        addChildBehavior(itemBehavior)
        
    }
    
}
