//
//  WorkoutMenueViewController.swift
//  ProgressiveOverload
//
//  Created by Vik Chawla on 7/4/20.
//  Copyright © 2020 Vik Chawla. All rights reserved.
//

import UIKit



class WorkoutMenueViewController: UIViewController
{
    var nextVCTitle = ""
    @IBOutlet weak var collectionView: UICollectionView!
        
     {
        didSet{
            collectionView?.dataSource = self
                  collectionView?.delegate = self
        }
       
    }
    
    @IBOutlet weak var collectionViewRec: UICollectionView!
     {
        didSet{
            collectionViewRec?.dataSource = self
                  collectionViewRec?.delegate = self
        }
       
    }
        
        var interests = Interest.fetchInterests(isRecommend: false)
    var recomendInterests = Interest.fetchInterests(isRecommend: true)
        let cellScaling: CGFloat = 0.6
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
        }
    }

    extension WorkoutMenueViewController : UICollectionViewDataSource
    {
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if collectionView == self.collectionView
            {
                return interests.count
            }
            
            else{
                return recomendInterests.count
            }
        }
        
        
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WorkoutCell", for: indexPath) as! WorkouitsCollectionViewCell
            if collectionView == self.collectionView
            {
                cell.interest = interests[indexPath.row]

            }
            
            if collectionView == self.collectionViewRec
            {
                cell.interest = recomendInterests[indexPath.row]
            }
            
            return cell
        }
        
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let vc = segue.destination as! RoutineViewController
            
            vc.title = nextVCTitle
            
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
        {
            collectionView.reloadData()
            if collectionView == self.collectionView
            {
                nextVCTitle = interests[indexPath.row].title
            }
                       
            if collectionView == self.collectionViewRec
            {
                nextVCTitle = recomendInterests[indexPath.row].title
            }
           
            performSegue(withIdentifier: "showRoutine", sender: self)
            
        }
    }

    extension WorkoutMenueViewController : UIScrollViewDelegate, UICollectionViewDelegate
    {
        func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
        {
            let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
            let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
            
            var offset = targetContentOffset.pointee
            let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
            let roundedIndex = round(index)
            
            offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
            targetContentOffset.pointee = offset
        }
    }

/*
 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WorkoutCell", for: indexPath) as! WorkouitsCollectionViewCell
     
        // cell.interest = interest[indexPath.item]
   
     
         return cell
         /*
         let text =  NSAttributedString(string: prevWorkoutsData[indexPath.item], attributes: [.font:font])
         //workoutCell.theWorkoutLabel.attributedText = text
         print("did something")
          */
     
     
     
 
 }
 */
