//
//  Keyboard.swift
//  Puzzle Test
//
//  Created by Paul Li on 2018-04-09.
//  Copyright © 2018 Paul Li. All rights reserved.
//

import Foundation
import UIKit

// The view controller will adopt this protocol (delegate)
// and thus must contain the keyWasTapped method
protocol KeyboardDelegate: class {
    func keyWasTapped(character: String)
    func keyDelete()
    func keyDone()
    func cshift(output: String)
}

class Keyboard: UIView {
    @IBOutlet weak var input: UILabel!
    @IBOutlet weak var converted: UILabel!
    
    var textFieldValue: String = ""
    
    // This variable will be set as the view controll er so that
    // the keyboard can send messages to the view controller.
    weak var delegate: KeyboardDelegate?
    
    // MARK:- keyboard initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews() {
        let xibFileName = "Keyboard" // xib extention not included
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)![0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
    }
    
    func updateInputLabelText(with newText: String) {
        input.text = newText
    }
    
    // MARK:- Button actions from .xib file
    @IBAction func keyTapped(_ sender: UIButton) {
        // When a button is tapped, send that information to the
        // delegate (ie, the view controller)
        let c = sender.titleLabel!.text!
        self.delegate?.keyWasTapped(character: c)
    }
    
    @IBAction func keySpace(_ sender: UIButton) {
        let c = " "
        self.delegate?.keyWasTapped(character: c)
    }
    
    @IBAction func keyDelete(_ sender: UIButton) {
        self.delegate?.keyDelete()
    }
    
    @IBAction func keyDone(_ sender: UIButton) {
        self.delegate?.keyDone()
    }
    
    @IBAction func keyCaesar(_ sender: UIButton) {
        var output = ""
        for i: UInt32 in 0...25 {
            output.append(String(i))
            output.append(" ")
            output.append(CaesarConv.shiftText(text: input.text!, shiftBy: i))
            output.append("\n")
        }
        self.delegate?.cshift(output: output)
    }

    @IBAction func keyBinary(_ sender: UIButton) {
        let regexPattern = "[^01 ]"
        let regex = try! NSRegularExpression(pattern: regexPattern, options: [])
        let matches = regex.matches(in: input.text!, options: [], range: NSRange(location: 0, length: (input.text?.count)!))
        
        if matches.count > 0 { // not binary
            converted.text = BinaryConv.asciiToBinary(ascii: input.text!)
        }
        else
        {
            converted.text = BinaryConv.binaryToAscii(binary: input.text!)
        }
    }

    
    
}
