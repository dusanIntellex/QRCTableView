//
//  ViewController.swift
//  QRCTableView
//
//  Created by Apple on 6/6/18.
//  Copyright © 2018 Quantox. All rights reserved.
//

import UIKit

struct User {
    
    var name : String
    var lastName: String
}


class ViewController: UIViewController {

    @IBOutlet weak var tableView: QRCTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var rows = [QRCBaseElementData]()
        for n in 0...10{
            let user = User(name: "UserName \(n)", lastName: "lastName \(n)")
            let cell = QRCBaseElementData(elementIdentifier: "BaseCell", data: user)
            rows.append(cell)
        }
        
        let data = QRCTableViewDataSource(rows: rows)
        
        tableView.config(data)
            .onSelectRow{ indexPath in
                print("Selected")
            }.onDeselectRow{ indexPath in
                print("Deselected")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

