//
//  QRCTableView.swift
//  QRCTableView
//
//  Created by Apple on 6/6/18.
//  Copyright © 2018 Quantox. All rights reserved.
//

import UIKit

class QRCTableView: UITableView , UITableViewDelegate, UITableViewDataSource{
    
    
    typealias OnSelect = (IndexPath) -> ()
    typealias OnDeselect = (IndexPath) -> ()
    
    private var onSelectHandler: OnSelect?
    private var onDeselectHandler: OnDeselect?
    
    // MARK:- Initial setup
    var data: QRCTableViewDataSource?{
        didSet{
            registerCells()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.delegate = self
        self.dataSource = self
    }
    
    func config(_ tableData: QRCTableViewDataSource) -> QRCTableView{
        
        self.data = tableData
        return self
    }
    
    // MARK:- Data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.data?.sections.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let sections = self.data?.sections else {
            return 0
        }
        
        return sections[section].rows?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = data?.sections[indexPath.section]
        
        // Loading cell
        guard indexPath.row < section!.rows!.count else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingTableCell", for: indexPath)
            return cell
        }
        
        guard var cellData = section!.rows?[indexPath.row] else{
            return UITableViewCell()
        }
        
        cellData.isLast = section!.rows!.count - 1 == indexPath.row
        cellData.isFirst = indexPath.row == 0
        
        // Config cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellData.elementIdentifier, for: indexPath)
        cell.config(cellData)
        
        return cell
    }
    
    @discardableResult func onSelectRow(closure: @escaping OnSelect)->Self {
        
        self.onSelectHandler = closure
        
        return self
    }
    
    
    @discardableResult func onDeselectRow(closure: @escaping OnDeselect)->Self {
        
        onDeselectHandler = closure
        
        return self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        onSelectHandler?(indexPath)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        onDeselectHandler?(indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // TODO: When loading cell is going to appear, trigger pagination
        
    }
    
    
    /**
     If using xib for presenting cell, register it here for table view
     #Important: Use for nibName and cellReuseIdentifier same string!!
     */
    private func registerCells() {
        
        data?.sections.forEach { (section) in
            
            // Section Header cell
            if let headerCell = section.footer {
                
                self.register(UINib(nibName: headerCell.data.nibIdentifier ?? headerCell.data.elementIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: headerCell.data.elementIdentifier)
            }
            
            // Section Footer cell
            if let footerCell = section.header {
                self.register(UINib(nibName: footerCell.data.nibIdentifier ?? footerCell.data.elementIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: footerCell.data.elementIdentifier)
            }
            
            // Section cell
            section.rows?.forEach({ (rowData) in
                    registerCellForIdentifier(rowData)
            })
        }
        
        // Loading cell
        registerLoadingCell()
    }
    
    private func registerLoadingCell(){
        
        guard Bundle.main.path(forResource: "LoadingTableCell", ofType: ".nib") != nil else{
            return
        }
        
        self.register(UINib(nibName: "LoadingTableCell", bundle: nil), forCellReuseIdentifier: "LoadingTableCell")
    }
    
    /**
     Register cell for table view
     
     - parameter cellIdentifier: The reuse identifier
     */
    private func registerCellForIdentifier(_ elementData: QRCBaseElementData) {
        self.register(UINib(nibName: elementData.nibIdentifier ?? elementData.elementIdentifier, bundle: nil), forCellReuseIdentifier: elementData.elementIdentifier)
    }
}

extension UITableViewCell{
    
    @objc func config(_ data: Any){ }
}
