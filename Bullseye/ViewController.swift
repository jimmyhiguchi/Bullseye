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
        
        // custom slider button
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHiglighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHiglighted, for: .highlighted)
        
        // custom slider
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
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

        currentValue = Int(slider.value)
    }
    
    // dialog or alert box
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

        let message = "You scored: \(points + bonus) points"
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
        let action = UIAlertAction(title: "Ok", style: .default, handler: {
            action in
            self.startNewRound()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func startOver() {
        
        roundCount = 0
        score = 0
        
        startNewRound()
    }

}

