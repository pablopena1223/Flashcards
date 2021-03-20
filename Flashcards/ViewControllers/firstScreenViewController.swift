//
//  ViewController.swift
//  Flashcards
//
//  Created by Pablo  Pena on 2/20/21.
//

import UIKit

// struct Flashcard, used to group properties and functions
struct Flashcard {
    var structQuestion: String
    var structAnswer: String
}

class firstScreenViewController: UIViewController {
    
    // cards is the view. questionLabel and answerLabel are underneath the cards view, kind of like a div and its children
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var cards: UIView!
    
    // show mulitple choice buttons
    @IBOutlet var answer1: UIButton!
    @IBOutlet var answer2: UIButton!
    @IBOutlet var answer3: UIButton!
    
    // prev and next Buttons
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    // array to hold out flashcards
    var flashcards = [Flashcard]()
    
    // keep track of current index in flashcards array
    var currentIndex = 0;
    
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
        
        // read in all saved flashcards
        readSavedFlashcards()
        
        // adding initial card if needed (if no cards are read in)
        if flashcards.count == 0 {
            updateFlashcard(question: "What is the capital of Brazil?", answer: "Brasilia", extraAnswerOne: "Rio de Janerio", extraAnswerTwo: "Sao Paulo")
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
        
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
    
    // Prev button
    @IBAction func didTapOnPrev(_ sender: Any) {
        // increase current index
        currentIndex = currentIndex - 1
        
        // update labels
        updateLabels()
        
        // update buttons
        updateNextPrevButtons()
    }
    
    // Next button
    @IBAction func didTapOnNext(_ sender: Any) {
        // increase current index
        currentIndex = currentIndex + 1
        
        // update labels
        updateLabels()
        
        // update buttons
        updateNextPrevButtons()
    }
    
    func updateLabels() {
        // get current flashcard
        let currentFlashcard = flashcards[currentIndex]
        
        //update labels
        questionLabel.text = currentFlashcard.structQuestion
        answerLabel.text = currentFlashcard.structAnswer
    }
    
    func updateNextPrevButtons() {
        // disable nextButton if at the end
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        
        // disable prevButton if at the beginning
        if currentIndex == 0 {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true 
        }
    }
    
    // used in connection with CreationView. If user presses done, a new question and answer will be shown on the flashcards. Extra answers are optional, thats why you have String? and not String
    func updateFlashcard(question: String, answer: String, extraAnswerOne: String?, extraAnswerTwo: String?){
        // define flashcard with struct Flashcard
        let flashcard = Flashcard(structQuestion: question, structAnswer: answer)
        // set Label(s) to their respective values, using stuch Flashcard
        questionLabel.text = flashcard.structQuestion
        answerLabel.text = flashcard.structAnswer
        
        // set button(s) to thier respective parameters. answer2 must be the correct answer
        answer1.setTitle(extraAnswerOne, for: .normal)
        answer2.setTitle(answer, for: .normal)
        answer3.setTitle(extraAnswerTwo, for: .normal)
        
        // adding flashcard to flashcards array
        flashcards.append(flashcard)
        
        // updating current index
        currentIndex = flashcards.count - 1
        
        // update buttons as we add new flashcards
        updateNextPrevButtons()
        
        // update labels. Goes last bc currentIndex needs to be updated first
        updateLabels()
        
        // save progress after each flahscard update
        saveAllFlashcardsToDisk()
        
        
    }
    
    func saveAllFlashcardsToDisk() {
        // from flashcards array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question":card.structQuestion, "answer":card.structAnswer]
        }
        
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        print("Flashcards saved")
    }
    
    func readSavedFlashcards() {
        // read dictionary array from disk (if any)
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]{
            // inside the if let statement. Here we know we have something in the dictionary array
            let savedCards = dictionaryArray.map { (dictionary) -> Flashcard in
                // we use ! bc we need to tell Swift we are 100% sure something is here
                return Flashcard(structQuestion: dictionary["question"]!, structAnswer: dictionary["answer"]!)
            }
            // put all of the read cards in our flashcards array
            flashcards.append(contentsOf: savedCards)
        }
        
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

