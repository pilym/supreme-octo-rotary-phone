//
//  ViewController.swift
//  Puzzle Test
//
//  Created by Paul Li on 2018-04-06.
//  Copyright © 2018 Paul Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController, KeyboardDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var levelName: UILabel!
    @IBOutlet weak var answerInput: UITextField!
    @IBOutlet weak var hiddenLabel: UILabel!
    
    var activeTextField = UITextField()
    var mainKeyboard: Keyboard = Keyboard()
    var level: Int = 1
    var notesData: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.answerInput.delegate = self
        
        // initialize custom keyboard
        let keyboardView = Keyboard(frame: CGRect(x: 0, y: 0, width: 0, height: 290))
        keyboardView.delegate = self // the view controller will be notified by the keyboard whenever a key is tapped
        
        mainKeyboard = keyboardView
        
        // replace system keyboard with custom keyboard
        answerInput.inputView = keyboardView
        
        self.becomeFirstResponder()
        
        hiddenLabel.isHidden = true
        setLevelTitle()
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
        checkAnswer(answer: answerInput.text!)
    }
    
    func cshift(output: String) {
        notesData = output
        performSegue(withIdentifier: "notesSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC : NotesViewController = segue.destination as! NotesViewController
        destVC.dataFromMain = notesData
    }
    
    // We are willing to become first responder to get shake motion
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    // Enable detection of shake motion
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            switch level {
            case 1:
                hiddenLabel.isHidden = false
                break
            default:
                break
            }
        }
    }
    
    // actual game stuff here
    func checkAnswer(answer: String) {
        switch level {
        case 1:
            if answer.uppercased() == "WHITE HOUSE" {
                hiddenLabel.text = "You win!!!!"
                goToNextLevel()
            }
            break
        default:
            break
        }
    }
    
    func goToNextLevel() {
        level += 1
        setLevelTitle()
    }
    
    func setLevelTitle() {
        switch level {
        case 1:
            levelName.text = "It's not a Tapping Game"
            break
        case 2:
            levelName.text = "You Win!!!!!!!!!!!!"
            break
        default:
            break
        }
    }
}

