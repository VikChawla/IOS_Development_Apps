//
//  EmojiArtViewController.swift
//  EmojiArt
//
//  Created by Vik Chawla on 6/4/20.
//  Copyright © 2020 Vik Chawla. All rights reserved.
//

import UIKit

class EmojiArtViewController: UIViewController, UIDropInteractionDelegate, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDragDelegate, UICollectionViewDropDelegate
{
    
    private var addingEmoji = false
    @IBAction func addEmoji()
    {
        addingEmoji = true
        emojiCollectionView.reloadSections(IndexSet(integer: 0))
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
   

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

     var emojiView = EmojiView()
    
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var scrollViewWidth: NSLayoutConstraint!
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        scrollViewHeight.constant = scroll.contentSize.height
        scrollViewWidth.constant = scroll.contentSize.width
    }
    @IBOutlet weak var dropZone: UIView!{
        didSet{
            dropZone.addInteraction(UIDropInteraction(delegate: self))
        }
    }
    
    @IBOutlet weak var emojiCollectionView: UICollectionView! {
    didSet{
        emojiCollectionView.dataSource = self
        emojiCollectionView.delegate = self
        emojiCollectionView.dragDelegate = self
        emojiCollectionView.dropDelegate  = self
            }
        }
    
    var emojiArr = ["🥂", "🤯", "🍻", "🚬", "🍾", "🥃", "💅🏽", "👑", "🍗", "🍔", "🥗", "🍳", "🥓", "🍌", "🥦", "💪🏾","🐷", "🐽", "🙈", "🐣", "🦄", "🐳", "🐖", "🦃"]
    
    private var font: UIFont{
        return UIFontMetrics(forTextStyle: .body).scaledFont(for:
            UIFont.preferredFont(forTextStyle: .body).withSize(64.0))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
        {
            switch section{
                case 0: return 1
                case 1: return emojiArr.count
                default: return 0
            }
  
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
       {
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiCell", for: indexPath)
            if let emojiCell = cell as? EmojiCollectionViewCell
            {
                let text = NSAttributedString(string: emojiArr[indexPath.item], attributes: [.font:font])
                emojiCell.label.attributedText = text
            }
            return cell
           }
        else if addingEmoji{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emojiInputCell", for: indexPath)
            return cell
        }
        else{
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addEmojiCell", for: indexPath)
            return cell
        }
      //  emojiInputCell
     //  return cell
    }
    
       //makes sure size of what you are typing in is good
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if addingEmoji && indexPath.section == 0{
            return CGSize(width: 300, height: 80)
        }else{
            return CGSize(width: 80, height: 80)
        
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let inputCell = cell as? TextFieldCollectionViewCell{
            inputCell.textField.becomeFirstResponder()
        }
    }

    @IBOutlet weak var scroll: UIScrollView!{
        didSet{
            scroll.minimumZoomScale = 0.1
            scroll.maximumZoomScale = 5.0
            scroll.delegate = self
            scroll.addSubview(emojiView)
            
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return emojiView
    }
    
    var emojiArtBackgroundImage: UIImage? {
        get{
            return emojiView.backgroundImage
        }
        
        set{
            scroll?.zoomScale = 1.0
            emojiView.backgroundImage = newValue
            let size = newValue?.size ?? CGSize.zero
            emojiView.frame = CGRect(origin: CGPoint.zero, size: size)
            scroll?.contentSize = size
            scrollViewHeight?.constant = size.height
            scrollViewWidth?.constant = size.width
            if let dropZone = self.dropZone, size.width > 0, size.height > 0{
                scroll.zoomScale = max(dropZone.bounds.size.width/size.width, dropZone.bounds.size.height/size.height)
            }
        }
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSURL.self) && session.canLoadObjects(ofClass: UIImage.self)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    var imageFetcher: ImageFetcher!
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession)
    {
        imageFetcher = ImageFetcher() { (url, image) in
        DispatchQueue.main.async {
            self.emojiArtBackgroundImage = image
            }
        }
        session.loadObjects(ofClass: NSURL.self){ nsurls in
            if let url = nsurls.first as? URL{
                self.imageFetcher.fetch(url)
                }
            }
        session.loadObjects(ofClass: UIImage.self) { images in
            if let image = images.first as? UIImage {
            self.imageFetcher.backup = image
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        session.localContext = collectionView
        return dragItems(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem]
    {
        return dragItems(at: indexPath)
    }
    
    private func dragItems(at indexPath: IndexPath) -> [UIDragItem]
    {
        if addingEmoji, let attributedString = (emojiCollectionView.cellForItem(at: indexPath) as? EmojiCollectionViewCell)?.label.attributedText {
            let dragItem = UIDragItem(itemProvider: NSItemProvider(object: attributedString))
            dragItem.localObject = attributedString
            return [dragItem]
        }
        else
        {
            return []
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSAttributedString.self)
    }

    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal
    {
        let isSelf = (session.localDragSession?.localContext as? UICollectionView) == collectionView
        return UICollectionViewDropProposal(operation: isSelf ? .move : .copy, intent: .insertAtDestinationIndexPath)
    }

    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        let destinationIndexPath = coordinator.destinationIndexPath ?? IndexPath(item: 0, section: 0)
        for item in coordinator.items
        {
            if let itemPath = item.sourceIndexPath {
                if let attributedString = item.dragItem.localObject as? NSAttributedString
                {
                    collectionView.performBatchUpdates({
                    emojiArr.remove(at: itemPath.item)
                    emojiArr.insert(attributedString.string, at: destinationIndexPath.item)
                        collectionView.deleteItems(at: [itemPath])
                        collectionView.insertItems(at: [destinationIndexPath])
                        
                    })
                    coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
                }
            }
            else{
                let placeholderContext  = coordinator.drop(item.dragItem, to: UICollectionViewDropPlaceholder(insertionIndexPath: destinationIndexPath, reuseIdentifier: "placeholderCell"))
                item.dragItem.itemProvider.loadObject(ofClass: NSAttributedString.self) {(provider, error)
                    in DispatchQueue.main.async {
                        if let attributedString = provider as? NSAttributedString {
                            placeholderContext.commitInsertion(dataSourceUpdates: {insertionIndexPath in
                                self.emojiArr.insert(attributedString.string, at: insertionIndexPath.item)
                            })
                        }
                        else{
                            placeholderContext.deletePlaceholder()
                        }
                    }
                }
            }
        
        }
        
    }
    
    
}
