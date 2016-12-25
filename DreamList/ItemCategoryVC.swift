//
//  ItemCategoryVC.swift
//  DreamList
//
//  Created by AKIL KUMAR THOTA on 12/25/16.
//  Copyright © 2016 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit

protocol categorySelected {
    func category(category: String)
}



class ItemCategoryVC: UITableViewController {
    
    
    var delegate: categorySelected!

    

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return 5
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell = tableView.cellForRow(at: indexPath)
        
        if let categoryname = selectedCell?.textLabel?.text{
            delegate.category(category: categoryname)
            _ = navigationController?.popViewController(animated: true)
        }
        
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) as! categorycell
        cell.categoryname(cell: cell, indexPath: indexPath)
        return cell
    }
    
}
    
    
    

   

