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
    
    
    
    func setTitle(_ title: String) {
        titleLabel.text = title
        setViews(titleLabel, hidden: false)
        setViews(topTitleLabel,bottomTitleLabel,imageView, hidden: true)
    }
    
    func setTopTitle(_ topTitle: String,bottomTitle: String?) {
        topTitleLabel.text = topTitle
        bottomTitleLabel.text = bottomTitle
        setViews(topTitleLabel,bottomTitleLabel, hidden: false)
        setViews(titleLabel,imageView, hidden: true)
        if bottomTitle == nil {
            stackView.axis = .horizontal
            stackView.alignment = .top
        }else {
            stackView.axis = .vertical
            stackView.alignment = .center
        }
    }
    
    
    func setImage(_ image: UIImage,highlightedImage: UIImage) {
        imageView.image = image
        imageView.highlightedImage = highlightedImage
        setViews(imageView, hidden: false)
        setViews(topTitleLabel,bottomTitleLabel,titleLabel, hidden: true)
    }
    
    
    func setViews(_ views: UIView...,hidden: Bool) {
        for view in views {
            view.isHidden = hidden
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = Color.themeColor.withAlphaComponent(0.2)
    }

}



