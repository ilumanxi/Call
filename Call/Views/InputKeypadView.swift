//
//  InputKeypad.swift
//  Call
//
//  Created by 风起兮 on 16/5/20.
//  Copyright © 2016年 风起兮. All rights reserved.
//

import UIKit


class InputKeypadView: UIView {
    
    enum Operation {
        case input
        case paste
        case delete
        case dial
    }
    
    typealias Completion = (_ inputKeypadView: InputKeypadView, _ string: String?, _ operationType: Operation) -> Void
    
    var completion: Completion?
    
    private static let reuseIdentifier = String(describing: InputKeypadViewCell.self)
    
    @IBOutlet weak var collectionViewGridLayout: CollectionViewGridLayout!

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var longPressGestureRecognizer: UILongPressGestureRecognizer!
    
    @IBAction func handleGesture(_ sender: UILongPressGestureRecognizer) {
        switch sender.state {
        case .began:
            let point = sender.location(in: collectionView)
            guard let indexPath = collectionView.indexPathForItem(at: point) else {
                return
            }
            if indexPath.item == 10 {
                let cell = collectionView.cellForItem(at: indexPath) as? InputKeypadViewCell
                let string = cell?.bottomTitleLabel.text
                completion?(self, string, .input)
            }
        default:
            break
        }
    }
    
    
    class func loadFromXIB() -> InputKeypadView {
        
        return  Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)!.first as! InputKeypadView
        
    }
    

    @IBAction func dial(sender: UIButton) {
        completion?(self, nil, .dial)
    }
    
    override func awakeFromNib() {
        let reuseIdentifier = type(of: self).reuseIdentifier
        self.collectionView.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        collectionViewGridLayout.itemHeight = (200 - 0.5 * 5) / 4.0
        collectionView.contentInset = UIEdgeInsetsMake(0.5, 0, 0, 0)
        self.collectionView.backgroundColor = UIColor.rgb(red: 216, green: 216, blue: 216)
    }
    
    
}



extension InputKeypadView: UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 12
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type(of: self).reuseIdentifier, for: indexPath) as? InputKeypadViewCell else {
            
            return UICollectionViewCell()
        }
        configCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        defer {
            collectionView.deselectItem(at: indexPath, animated: true)
        }
        
        switch indexPath.row {
        case 0...8:
           fallthrough
        case 10:
            let cell = collectionView.cellForItem(at: indexPath as IndexPath) as? InputKeypadViewCell
            completion?(self, cell?.topTitleLabel.text, .input)
        case 9:
            completion?(self, nil, .paste)
        default:
            completion?(self, nil, .delete)
        }

        
    }
    
    private func configCell(cell: InputKeypadViewCell,indexPath: IndexPath) {
        
        cell.backgroundColor = UIColor.rgb(red: 249, green: 249, blue: 249)
        
        func titleString(_ start: Int, _ end: Int) ->String {
            let string = "ABCDEFGHIJKLMNOPQTSTUVWXYZ"
            
            let startIndex = string.index(string.startIndex, offsetBy: start)
            let endIndex = string.index(string.startIndex, offsetBy: end)
            return string.substring(with: startIndex..<endIndex)
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
