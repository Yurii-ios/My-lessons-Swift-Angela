//
//  StructExample.swift
//  Structs vs. Clases
//
//  Created by Yurii Sameliuk on 04/01/2020.
//  Copyright © 2020 Yurii Sameliuk. All rights reserved.
//

import Foundation

struct Superhero {
    
    var name: String
    var universe: String
    
    mutating func reverseName()  {
        self.name = String (self.name.reversed())
    }
    
}

