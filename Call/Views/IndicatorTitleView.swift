//
//  IndicatorTitleView.swift
//  Call
//
//  Created by 谭帆帆 on 16/5/23.
//  Copyright © 2016年 风起兮. All rights reserved.
//

import UIKit

class IndicatorTitleView: UIView {
    
    @IBInspectable var image: UIImage? {
        
        get {
            return imageView.image
        }
        
        set {
            imageView.image = newValue
        }
    }
    
    @IBInspectable var title: String? {
        
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
            imageView.isHidden = !(newValue == nil)
        }
    
    }
    

    lazy var imageView: UIImageView = {
        
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    lazy var titleLabel: UILabel =  {
        let  titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.lineBreakMode = .byTruncatingHead
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    func deleteBackward() {
    
        guard var text = title else  {
            
            return
        }
        
        
        
        text = text.substring(to: text.index(before: text.endIndex))
        title = text.isEmpty ? nil : text
    }
    
    
    
    override func willMove(toSuperview newSuperview: UIView?) {
        do {
            
            addSubview(imageView)
            addSubview(titleLabel)
        }
        
        
        do {
            
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            titleLabel.leftAnchor.constraint(greaterThanOrEqualTo: leftAnchor).isActive = true
            titleLabel.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor).isActive = true
            
//            let imageViewHorizontalConstraint = NSLayoutConstraint(item: imageView, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1.0, constant: 0)
//            let imageViewVerticalConstraint = NSLayoutConstraint(item: imageView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0)
//            addConstraint(imageViewVerticalConstraint)
//            addConstraint(imageViewHorizontalConstraint)
            
//            let views = ["titleLabel":titleLabel]
//            let titleLabelHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[titleLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
//            let titleLabelVerticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[titleLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
//            addConstraints(titleLabelHorizontalConstraints)
//            addConstraints(titleLabelVerticalConstraints)
        }
        
    }

}
