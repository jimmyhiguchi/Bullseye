//
//  ViewController.swift
//  Bullseye
//
//  Created by Jimmy Higuchi on 10/13/17.
//  Copyright © 2017 Jimmy Higuchi. All rights reserved.
//

import UIKit

//global variables

class ViewController: UIViewController {
    
    //instance variables
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    var currentValue = 0
    var targetValue = 0
    var roundCount = 0
    var score = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentValue = Int(slider.value)
        startNewRound()
    }
    
    // method for new round
    func startNewRound() {
        
        currentValue = 50
        targetValue = 1 + Int(arc4random_uniform(100))
        roundCount += 1
        slider.value = Float(currentValue)
        updateLabels()
        
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(roundCount)
    }
    
    
    // method for slider
    @IBAction func sliderMoved(_ slider: UISlider) {
        
        print("Slider value is: \(slider.value)")
        currentValue = Int(slider.value)
    }
    
    @IBAction func showAlert() {
        
        //calculate the difference
        let difference = abs(targetValue - currentValue)
        let points = 100 - difference
        var bonus = 0
        
        if difference == 0 {
            bonus = 100
        } else if difference == 1 {
            bonus = 50
        }
        score = score + points + bonus
        
        let message = "You scored: \(score) points"
        let title: String
        
        if difference == 0 {
            title = "Perfect!"
        } else if difference < 5 {
            title = "You almost had it!"
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        
        // creates dialog box
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // this creates the button on the bottom of the dialog box
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        startNewRound()
    }

}

