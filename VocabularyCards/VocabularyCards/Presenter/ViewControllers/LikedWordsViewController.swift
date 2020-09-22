//
// LikedWordsViewController.swift
// VocabularyCards
//
// Created by: Pratik Hirve on 22/09/20
// MIT License
// Copyright (c) 2020 Pratik-H
//

import UIKit
import Koloda

class LikedWordsViewController: UIViewController {
    
    @IBOutlet weak var likedWordsParentContainer: UIView! {
        didSet {
            likedWordsParentContainer.isHidden = true
            likedWordsParentContainer.alpha = 0
        }
    }
    
    @IBOutlet weak var wordKolodaView: KolodaView! {
        didSet {
            wordKolodaView.dataSource = self
            wordKolodaView.delegate = self
        }
    }
    
    
    // MARK: - IBAction
    @IBAction func revertButton(_ sender: UIButton) {
        wordKolodaView.revertAction()
    }
    
    @IBAction func cardViewSwitchAction(_ sender: UISwitch) {
        UIView.animate(
            withDuration: 0.7,
            delay: 0.05 ,
            animations: {
                self.tableView.alpha = self.tableView.alpha == 1 ? 0 : 1
                self.tableView.isHidden.toggle()
                self.likedWordsParentContainer.alpha = self.likedWordsParentContainer.alpha == 1 ? 0 : 1
                self.likedWordsParentContainer.isHidden.toggle()
            })
        
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.alpha = 1
            tableView.isHidden = false
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    // MARK: - Parameters
    var likedWords: [Word] = RealmHelper.shared.getWords()
    let colourSet: [UIColor] = [#colorLiteral(red: 0.9803921569, green: 0.9215686275, blue: 0.8431372549, alpha: 1), #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.862745098, alpha: 1), #colorLiteral(red: 0.5490196078, green: 0.7137254902, blue: 0.8274509804, alpha: 1), #colorLiteral(red: 0.4117647059, green: 0.4117647059, blue: 0.4117647059, alpha: 1), #colorLiteral(red: 0.337254902, green: 0.6392156863, blue: 0.6745098039, alpha: 1), #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9803921569, alpha: 1), #colorLiteral(red: 0.4666666667, green: 0.5333333333, blue: 0.6, alpha: 1), #colorLiteral(red: 0.6901960784, green: 0.768627451, blue: 0.8705882353, alpha: 1), #colorLiteral(red: 1, green: 0.8705882353, blue: 0.6784313725, alpha: 1), #colorLiteral(red: 0.9607843137, green: 0.537254902, blue: 0.537254902, alpha: 1), #colorLiteral(red: 0.5490196078, green: 0.7137254902, blue: 1, alpha: 1), #colorLiteral(red: 0.8901960784, green: 0.8, blue: 0.768627451, alpha: 1)]
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

// MARK: - Extension
// MARK:  UITableViewDelegate, UITableViewDataSource
extension LikedWordsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likedWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LikeWordTableViewCell") as? LikeWordTableViewCell else {return UITableViewCell()}
        cell.titleTextView.text = likedWords[indexPath.row].word
        cell.meaningTextView.text = likedWords[indexPath.row].meaning
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            generateImpactFeedBack(style: .medium)
            RealmHelper.shared.delete(word: likedWords[indexPath.row].word)
            likedWords.remove(at: indexPath.row)
            UIView.animate(
                withDuration: 0.7,
                delay: 0.05 * Double(indexPath.row),
                animations: {
                    self.tableView.reloadData()
                    self.wordKolodaView.reloadData()
                })
            
            
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        
        UIView.animate(
            withDuration: 0.7,
            delay: 0.05 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
            })
    }
}
// MARK: KolodaViewDelegate, KolodaViewDataSource
extension  LikedWordsViewController:  KolodaViewDelegate, KolodaViewDataSource {
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let wordInfoView: WordInfoView = .fromNib()
        wordInfoView.configureView(title: likedWords[index].word, meaning:  likedWords[index].meaning)
        wordInfoView.containerView.backgroundColor = colourSet[Int.random(in: 0..<colourSet.count)]
        return wordInfoView
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return likedWords.count
    }
    
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }
}
