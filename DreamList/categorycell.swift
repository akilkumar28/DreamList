//
//  categorycell.swift
//  DreamList
//
//  Created by AKIL KUMAR THOTA on 12/25/16.
//  Copyright © 2016 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit

class categorycell: UITableViewCell {
    
    var categories = [String]()


    override func awakeFromNib() {
        super.awakeFromNib()
        
        categories = ["Electronics","Toys","Vehicle","Cosmetics","House Hold"]

    }

    func categoryname(cell: categorycell, indexPath: IndexPath) {
        
        cell.textLabel?.text = categories[indexPath.row]
        
        
        
    }

}
