//
//  Category.swift
//  Todoey
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 15/02/22.
//  Copyright © 2022 

import Foundation
import RealmSwift

class Category: Object{
    @objc dynamic var name:String = ""
    @objc dynamic var color:String = ""
    let items = List<Item>()
}

