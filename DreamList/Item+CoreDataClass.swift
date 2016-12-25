//
//  Item+CoreDataClass.swift
//  DreamList
//
//  Created by AKIL KUMAR THOTA on 12/23/16.
//  Copyright © 2016 AKIL KUMAR THOTA. All rights reserved.
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.created = NSDate()
    }
}
