//
//  ViewController.swift
//  Flashcards
//
//  Created by Pablo  Pena on 2/20/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func didTapOnFlashCard(_ sender: Any) {
        questionLabel.isHidden = true
    }
}

