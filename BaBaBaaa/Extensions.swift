//
//  Extensions.swift
//  BaBaBaaa
//
//  Created by Chelsea Chen CHEN on 3/25/19.
//  Copyright © 2019 Chelsea Chen CHEN. All rights reserved.
//

//An initializer that will create it from JSON, as well as a computed property to get a dictionary from its properties.

import Foundation
import UIKit

extension String {
    static var randomName: String {
        let nouns = ["sheep", "goat", "lamp", "tup", "mutton", "咩", "羊羊羊", "🐑", "Shawn"]
        return nouns.randomElement()!
    }
    
    static var randomAvatar: String {
        let indices = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return indices.randomElement()!
    }
}
