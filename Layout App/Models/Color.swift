//
//  Color.swift
//  Layout App
//
//  Created by Jack Ily on 22/06/2019.
//  Copyright © 2019 Jack Ily. All rights reserved.
//

import UIKit

class Color {
    
    var color: UIColor
    
    init(color: UIColor) {
        self.color = color
    }
    
    static func sharedInstance() -> [Color] {
        return [
            Color(color: UIColor(hex: 0x42CDDD)),
            Color(color: UIColor(hex: 0x00C2A2)),
            Color(color: UIColor(hex: 0x8A5DB5)),
            Color(color: UIColor(hex: 0x4DA43A)),
            Color(color: UIColor(hex: 0xDBE200)),
            Color(color: UIColor(hex: 0xCA916C)),
            Color(color: UIColor(hex: 0x8F9A9B)),
            Color(color: UIColor(hex: 0xDE834C)),
            Color(color: UIColor(hex: 0xEA60A7)),
            Color(color: UIColor(hex: 0x8C6FCA)),
        ]
    }
}
