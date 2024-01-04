//
//  ViewController.swift
//  Project2
//
//  Created by gayeugur on 26.11.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: @IBOUTLET
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    //MARK: PROPERTIES
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var questionNumber = 0

    //MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: FUNCTIONS
    private func setup() {
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        initButtonStyle()
        askQuestion()
    }
    
    private func initButtonStyle() {
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1

        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        questionNumber += 1
        countries.shuffle()

        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)

        correctAnswer = Int.random(in: 0...2)
        title = countries[correctAnswer].uppercased()
    }
    
    func showAlert(title: String, buttonTitle: String) {
        let ac = UIAlertController(title: title, message: "Question Number \(questionNumber) and your score is \(score).", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: askQuestion))
        present(ac, animated: true)
    }

    //MARK: @IBACTION
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String

        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
        if questionNumber == 10 {
            showAlert(title: title, buttonTitle: "Restart")
            questionNumber = 0
            score = 0
        } else {
            showAlert(title: title, buttonTitle: "Continue")
        }
       
    }

}

