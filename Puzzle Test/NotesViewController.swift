//
//  NotesViewController.swift
//  Puzzle Test
//
//  Created by Paul Li on 2018-04-10.
//  Copyright © 2018 Paul Li. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {
    @IBOutlet weak var cs: UITextView!
    
    var dataFromMain :String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        cs.text = dataFromMain
        navigationItem.title = "Conversion Results"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func goBack(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func helpButtonPressed(_ sender: UIButton) {
        let helpString = "Caesar cipher"
        
        let escapedText = helpString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        guard let url = URL(string: "https://www.google.com/search?q=" + escapedText!) else {
            return
        }
        
        UIApplication.shared.canOpenURL(url)
        UIApplication.shared.open(url)
    }
}

