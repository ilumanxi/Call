//
//  InputKeypad.swift
//  Call
//
//  Created by 风起兮 on 16/5/20.
//  Copyright © 2016年 风起兮. All rights reserved.
//

import UIKit


class InputKeypadView: UIView {
    
    
    
    private static let reuseIdentifier = String(InputKeypadViewCell)
    
    @IBOutlet weak var collectionViewGridLayout: CollectionViewGridLayout!

    @IBOutlet weak var collectionView: UICollectionView!
    class func loadFromXIB() -> InputKeypadView {
        
       return  NSBundle.mainBundle().loadNibNamed(String(self), owner: nil, options: nil).first as! InputKeypadView
        
    }
    

    
    override func awakeFromNib() {
        let reuseIdentifier = self.dynamicType.reuseIdentifier
        self.collectionView.registerNib(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        collectionViewGridLayout.itemHeight = (200 - 0.5 * 5) / 4.0
        collectionView.contentInset = UIEdgeInsetsMake(0.5, 0, 0, 0)
        self.collectionView.backgroundColor = UIColor.rgb(216, green: 216, blue: 216)
    }
    
    
}



extension InputKeypadView: UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 12
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.dynamicType.reuseIdentifier, forIndexPath: indexPath) as? InputKeypadViewCell else {
            
            return UICollectionViewCell()
        }
        
        configCell(cell, indexPath: indexPath)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return true
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64( CGFloat(NSEC_PER_SEC) * 0.25)), dispatch_get_main_queue()) {
            collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        }
        
    }
    
    private func configCell(cell: InputKeypadViewCell,indexPath: NSIndexPath) {
        
        cell.backgroundColor = UIColor.rgb(249, green: 249, blue: 249)
        
        func titleString(start: Int,_ end: Int) ->String {
            let string = "ABCDEFGHIJKLMNOPQTSTUVWXYZ"
            let startIndex = string.startIndex.advancedBy(start)
            let endIndex = string.startIndex.advancedBy(end)
            return string.substringWithRange(startIndex..<endIndex)
        }
        switch indexPath.row {
        case 0: // number 1
            cell.setTopTitle("1", bottomTitle: nil)
        case 1...5:
            let start = (indexPath.row - 1) * 3
            let end = (indexPath).row * 3
            cell.setTopTitle("\(indexPath.row + 1)", bottomTitle: titleString(start, end))
        case 6:
            let start = (indexPath.row - 1) * 3
            let end = (indexPath).row * 3  + 1
            cell.setTopTitle("\(indexPath.row + 1)", bottomTitle: titleString(start, end))
        case 7:
            let start = (indexPath.row - 1) * 3 + 1
            let end = (indexPath).row * 3 + 1
            cell.setTopTitle("\(indexPath.row + 1)", bottomTitle: titleString(start, end))
        case 8:
            let start = (indexPath.row - 1) * 3 + 1
            let end = (indexPath).row * 3 + 2
            cell.setTopTitle("\(indexPath.row + 1)", bottomTitle: titleString(start, end))
        case 9: // number 10
            cell.setTitle("黏贴")
        case 10:
            cell.setTopTitle("0", bottomTitle: "+")
        default:
            cell.setImage(UIImage(named: "dial_keyboard_backspace_nor~iphone")!,highlightedImage: UIImage(named: "dial_keyboard_backspace_pressed~iphone")!)
        }
    }
    
    
}