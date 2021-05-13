//
//  ViewController.swift
//  EggTimer
//
//  Created by Damián Alvarez on 05/10/2021.
//  Copyright © 2021 Radium Rocket. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    let eggTime = [
        "Soft": 3, // 300,
        "Medium": 5,// 420,
        "Hard": 7//720
    ]
    
    var timer = Timer()
    var total = 0
    var secondsPassed = 0
    var player: AVAudioPlayer?

    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!

    @IBAction func hardnessSelected(_ sender: UIButton) {

        let hardness = sender.currentTitle!
        countDownLabel.text = hardness
        secondsPassed = 0
        progressBar.progress = 0.00
        total = eggTime[hardness]!

        // just in case this button is tapped multiple times
        timer.invalidate()

        // start the timer
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)

    }

    @objc func updateTimer() {

        secondsPassed += 1
        progressBar.progress = Float(secondsPassed) / Float(total)
        
        if secondsPassed == total {
            timer.invalidate()
            countDownLabel.text = "It's time!"
            progressBar.progress = 1
            playSound()
        }

    }
    
    func playSound() {

        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {

            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            guard let player = player else { return }

            player.play()

        } catch let error {
            print (error.localizedDescription)
        }

    }

}
