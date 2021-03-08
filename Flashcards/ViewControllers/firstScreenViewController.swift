//
//  ViewController.swift
//  Flashcards
//
//  Created by Pablo  Pena on 2/20/21.
//

import UIKit

class firstScreenViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var cards: UIView!
    
    
    @IBOutlet var answer1: UIButton!
    @IBOutlet var answer2: UIButton!
    @IBOutlet var answer3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cards.layer.cornerRadius = 20.0
        questionLabel.layer.cornerRadius = 20.0
        answerLabel.layer.cornerRadius = 20.0
        
        questionLabel.clipsToBounds = true
        answerLabel.clipsToBounds = true
                
        cards.layer.shadowRadius = 13.0
        cards.layer.shadowOpacity = 0.4
        
        answer1.layer.borderWidth = 2.0
        answer1.layer.borderColor = #colorLiteral(red: 0.3568627451, green: 0.5176470588, blue: 0.6941176471, alpha: 1)
        answer1.layer.cornerRadius = 10.0
        
        answer2.layer.borderWidth = 2.0
        answer2.layer.borderColor = #colorLiteral(red: 0.3568627451, green: 0.5176470588, blue: 0.6941176471, alpha: 1)
        answer2.layer.cornerRadius = 10.0

        answer3.layer.borderWidth = 2.0
        answer3.layer.borderColor = #colorLiteral(red: 0.3568627451, green: 0.5176470588, blue: 0.6941176471, alpha: 1)
        answer3.layer.cornerRadius = 10.0
        
    }
    
 
// Part of the required steps, deleted the Tap Gesture. If you want to see it work, attatch the Tap Gesture to the view w the flash cards
//    @IBAction func tapOnFlashcard(_ sender: Any) {
//        if questionLabel.isHidden == false {
//            questionLabel.isHidden = true
//        }
//        else{
//            questionLabel.isHidden = false
//        }
//    }
    
    
    @IBAction func didTapAns1(_ sender: Any) {
        answer1.isHidden = true
    }
    
    @IBAction func didTapAns2(_ sender: Any) {
        answer1.isHidden = true
        answer2.isHidden = true
        answer3.isHidden = true
        questionLabel.isHidden = true
    }
    
    @IBAction func didTapAns3(_ sender: Any) {
        answer3.isHidden = true
    }
    
    func updateFlashcard(question: String, answer: String){
        questionLabel.text = question
        answerLabel.text = answer
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
    }
}

