//
//  ViewController.swift
//  Puzzle Test
//
//  Created by Paul Li on 2018-04-06.
//  Copyright © 2018 Paul Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController, KeyboardDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var cs: UITextView!
    
    var activeTextField = UITextField()
    var mainKeyboard: Keyboard = Keyboard()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.textField.delegate = self
        
        // initialize custom keyboard
        let keyboardView = Keyboard(frame: CGRect(x: 0, y: 0, width: 0, height: 290))
        keyboardView.delegate = self // the view controller will be notified by the keyboard whenever a key is tapped
        
        mainKeyboard = keyboardView
        
        // replace system keyboard with custom keyboard
        textField.inputView = keyboardView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // required method for keyboard delegate protocol
    func keyWasTapped(character: String) {
        activeTextField.insertText(character)
        mainKeyboard.updateInputLabelText(with: activeTextField.text!)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Setting Active Textfield")
        self.activeTextField = textField
        print("Active textField Set!")
    }
    
    func keyDelete() {
        activeTextField.deleteBackward()
        mainKeyboard.updateInputLabelText(with: activeTextField.text!)
    }
    
    func keyDone() {
        view.endEditing(true)
    }
    
    func cshift(output: String) {
        cs.text = output
    }
}

