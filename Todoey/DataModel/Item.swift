//
//  Item.swift
//  Todoey
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 15/02/22.
//  

import Foundation
import RealmSwift

class Item: Object{
    @objc dynamic var title:String = ""
    @objc dynamic var done:Bool = false
    @objc dynamic var date:Date = Date()
    var parentcategory = LinkingObjects(fromType: Category.self, property: "items")
}
