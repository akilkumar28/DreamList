//
//  Item+CoreDataProperties.swift
//  DreamList
//
//  Created by AKIL KUMAR THOTA on 12/23/16.
//  Copyright © 2016 AKIL KUMAR THOTA. All rights reserved.
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item");
    }

    @NSManaged public var created: NSDate?
    @NSManaged public var details: String?
    @NSManaged public var price: Double
    @NSManaged public var title: String?
    @NSManaged public var toImage: Image?
    @NSManaged public var toItemType: ItemType?
    @NSManaged public var toStore: Store?
    @NSManaged public var type: String?

}
