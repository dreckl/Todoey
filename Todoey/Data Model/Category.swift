//
//  Category.swift
//  Todoey
//
//  Created by Eckl on 29.12.17.
//  Copyright © 2017 Team2011.com. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
