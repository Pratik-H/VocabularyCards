//
// Word.swift
// VocabularyCards
//
// Created by: Pratik Hirve on 19/09/20
// MIT License
// Copyright (c) 2020 Pratik-H
//

import Foundation
import RealmSwift

class Word: Object {
    @objc dynamic var word = ""
    @objc dynamic var meaning = ""
    
    override class func primaryKey() -> String? {
        return "word"
    }
}
