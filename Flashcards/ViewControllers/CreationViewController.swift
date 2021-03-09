//
//  CreatoinViewController.swift
//  Flashcards
//
//  Created by Pablo  Pena on 3/8/21.
//

import UIKit

class CreationViewController: UIViewController {
    
    var flashcardsController: firstScreenViewController!
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    
    var initialQuestion: String?
    var initialAnswer: String?
    
    @IBOutlet weak var extraAnswerOneTextField: UITextField!
    @IBOutlet weak var extraAnswerTwoTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        let questionText = questionTextField.text
        let answerText = answerTextField.text
        
        let extraAnswerOneText = extraAnswerOneTextField.text
        let extraAnswerTwoText = extraAnswerTwoTextField.text
        
        let alert = UIAlertController(title: "Missing text", message: "You need to enter both a question and an answer", preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default)
        
        if questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty {
            alert.addAction(okAction)
            present(alert, animated: true)
        } else {
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, extraAnswerOne: extraAnswerOneText!, extraAnswerTwo: extraAnswerTwoText!)
            
            dismiss(animated: true)
        }
            
    }
    
}
