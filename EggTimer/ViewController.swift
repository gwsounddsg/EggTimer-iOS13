//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let eggTime: [String: Float] = ["Soft": 3.0, "Medium": 4.0, "Hard": 7.0]
    var secondsRemaining: Float = 0.0
    var timer = Timer()
    var selectedCookTime: Float = 0.0
    
    @IBOutlet var label: UILabel!
    @IBOutlet var progressBar: UIProgressView!
    

    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        guard let time = eggTime[sender.currentTitle!] else {return}
        
        selectedCookTime = time
        secondsRemaining = time
        label.text = "Cooking..."
        
        progressBar.progress = 0.0
        progressBar.isHidden = false
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        secondsRemaining -= 1
        progressBar.progress = (selectedCookTime - secondsRemaining) / selectedCookTime
        
        if secondsRemaining > 0 {
            print("\(secondsRemaining) seconds")
        }
        else {
            label.text = "Done!"
            timer.invalidate()
        }
    }
}
