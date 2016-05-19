//
//  SegmentedControl.swift
//  ad
//
//  Created by 谭帆帆 on 16/5/19.
//  Copyright © 2016年 tanfanfan. All rights reserved.
//

import UIKit

class SegmentedControl: UISegmentedControl {

    enum State: Int {
        case Normal
        case Selected
    }
    
    
    var imageViews: [UIImageView]?{
        
        return valueForKey("segments") as? [UIImageView]
        
    }
    
    
    
    private var lastSelectedSegmentIndex: Int?
    
    private var segmentsImage = [UIImage?]()
    
    private var selectedSegmentsImage = [UIImage?]()

    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        super.touchesBegan(touches, withEvent: event)
        if selectedSegmentIndex >= 0 {
            
            lastSelectedSegmentIndex = selectedSegmentIndex
        }
    
        
    }
    
    private func setImage(segment: Int, state: State) {
    
        switch state {
        case .Normal:
            self.imageViews?[segment].image = self.segmentsImage[segment]
        case .Selected:
             self.imageViews?[segment].image = self.selectedSegmentsImage[segment]
        }
        
    }
    
    override func sendActionsForControlEvents(controlEvents: UIControlEvents) {
        
        super.sendActionsForControlEvents(controlEvents)
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64( CGFloat(NSEC_PER_SEC) * 0.0001)), dispatch_get_main_queue()) {
           self.changeDisplay()
            
        }
        
    }
    
    override func didMoveToSuperview() {
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64( CGFloat(NSEC_PER_SEC) * 1.5)), dispatch_get_main_queue()) {
            
            guard let segments =  self.imageViews?.enumerate() else {
                return
            }
            
            for (segment,_) in segments {
                
                if segment < self.segmentsImage.count {
                    self.setImage(segment, state: .Normal)
                }
                
            }
            
            self.changeDisplay()
            
        }
    }
    
    private func changeDisplay() {
        
        if let selectedSegmentIndex = lastSelectedSegmentIndex {
            
            self.setImage(selectedSegmentIndex, state: .Normal)
        }
        
        if self.selectedSegmentIndex >= 0{
              self.setImage(self.selectedSegmentIndex, state: .Selected)
        }
    }
    
    override func setImage(image: UIImage?, forSegmentAtIndex segment: Int){
        
        segmentsImage.insert(image, atIndex: segment)
        changeDisplay()
        
    }
    
    
    func setSelectedImage(image: UIImage?, forSegmentAtIndex segment: Int){
        
        selectedSegmentsImage.insert(image, atIndex: segment)
        changeDisplay()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height * 0.5
        layer.masksToBounds = true
    }

}
