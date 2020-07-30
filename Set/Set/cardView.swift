//
//  cardView.swift
//  Set
//
//  Created by Vik Chawla on 5/22/20.
//  Copyright © 2020 Vik Chawla. All rights reserved.
//

import UIKit

class cardView: UIView
{
    
    
    var rank: Int = 11 {
        didSet{
            setNeedsDisplay(); setNeedsLayout()
        }
    }
    
    var suit: String = "♥"
    {
        didSet{
            setNeedsDisplay(); setNeedsLayout()
        }
    }

    
    var isFaceUp = true
    {
        didSet{
            setNeedsDisplay(); setNeedsLayout()
        }
    }
    var faceCardScale: CGFloat  = SizeRatio.faceCardImageSizeToBoundsSize{didSet{ setNeedsDisplay()}}
  
  @objc  func pinchFaceCard(recognized  recognizer : UIPinchGestureRecognizer)
    {
        switch recognizer.state {
        case .changed, .ended:
            faceCardScale *= recognizer.scale
            recognizer.scale = 1.0
        default:break
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func draw (_ rect: CGRect)
    {
        let rect  = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        rect.addClip()
        UIColor.white.setFill()
        rect.fill()
        
        if(!isFaceUp)
        {
            let backFaceCard = UIImage(named: "hokie")
            backFaceCard?.draw(in: bounds)
        }
        else{
        
        if let pictureFaceCard = UIImage(named:
           rankString+suit)
        {
            pictureFaceCard.draw(in: bounds.zoom(by: SizeRatio.faceCardImageSizeToBoundsSize))
        
            
        }
        
    }
       
    }
    
    
    
    private var typeString: NSAttributedString {
        return centeredAttributedString(rankString + " \n " + suit, fontSize: cornerFontSize)
    }
    
    private func centeredAttributedString(_ string: String, fontSize: CGFloat) -> NSAttributedString
    {
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        return NSAttributedString(string: string, attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle, .font:font])
    }
    
    lazy var  upperLeftLabel = createCornerLabel()
    
    lazy var lowerRightLabel = createCornerLabel()
    
    
    func createCornerLabel() -> UILabel
    {
        let label = UILabel()
        label.numberOfLines = 0
        addSubview(label)
        return label
        
    }
    private func sizeAndString(lab label:UILabel)
    {
        label.attributedText = typeString
        label.frame.size = CGSize.zero
        label.sizeToFit()
        label.isHidden  = !isFaceUp
    }
    
    //position label appropriately
    override func layoutSubviews() {
        super.layoutSubviews()
        
        sizeAndString(lab: upperLeftLabel)
        upperLeftLabel.frame.origin = bounds.origin.offsetBy(dx: cornerOffset, dy: cornerOffset)
        
         sizeAndString(lab: lowerRightLabel)
        lowerRightLabel.transform = CGAffineTransform.identity
            .translatedBy(x: lowerRightLabel.frame.size.width, y: lowerRightLabel.frame.size.width)
            .rotated(by: CGFloat.pi)
        lowerRightLabel.frame.origin = CGPoint(x: bounds.maxX, y: bounds.maxY)
        .offsetBy(dx: -cornerOffset, dy: -cornerOffset)
            .offsetBy(dx: -lowerRightLabel.frame.size.width, dy: -lowerRightLabel.frame.size.height
        )
        
        
        
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?)
    {

        setNeedsDisplay()
        setNeedsLayout()
    
    }
    
    
}

extension cardView
{
    private struct SizeRatio
    {
        static let cornerFontSizeToBoundsHeight: CGFloat = 0.085
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let cornerOffsetToCornerRadius: CGFloat = 0.33
        static let faceCardImageSizeToBoundsSize: CGFloat = 0.75
    }
    
    private var cornerRadius: CGFloat
    {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    
    private var cornerOffset: CGFloat
    {
        return cornerRadius * SizeRatio.cornerOffsetToCornerRadius
    }
    
    private var cornerFontSize: CGFloat {
        return bounds.size.height * SizeRatio.cornerFontSizeToBoundsHeight
    }
    
    private var rankString: String {
        
        switch rank
        {
            case 1: return "A"
            case 2...10: return String(rank)
            case 11: return "J"
            case 12: return "Q"
            case 13: return "K"
            default: return "?"
        }
    }
    
    private var suitString: String{
        
        switch suit
        {
            case "♥": return "heart"
            case "♣":  return "clubs"
            case "♦": return "diamonds"
            case "♠": return "spades"
            default: return "?"
        }
    }
}


extension CGRect {
    var leftHalf: CGRect {
        return CGRect(x: minX, y:minY, width: width/2, height: height)
    }
    
    var rightHalf: CGRect {
        return CGRect(x: minX, y:minY, width: width/2, height: height)
    }
    
    func inset(by size: CGSize) -> CGRect {
        return insetBy(dx: size.width, dy: size.height)
        
    }
    
    func sized(to size: CGSize) -> CGRect {
        return CGRect(origin: origin, size: size)
    }
    
    func zoom(by scale:CGFloat) -> CGRect {
        let newWidth = width*scale
        let newHeight = height*scale
        return insetBy(dx: (width - newWidth) / 2, dy: (height - newHeight)/2)
        
        
        
    }
}

extension CGPoint
{
    func offsetBy(dx: CGFloat, dy: CGFloat)-> CGPoint
    {
        
        return CGPoint(x: x+dx, y: y+dy)
    }
}
