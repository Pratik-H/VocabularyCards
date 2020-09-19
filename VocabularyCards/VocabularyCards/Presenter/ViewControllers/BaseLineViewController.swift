//
// BaseLineViewController.swift
// VocabularyCards
//
// Created by: Pratik Hirve on 17/09/20
// MIT License
// Copyright (c) 2020 Pratik-H
//

import UIKit
import Koloda

class BaseLineViewController: UIViewController {
   
    // MARK: - IBOutlet
    @IBOutlet weak var kolodaView: KolodaView! {
        didSet {
            kolodaView.dataSource = self
            kolodaView.delegate = self
        }
    }
    
    
    @IBAction func revertButton(_ sender: UIButton) {
        kolodaView.revertAction()
    }
    
    
    // MARK: - Parameters
    var wordsData: Dictionary<String,String>? {
        didSet {
            self.wordKeys = wordsData?.map({$0.key})
            kolodaView.reloadData()
        }
    }
    
    let colourSet: [UIColor] = [#colorLiteral(red: 0.9803921569, green: 0.9215686275, blue: 0.8431372549, alpha: 1), #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.862745098, alpha: 1), #colorLiteral(red: 0.5490196078, green: 0.7137254902, blue: 0.8274509804, alpha: 1), #colorLiteral(red: 0.4117647059, green: 0.4117647059, blue: 0.4117647059, alpha: 1), #colorLiteral(red: 0.337254902, green: 0.6392156863, blue: 0.6745098039, alpha: 1), #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9803921569, alpha: 1), #colorLiteral(red: 0.4666666667, green: 0.5333333333, blue: 0.6, alpha: 1), #colorLiteral(red: 0.6901960784, green: 0.768627451, blue: 0.8705882353, alpha: 1), #colorLiteral(red: 1, green: 0.8705882353, blue: 0.6784313725, alpha: 1), #colorLiteral(red: 0.9607843137, green: 0.537254902, blue: 0.537254902, alpha: 1), #colorLiteral(red: 0.5490196078, green: 0.7137254902, blue: 1, alpha: 1), #colorLiteral(red: 0.8901960784, green: 0.8, blue: 0.768627451, alpha: 1)]
    
    var wordKeys: Array<String>?
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWords()
        print(RealmHelper.shared.getWords().map{$0.word})
        self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
    }
    
    private func loadWords() {
        if let path = Bundle.main.path(forResource: "WordDataBase", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String,String> {
                    self.wordsData = jsonResult
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - Extension
// MARK: KolodaViewDelegate, KolodaViewDataSource
extension  BaseLineViewController:  KolodaViewDelegate, KolodaViewDataSource {
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let wordInfoView: WordInfoView = .fromNib()
        wordInfoView.configureView(title: wordKeys?[index].capitalizingFirstLetter() ?? "", meaning:  wordsData?[wordKeys?[index] ?? ""] ?? "")
        wordInfoView.containerView.backgroundColor = colourSet[Int.random(in: 0..<colourSet.count)]
        return wordInfoView
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return wordKeys?.count ?? 0
    }
    
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }
}

