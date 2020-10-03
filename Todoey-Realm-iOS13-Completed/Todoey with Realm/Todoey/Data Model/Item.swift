//
//  Item.swift
//  Todoey
//
//  Created by Yurii Sameliuk on 02/12/2019.
//  Copyright © 2019 Yurii Sameliuk. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    //@objc dynamic - identifikator kotoruj nygno dopisuwat do peremennoy pri rabote s Realm bazoy dannux
    @objc dynamic var title : String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var timestamp: Date = Date()
    // sozdaem otnoshenie Item - Category. Category.self- bez self eto nebydet tipom kategirii. "items" - eto peremennoja kotoryju mu sozdali w klase Category
    let parentCategory = LinkingObjects(fromType: Category.self, property:"items")
}
