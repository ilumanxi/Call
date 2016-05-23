//
//  Model.swift
//  Call
//
//  Created by 风起兮 on 16/5/23.
//  Copyright © 2016年 风起兮. All rights reserved.
//

import UIKit


struct Section {
    
    var header: AnyObject?
    var footer: AnyObject?
    var items = [Item]()
}



protocol Item {
    
    var reuseIdentifier: String { get }
    var rowHeight: CGFloat { get }
    
}


