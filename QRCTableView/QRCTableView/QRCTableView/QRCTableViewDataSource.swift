//
//  QRCTableViewDataSource.swift
//  QRCTableView
//
//  Created by Apple on 6/6/18.
//  Copyright © 2018 Quantox. All rights reserved.
//

import Foundation

struct QRCTableViewDataSource {
    
    var sections: [QRCSectionData]
    
    init(sections: [QRCSectionData]) {
        self.sections = sections
    }
    
    init(rows: [QRCBaseElementData]) {
        
        self.sections = [QRCSectionData(header: nil, footer: nil, rows: rows)]
    }
}
