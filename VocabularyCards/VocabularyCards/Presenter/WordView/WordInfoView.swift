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
import Lottie

class WordInfoView: UIView {
    
    // MARK: - IBOutlet
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet var likeView: AnimationView! {
        didSet {
            likeView.layer.cornerRadius = likeView.frame.height / 2
            likeView.backgroundColor = .clear
            likeView.loopMode = .playOnce
            likeView.contentMode = .scaleAspectFill
        }
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
    
    // MARK: - IBAction
    @IBAction func likeViewAction(_ sender: UITapGestureRecognizer) {
        if isButtonSelected == true {
            animationStartStop = .stop
            isButtonSelected = false
            likeView.play(fromFrame: animationStartStop.rawValue.startFrame, toFrame: animationStartStop.rawValue.endFrame, loopMode: .playOnce, completion: {_ in
                /// - TODO: Add to dataBase
            })

        } else {
            isButtonSelected = true
            animationStartStop = .start
            likeView.play(fromFrame: animationStartStop.rawValue.startFrame, toFrame: animationStartStop.rawValue.endFrame, loopMode: .playOnce, completion: { _ in
                /// - TODO: remove from dataBase
            })
        }
    }
    
    
    @IBAction func speakButtonAction(_ sender: UIButton) {
        let speechUtterance = AVSpeechUtterance(string: wordLabel.text ?? "")
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        self.speechSynthesizer.speak(speechUtterance)
    }
    
   
    // MARK: - Parameters
    let speechSynthesizer = AVSpeechSynthesizer()
    var isButtonSelected: Bool = false
    
    enum AnimationStartStopValues {
        case start
        case stop
        
        var rawValue: (startFrame: CGFloat, endFrame: CGFloat) {
            switch self {
                case .start:
                return (CGFloat(0), CGFloat(72))
                case .stop:
                return (CGFloat(0), CGFloat(0))
            }
        }
    }
    
    var animationStartStop: AnimationStartStopValues = .stop
    
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
