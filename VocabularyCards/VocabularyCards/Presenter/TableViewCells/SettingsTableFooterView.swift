//
// SettingsTableFooterView.swift
// VocabularyCards
//
// Created by: Pratik Hirve on 17/09/20
// MIT License
// Copyright (c) 2020 Pratik-H
//

import UIKit

class SettingsTableFooterView: UITableViewHeaderFooterView {
    @IBOutlet weak var versionNumberLabel: UILabel! {
        didSet {
            versionNumberLabel.text = "version \((Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "")"
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
