//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation





class ViewController: UIViewController {
    
    let eggTime: [String: Float] = ["Soft": 10.0, "Medium": 420.0, "Hard": 720.0]
    let alarmURL = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")!
    
    var secondsRemaining: Float = 0.0
    var timer = Timer()
    var selectedCookTime: Float = 0.0
    var player: AVAudioPlayer?
    
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
        progressBar.setProgress((selectedCookTime - secondsRemaining) / selectedCookTime, animated: true)
        
        if secondsRemaining > 0 {
            print("\(secondsRemaining) seconds")
        }
        else {
            label.text = "Done!"
            timer.invalidate()
            
            player = try? AVAudioPlayer(contentsOf: alarmURL)
            player?.play()
        }
    }
}
