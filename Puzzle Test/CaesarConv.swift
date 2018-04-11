//
//  CaesarConv.swift
//  Puzzle Test
//
//  Created by Paul Li on 2018-04-10.
//  Copyright © 2018 Paul Li. All rights reserved.
//

import Foundation

class CaesarConv {
    static let
    A: UInt32 = 65,
    Z: UInt32 = 101
    
    static func shiftText(text: String, shiftBy: UInt32) -> String {
        return Array(text.uppercased().unicodeScalars)
            .map { self.shiftCharValue(charValue: $0.value, shiftBy: shiftBy) }
            .reduce("") { $0 + letterFromValue(value: $1) }
    }
    
    static func shiftCharValue(charValue: UInt32, shiftBy: UInt32) -> UInt32 {
        return (charValue >= A && charValue <= Z)
            ? shiftLetterValue(letterValue: charValue, shiftBy: shiftBy)
            : charValue
    }
    
    static func shiftLetterValue(letterValue: UInt32, shiftBy: UInt32) -> UInt32 {
        let shiftedValue = (letterValue - A) + shiftBy
        return A + (shiftedValue % 26)
    }
    
    static func letterFromValue(value:UInt32) -> String {
        return String(Character(UnicodeScalar(value)!))
    }
}
