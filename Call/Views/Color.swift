//
//  Color.swift
//  Call
//
//  Created by 谭帆帆 on 16/5/19.
//  Copyright © 2016年 风起兮. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func rgb(red: Int,green: Int, blue: Int) ->UIColor {
        
        func percentage(num: Int) ->CGFloat {
            
            return CGFloat(num) / 255.0
        }
        
        return UIColor(red: percentage(red), green: percentage(green), blue: percentage(blue), alpha: 1.0)
    }
    
}

class Color {
    
    static let themeColor = UIColor.rgb(34, green: 189, blue: 122)
}

