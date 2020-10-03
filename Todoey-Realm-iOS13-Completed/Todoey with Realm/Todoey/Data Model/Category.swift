//
//  Category.swift
//  Todoey
//
//  Created by Yurii Sameliuk on 24/12/2019.
//  Copyright © 2019 Yurii Sameliuk. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    // dynamic - ozna4aet 4to mu mogem otsleguwat izmenenija swojstw wo wremia rabotu prilogenija
    @objc dynamic var name: String = ""
    @objc dynamic var colour: String = ""
    //  let array = Arrays<Int>() - primer w kotorom objawliaem pystoy masiw tipa Int
    // zdes mu objawliaem masiw tipa Item, 4tobu sozdat otnoshenie Category - Item. Список тип контейнера в Realm используется для определения 1   ко-многим. goworit 4to Category moget imet neskolko Item
    let items = List<Item>()
    
}
