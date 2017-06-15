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
        
        return value(forKey: "segments") as? [UIImageView]
        
    }
    
    
    
    private var lastSelectedSegmentIndex: Int?
    
    private var segmentsImage = [Int:UIImage?]()
    
    private var selectedSegmentsImage = [Int:UIImage?]()

    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches, with: event)
        if selectedSegmentIndex >= 0 {
            
            lastSelectedSegmentIndex = selectedSegmentIndex
        }
    
        
    }
    
    private func setImage(segment: Int, state: State) {
    
        switch state {
        case .Normal:
            self.imageViews?[segment].image = self.segmentsImage[segment] ?? nil
        case .Selected:
             self.imageViews?[segment].image = self.selectedSegmentsImage[segment] ?? nil
        }
        
    }
    
    
    override func sendActions(for controlEvents: UIControlEvents) {
        super.sendActions(for: controlEvents)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.changeDisplay()
        }
    }
    
//    override func didMoveToSuperview() {
//        
//        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64( CGFloat(NSEC_PER_SEC) * 1.5)), dispatch_get_main_queue()) {
//            
//            guard let segments =  self.imageViews?.enumerate() else {
//                return
//            }
//            
//            for (segment,_) in segments {
//                
//                if segment < self.segmentsImage.count {
//                    self.setImage(segment, state: .Normal)
//                }
//                
//            }
//            
//            self.changeDisplay()
//            
//        }
//    }
    
    private func changeDisplay() {
        
        if let selectedSegmentIndex = lastSelectedSegmentIndex {
            
            self.setImage(segment: selectedSegmentIndex, state: .Normal)
        }
        
        if self.selectedSegmentIndex >= 0{
              self.setImage(segment: selectedSegmentIndex, state: .Selected)
        }
    }
    
    override func setImage(_ image: UIImage?, forSegmentAt segment: Int){
        segmentsImage[segment] = image
        changeDisplay()
        
    }
    
    
    func setSelectedImage(image: UIImage?, forSegmentAtIndex segment: Int){
        selectedSegmentsImage[segment] = image
        changeDisplay()
        
    }
    
    override func tintColorDidChange() {
        layer.borderColor = tintColor.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderWidth = 1
        layer.cornerRadius = bounds.height * 0.5
        layer.masksToBounds = true
    }

}
