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
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        self.speechSynthesizer.speak(speechUtterance)
    }
    @IBOutlet weak var wordLabel: UILabel! {
        didSet {
            if #available(iOS 13.0, *) {
                if self.traitCollection.userInterfaceStyle == .dark {
                    wordLabel.textColor = .black
                } else {
                    wordLabel.textColor = .black
                }
            }
        }
    }
    
    @IBOutlet weak var meaningLabel: UILabel! {
        didSet {
            if #available(iOS 13.0, *) {
                if self.traitCollection.userInterfaceStyle == .dark {
                    meaningLabel.textColor = .black
                } else {
                    meaningLabel.textColor = .black
                }
            }
        }
    }
    
    // MARK: - Parameters
    let speechSynthesizer = AVSpeechSynthesizer()
    
    // MARK: - Methods
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 10
    }
    
    init() {
        super.init(frame: CGRect.zero)
        layer.cornerRadius = 10
    }
}
