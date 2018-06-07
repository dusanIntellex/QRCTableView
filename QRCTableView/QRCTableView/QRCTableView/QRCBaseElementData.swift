//
//  QRCBaseElementData.swift
//  QRCTableView
//
//  Created by Apple on 6/6/18.
//  Copyright © 2018 Quantox. All rights reserved.
//

import Foundation

struct QRCBaseElementData {
    
    var elementIdentifier: String // reuse
    var nibIdentifier: String?
    var data: Any?
    
    var isLast: Bool = false
    var isFirst: Bool = false
    
    init(elementIdentifier: String, data: Any?, nib: String? = nil){
        
        self.elementIdentifier = elementIdentifier
        self.data = data
        self.nibIdentifier = nib
    }
}
