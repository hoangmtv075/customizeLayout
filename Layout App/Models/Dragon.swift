//
//  Dragon.swift
//  Layout App
//
//  Created by Jack Ily on 22/06/2019.
//  Copyright © 2019 Jack Ily. All rights reserved.
//

import UIKit

class Dragon {
    
    let image: UIImage
    let name: String
    
    init(image: UIImage, name: String) {
        self.image = image
        self.name = name
    }
    
    class func sharedInstance() -> [Dragon] {
        return [
            Dragon(image: UIImage(named: "image_0")!, name: "Dragon"),
            Dragon(image: UIImage(named: "image_1")!, name: "Dragon"),
            Dragon(image: UIImage(named: "image_2")!, name: "Dragon"),
            Dragon(image: UIImage(named: "image_3")!, name: "Dragon"),
            Dragon(image: UIImage(named: "image_4")!, name: "Dragon"),
            Dragon(image: UIImage(named: "image_5")!, name: "Dragon"),
            Dragon(image: UIImage(named: "image_6")!, name: "Dragon"),
            Dragon(image: UIImage(named: "image_7")!, name: "Dragon"),
            Dragon(image: UIImage(named: "image_8")!, name: "Dragon"),
            Dragon(image: UIImage(named: "image_9")!, name: "Dragon"),
            Dragon(image: UIImage(named: "image_10")!, name: "Dragon"),
        ]
    }
}
