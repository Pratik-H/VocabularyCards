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

protocol WordInfoViewProtocol: class {
    func didLikeWord(frame: CGRect)
}

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
    
    @IBOutlet weak var titleTextField: UITextView! {
        didSet {
            titleTextField.backgroundColor = .clear
        }
    }
    @IBOutlet weak var meaningTextField: UITextView! {
        didSet {
            meaningTextField.textAlignment = .center
            meaningTextField.backgroundColor = .clear
        }
    }

    // MARK: - IBAction
    @IBAction func likeViewAction(_ sender: UITapGestureRecognizer) {
        generateImpactFeedBack()
        if isButtonSelected == false {
            guard let likeViewFrame =  self.likeView.globalFrame else {return}
            self.delegate?.didLikeWord(frame: likeViewFrame)
        }
        animateLikeView()
    }
    
    
    @IBAction func speakButtonAction(_ sender: UIButton) {
        let speechUtterance = AVSpeechUtterance(string: titleTextField.text ?? "")
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        self.speechSynthesizer.speak(speechUtterance)
    }
    
   
    // MARK: - Parameters
    let speechSynthesizer = AVSpeechSynthesizer()
    var isButtonSelected: Bool = false
    weak var delegate: WordInfoViewProtocol?
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        animateLikeView()
    }
    
    func configureView(title: String, meaning: String) {
        titleTextField.text = title
        meaningTextField.text = meaning
        isButtonSelected = RealmHelper.shared.getWord(byTitle: title).bool
        animationStartStop = isButtonSelected == true ? .start : .stop
        likeView.play(fromFrame: animationStartStop.rawValue.startFrame, toFrame: animationStartStop.rawValue.endFrame, loopMode: .playOnce, completion: nil)
    }
    
    
    func animateLikeView() {
        if isButtonSelected == true {
            guard let title = titleTextField.text, title.isEmpty == false else {return}
            animationStartStop = .stop
            isButtonSelected = false
            likeView.play(fromFrame: animationStartStop.rawValue.startFrame, toFrame: animationStartStop.rawValue.endFrame, loopMode: .playOnce, completion: {_ in
                RealmHelper.shared.delete(word: title)
            })
            
        } else {
            guard let title = titleTextField.text, title.isEmpty == false,
                  let meaning = meaningTextField.text, meaning.isEmpty == false else {return}
            isButtonSelected = true
            animationStartStop = .start
            likeView.play(fromFrame: animationStartStop.rawValue.startFrame, toFrame: animationStartStop.rawValue.endFrame, loopMode: .playOnce, completion: { _ in
                RealmHelper.shared.addToRealm(word: title, meaning: meaning)
            })
        }
    }

}
