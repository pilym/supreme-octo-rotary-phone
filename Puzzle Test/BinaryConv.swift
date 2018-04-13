//
//  BinaryConv.swift
//  Puzzle Test
//
//  Created by Paul Li on 2018-04-10.
//  Copyright © 2018 Paul Li. All rights reserved.
//

import Foundation

extension String {
    func components(withLength length: Int) -> [String] {
        return stride(from: 0, to: self.count, by: length).map {
            let start = self.index(self.startIndex, offsetBy: $0)
            let end = self.index(start, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            return String(self[start..<end])
        }
    }
}

class BinaryConv {
    static let
    asciiSafeStart: UInt32 = 32,
    asciiSafeEnd: UInt32 = 126
    
    static func asciiToBinary(ascii: String) -> String {
        var output: String = ""
        
        for scalar in (ascii.unicodeScalars) {
            output.append("0")
            output.append(String(scalar.value, radix: 2))
            output.append(" ")
        }
        
        return output
    }
    
    static func binaryToAscii(binary: String) -> String {
        var output: String = ""
        
        let rawBinaryText = binary.filter { "01".contains($0) }
        let binaryComponents = rawBinaryText.components(withLength: 8)
        for component in binaryComponents {
            if let decimal = Int(component, radix: 2), decimal >= asciiSafeStart && decimal <= asciiSafeEnd {
                output.append(Character(UnicodeScalar(decimal)!))
            }
        }
        
        return output
    }
}
