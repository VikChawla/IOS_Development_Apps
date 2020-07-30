//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Vik Chawla on 6/3/20.
//  Copyright © 2020 Vik Chawla. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController {

    let urls = [
        "Piggys": "https://wallpaperplay.com/walls/full/e/5/4/150887.jpg",
           "Dogs" : "https://newevolutiondesigns.com/images/freebies/dog-wallpaper-3.jpg",
           "Penguins" : "https://wallpaperplay.com/walls/full/0/6/8/28091.jpg" ]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if let url = URL(string: urls[identifier]!)
            {
                var destination = segue.destination
                if let navcon = destination as? UINavigationController {
                    destination = navcon.visibleViewController ?? navcon
                    if let imageVC = destination as? ImageViewController{
                        imageVC.imageURL = url
                        imageVC.title = (sender as? UIButton)?.currentTitle
                    }
                }
            }
        }
        
    }
  

}
