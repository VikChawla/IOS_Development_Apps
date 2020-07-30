//
//  ImageViewController.swift
//  Cassini
//
//  Created by Vik Chawla on 5/30/20.
//  Copyright © 2020 Vik Chawla. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {

  
        
    var  imageURL: URL?
    {
        didSet{
            image = nil
          
            if view.window != nil
            {
               fetchImage()
            }
          
        }
    }
    
    var ImageView = UIImageView()
       
       var image: UIImage? {
           get {
               return ImageView.image
           }
           set {
               ImageView.image = newValue
               ImageView.sizeToFit()
               scrollView?.contentSize = ImageView.frame.size
            spinner?.stopAnimating() 
           }
       }
    
    @IBOutlet weak var scrollView: UIScrollView!
    {
        didSet{
            scrollView.addSubview(ImageView)
            scrollView.minimumZoomScale = 1/25
            scrollView.maximumZoomScale = 1.0
            scrollView.delegate = self
            scrollView.addSubview(ImageView)
        }
    }
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView?
    {
        return ImageView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if ImageView.image == nil{
            fetchImage()
        }
    }
    
   private func fetchImage()
   {
    if let url = imageURL
    {
        spinner?.startAnimating()
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
             let URLstuff = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                if let imageData = URLstuff, url == self?.imageURL
                {
                 self?.image = UIImage(data: imageData)
                  
                }
            }
                   
        }
       
    }
   
    
    
   }
    

}
