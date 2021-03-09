//
//  ViewController.swift
//  Flashcards
//
//  Created by Pablo  Pena on 2/20/21.
//

import UIKit

class firstScreenViewController: UIViewController {
    
    // cards is the view. questionLabel and answerLabel are underneath the cards view, kind of like a div and its children
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var cards: UIView!
    
    // show mulitple choice buttons
    @IBOutlet var answer1: UIButton!
    @IBOutlet var answer2: UIButton!
    @IBOutlet var answer3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // style Cards(View), shadow and corners
        // if you want both rounded corners and shadows must follow specific rules, look back at notes
        cards.layer.cornerRadius = 20.0
        questionLabel.layer.cornerRadius = 20.0
        answerLabel.layer.cornerRadius = 20.0
        
        questionLabel.clipsToBounds = true
        answerLabel.clipsToBounds = true
                
        cards.layer.shadowRadius = 13.0
        cards.layer.shadowOpacity = 0.4
        
        // style the buttons
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
    
 
// Part of the required steps. If you want to see it work, attatch the tapGesture to this IBAction. (un)Click enable under the "brains" in the tapGesture
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if questionLabel.isHidden == false {
            questionLabel.isHidden = true
        }
        else{
            questionLabel.isHidden = false
        }
    }
    
    // ans1 is incorrect, if tapped will disappear
    @IBAction func didTapAns1(_ sender: Any) {
        answer1.isHidden = true
    }
    
    // ans2 is correct, if tapped all choices will disapear and show answerLabel
    @IBAction func didTapAns2(_ sender: Any) {
        answer1.isHidden = true
        answer2.isHidden = true
        answer3.isHidden = true
        questionLabel.isHidden = true
    }
    
    // ans3 is incorrect, if tapped will disappear
    @IBAction func didTapAns3(_ sender: Any) {
        answer3.isHidden = true
    }
    
    // used in connection with CreationView. If user presses done, a new question and answer will be shown on the flashcards. Extra answers are optional, thats why you have String? and not String
    func updateFlashcard(question: String, answer: String, extraAnswerOne: String?, extraAnswerTwo: String?){
        // set Label(s) to their respective parameters
        questionLabel.text = question
        answerLabel.text = answer
        
        // set button(s) to thier respective parameters. answer2 must be the correct answer
        answer1.setTitle(extraAnswerOne, for: .normal)
        answer2.setTitle(answer, for: .normal)
        answer3.setTitle(extraAnswerTwo, for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // we know the destination of the segue is the NavigationController
        let navigationController = segue.destination as! UINavigationController
        // we know the NavigationController onlt contains a CreationViewController
        let creationController = navigationController.topViewController as! CreationViewController
        // we set the flashCardsController property to self
        creationController.flashcardsController = self
        
        // when user clicks the emoji pencil, the questionTextField will be the default questionLabel.text, same for answer. If the '+' button then the textFields will just be blank
        // we named the pencilEmoji segue "EditSegue"
        if segue.identifier == "EditSegue" {
            creationController.initialQuestion = questionLabel.text
            creationController.initialAnswer = answerLabel.text
        }
    }
}

