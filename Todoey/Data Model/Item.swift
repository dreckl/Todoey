//
//  Item.swift
//  Todoey
//
//  Created by Eckl on 29.12.17.
//  Copyright © 2017 Team2011.com. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var timeStamp = Date()
    let parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
