//
//  InputKeypadViewCell.swift
//  Call
//
//  Created by 风起兮 on 16/5/21.
//  Copyright © 2016年 风起兮. All rights reserved.
//

import UIKit

class InputKeypadViewCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var topTitleLabel: UILabel!
    
    @IBOutlet weak var bottomTitleLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    
    
    func setTitle(title: String) {
        titleLabel.text = title
        setViews(titleLabel, hidden: false)
        setViews(topTitleLabel,bottomTitleLabel,imageView, hidden: true)
    }
    
    func setTopTitle(topTitle: String,bottomTitle: String?) {
        topTitleLabel.text = topTitle
        bottomTitleLabel.text = bottomTitle
        setViews(topTitleLabel,bottomTitleLabel, hidden: false)
        setViews(titleLabel,imageView, hidden: true)
        if bottomTitle == nil {
            stackView.axis = .Horizontal
            stackView.alignment = .Top
        }else {
            stackView.axis = .Vertical
            stackView.alignment = .Center
        }
    }
    
    
    func setImage(image: UIImage) {
        imageView.image = image
        setViews(imageView, hidden: false)
        setViews(topTitleLabel,bottomTitleLabel,titleLabel, hidden: true)
    }
    
    
    func setViews(views: UIView...,hidden: Bool) {
        for view in views {
            view.hidden = hidden
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}



