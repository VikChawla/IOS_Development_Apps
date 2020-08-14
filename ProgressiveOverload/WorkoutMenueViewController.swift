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
     public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    var nextVCTitle = ""
     var isCustomVC = true
    var exerciseList = ExerciseListModel()
   
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
    @IBAction func clickedNewWorkout(_ sender: Any)
    {
        if(interests.count >= 10)
        {
             let alert = UIAlertController(title: "You don't need more than 10 Routines 🙃\n\nStick to the Fundamentals", message: nil, preferredStyle: .alert)
            
            let actionCancle = UIAlertAction(title: "You're right!", style: .default)
                   alert.addAction(actionCancle)
             present(alert, animated:true)
        }
        else{
            let alert = UIAlertController(title: "Name of Routine", message: nil, preferredStyle: .alert)
            alert.addTextField {
                (routineName) in routineName.placeholder = "Enter Name"
            }
            let action = UIAlertAction(title: "Add", style:.default) {(_) in
                guard var name = alert.textFields?.first?.text else{
                    return
                }
                name = name.replacingOccurrences(of: "\'", with: "").replacingOccurrences(of: "\"", with: "")
                self.nextVCTitle = name
                
                let routineName = Routine()
                routineName.name = name
                self.exerciseList.realmWriteAll(obj: routineName)
                self.interests = Interest.fetchInterests(isRecommend: false)
                self.recomendInterests = Interest.fetchInterests(isRecommend: true)
                self.collectionView.reloadData()
                self.performSegue(withIdentifier: "showRoutine", sender: self)
                
            }
            
            let actionCancle = UIAlertAction(title: "Cancle", style: .cancel)
            alert.addAction(actionCancle)
            
            alert.addAction(action)
            present(alert, animated:true)
        }
        
       
       
    }
    
        var interests = Interest.fetchInterests(isRecommend: false)
    var recomendInterests = Interest.fetchInterests(isRecommend: true)
        let cellScaling: CGFloat = 0.6
        
        override func viewDidLoad()
        {
                        super.viewDidLoad()
            
            
        }
    }

    extension WorkoutMenueViewController : UICollectionViewDataSource,  CustomCellUpdater
    {
        func updateTableView() {
             self.interests = Interest.fetchInterests(isRecommend: false)
           
            self.collectionView.reloadData()
        }
        
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
            cell.delegate = self
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
            vc.titleOfVC = nextVCTitle
            vc.isCustom = isCustomVC
           
            
        }
       
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
        {
            collectionView.reloadData()
            if collectionView == self.collectionView
            {
                nextVCTitle = interests[indexPath.row].title
                isCustomVC = true
            }
                       
            if collectionView == self.collectionViewRec
            {
                nextVCTitle = recomendInterests[indexPath.row].title
                isCustomVC = false
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

