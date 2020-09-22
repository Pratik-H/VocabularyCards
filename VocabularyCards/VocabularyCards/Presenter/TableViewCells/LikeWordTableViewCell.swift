//
// LikeWordTableViewCell.swift
// VocabularyCards
//
// Created by: Pratik Hirve on 22/09/20
// MIT License
// Copyright (c) 2020 Pratik-H
//

import UIKit

class LikeWordTableViewCell: UITableViewCell {

    @IBOutlet weak var titleTextView: UITextView!
    
    @IBOutlet weak var meaningTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

}
