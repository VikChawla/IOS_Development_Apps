//
//  RoutineNavigationControllerViewController.swift
//  ProgressiveOverload
//
//  Created by Vik Chawla on 8/13/20.
//  Copyright © 2020 Vik Chawla. All rights reserved.
//

import UIKit

class RoutineNavigationControllerViewController: UINavigationController {

    override func viewDidLoad()
    {
       
        super.viewDidLoad()
        //self.navigationController?.navigationBar.titleTextAttributes =
        navigationBar.shadowImage = UIImage()
        let navigationFont = UIFont(name: "Avenir Black", size: 40)
        let navigationFontAttributes = [NSAttributedString.Key.font : navigationFont]
     //   navigationBar.largeTitleTextAttributes = navigationFontAttributes

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
      extension UINavigationController {

        open override var shouldAutorotate: Bool {
          return false
      }

        open override var supportedInterfaceOrientations: UIInterfaceOrientationMask  {
          return (visibleViewController?.supportedInterfaceOrientations)!
          }
      }

