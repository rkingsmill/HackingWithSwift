//
//  Person.swift
//  Project10
//
//  Created by Rosalyn Kingsmill on 2017-08-05.
//  Copyright © 2017 Rosalyn Kingsmill. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
