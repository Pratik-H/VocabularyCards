//
// WordInfoView.swift
// VocabularyCards
//
// Created by: Pratik Hirve on 17/09/20
// MIT License
// Copyright (c) 2020 Pratik-H
//

import UIKit
import AVFoundation

class WordInfoView: UIView {
    
    // MARK: - IBOutlet
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 10
        }
    }
    
    @IBAction func speakButtonAction(_ sender: UIButton) {
        let speechUtterance = AVSpeechUtterance(string: wordLabel.text ?? "")
        speechUtterance.rate = 0.5
        speechUtterance.pitchMultiplier = 0.25
        speechUtterance.volume = 0.75
        speechUtterance.voice = AVSpeechSynthesisVoice(identifier: "Karen")
        self.speechSynthesizer.speak(speechUtterance)
    }
    @IBOutlet weak var wordLabel: UILabel!
    
    @IBOutlet weak var meaningLabel: UILabel!
    
    let speechSynthesizer = AVSpeechSynthesizer()
    // MARK: - Methods
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init() {
        super.init(frame: CGRect.zero)
        layer.cornerRadius = 10
    }
    
    
}
