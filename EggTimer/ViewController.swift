//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let eggTime = [
        "Soft": 3, // 300,
        "Medium": 5,// 420,
        "Hard": 7//720
    ]
    var timer = Timer()
    var secondsRemaining = 60

    @IBOutlet weak var countDownLabel: UILabel!

    @IBAction func hardnessSelected(_ sender: UIButton) {
        print("Instantiate \(sender.currentTitle!)")
        let hardness = sender.currentTitle!

        secondsRemaining = eggTime[hardness]!
        // just in case this button is tapped multiple times
        timer.invalidate()
        // start the timer
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        secondsRemaining -= 1
        countDownLabel.text = String(secondsRemaining)

        if secondsRemaining == 0 {
            timer.invalidate()
            countDownLabel.text = "It's time!"
        }
    }
    
}
