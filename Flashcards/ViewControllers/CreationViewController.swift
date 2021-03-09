//
//  CreatoinViewController.swift
//  Flashcards
//
//  Created by Pablo  Pena on 3/8/21.
//

import UIKit

class CreationViewController: UIViewController {
    
    // connect CreationView to firstScreenView
    var flashcardsController: firstScreenViewController!
    // IBOutlet for required text fields
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    // IBOutlet for optional text fields
    @IBOutlet weak var extraAnswerOneTextField: UITextField!
    @IBOutlet weak var extraAnswerTwoTextField: UITextField!
    // if pencilEmoji is pressed then store default strings in textFields
    var initialQuestion: String?
    var initialAnswer: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
    }
    
    // cancel button on top left. If pressed will dismiss the page
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    // done button on top right
    @IBAction func didTapOnDone(_ sender: Any) {
        // store required textFields inside of variables
        let questionText = questionTextField.text
        let answerText = answerTextField.text
        // store optional textFields inside of variables
        let extraAnswerOneText = extraAnswerOneTextField.text
        let extraAnswerTwoText = extraAnswerTwoTextField.text
        
        // if done is pressed, we expect questionTextField and answerTextField to have values. If they dont we will alert them
        let alert = UIAlertController(title: "Missing text", message: "You need to enter both a question and an answer", preferredStyle: UIAlertController.Style.alert)
        // we want the alert to stay on screen until "Ok" is pressed, without this, the alert will just be dismissed in a second
        let okAction = UIAlertAction(title: "Ok", style: .default)
        
        // we check if the required TextFields have values
        if questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty {
            // if this dont have values we alert them
            alert.addAction(okAction)
            present(alert, animated: true)
        } else {
            // if they do have values we update firstScreenView with this function
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, extraAnswerOne: extraAnswerOneText!, extraAnswerTwo: extraAnswerTwoText!)
            // and we dismiss the page 
            dismiss(animated: true)
        }
            
    }
    
}
