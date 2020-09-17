//
// InfoViewController.swift
// VocabularyCards
//
// Created by: Pratik Hirve on 17/09/20
// MIT License
// Copyright (c) 2020 Pratik-H
//

import UIKit

class InfoViewController: VocabularyCardsViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var infoTextView: UITextView!
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    // MARK: - Parameters
    var infotext: String?
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        infoTextView.text = infotext
    }
    
}
