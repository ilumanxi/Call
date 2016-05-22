//
//  CollectionViewFlowLayout.swift
//  Story
//
//  Created by 风起兮 on 15/11/12.
//  Copyright © 2015年 风起兮. All rights reserved.
//

import UIKit


public class CollectionViewGridLayout: UICollectionViewLayout {
    
    /// item元素宽度
    private(set) var itemWidth:CGFloat = 0
    
    
    public var itemHeight: CGFloat = 0 {
        didSet{
            invalidateLayout()
        }
    }
    /// 每行最大列数
    public var maxColumns:Int = 3{
        didSet{
            invalidateLayout()
        }
    }
    
    /// 行间隙数
    public var lineIntervals:Int{
        return maxRow - 1
    }
    
    /// 行数
    public var maxRow:Int{
        let maxRow =  maxCount / maxColumns
        return   maxRow > 0 && maxRow < 1 ? 1 : maxRow
    }
    /// 总数量
    public var maxCount:Int {
        return (self.collectionView?.dataSource?.collectionView(self.collectionView!, numberOfItemsInSection: 0))!
    }
    /// item元素间距
    public var itemInterval:CGFloat = 0.5{
        didSet{
           invalidateLayout()
        }
    }
    
    override public func prepareLayout() {
        super.prepareLayout()
        itemWidth = (self.collectionView!.bounds.width - CGFloat(maxColumns - 1) * itemInterval) / CGFloat(maxColumns)
    }
    
    override public func collectionViewContentSize() -> CGSize {
       let boundHeight = CGFloat(maxRow) * itemHeight + CGFloat(lineIntervals) * itemInterval
       return CGSize(width: self.collectionView!.bounds.width, height: boundHeight)
    }
    
    override public func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    
    override public func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let layoutAttributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        let row = indexPath.item / maxColumns
        let col = indexPath.item % maxColumns
        let x =  CGFloat(col) * itemWidth + CGFloat(col) * itemInterval
        let y =  CGFloat(row) * itemHeight + CGFloat(row) * itemInterval
        layoutAttributes.frame = CGRect(x: x, y: y, width: itemWidth, height: itemHeight);
        return layoutAttributes
    }
    
    override public func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for item in 0..<maxCount{
            layoutAttributes.append(self.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: item, inSection: 0))!)
        }
        return layoutAttributes
    }

}
