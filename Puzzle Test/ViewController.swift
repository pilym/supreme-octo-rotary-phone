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
    @IBOutlet weak var mainTextView: UILabel!
    @IBOutlet weak var button1: UIButton!
    
    
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
        
        initGame()
        setupLevel()
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
        self.activeTextField = textField
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
    
    // actual game stuff here
    func initGame() {
        hiddenLabel.isHidden = true
    }
    
    func setupLevel() {
        switch level {
        case 1:
            mainTextView.text = """
            How to play:
            Find the secret word (case insensitive) on each level and enter it in the textfield at the top to go to the next level.
            """
            button1.setTitle("Got it", for: .normal)
            break
        case 2:
            button1.isHidden = true
            mainTextView.text = ""
            break
        case 3:
            mainTextView.text = """
            Changes to game:
            G8: 1 -> 0
            A5: 0 -> 1
            M8: 1 -> 0
            E5: 0 -> 1
            """
            break
        default:
            break
        }
    }
    
    // respond to shakes
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            switch level {
            case 2:
                hiddenLabel.isHidden = false
                break
            default:
                break
            }
        }
    }
    
    @IBAction func button1Pressed(_ sender: UIButton) {
        switch level {
        case 1:
            button1.isEnabled = false
            button1.setTitle("enter", for: .normal)
            break
        default:
            break
        }
    }
    
    func checkAnswer(answer: String) {
        switch level {
        case 1:
            if answer.uppercased() == "ENTER" {
                goToNextLevel()
            }
            break
        case 2:
            if answer.uppercased() == "WHITE HOUSE" {
                goToNextLevel()
            }
            break
        case 3:
            if answer.uppercased() == "FILM" {
                mainTextView.text = "You Win!!!!!!!!!!!!"
                goToNextLevel()
            }
            break
        default:
            break
        }
    }
    
    func goToNextLevel() {
        level += 1
        hiddenLabel.isHidden = true
        setLevelTitle()
        setupLevel()
    }
    
    func setLevelTitle() {
        switch level {
        case 1:
            levelName.text = "Start"
            break
        case 2:
            levelName.text = "It's not a tapping game"
            break
        case 3:
            levelName.text = "Changelog"
            break
        case 4:
            levelName.text = "You Win!!!!!!!!!!!!"
            break
        default:
            break
        }
    }
}

