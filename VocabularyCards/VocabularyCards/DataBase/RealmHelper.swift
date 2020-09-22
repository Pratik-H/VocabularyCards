//
// RealmHelper.swift
// VocabularyCards
//
// Created by: Pratik Hirve on 19/09/20
// MIT License
// Copyright (c) 2020 Pratik-H
//

import Foundation
import RealmSwift

/// - TODO: Make Generic
class RealmHelper {
    
    // MARK: - Parameters
    static var shared: RealmHelper = RealmHelper()
    private let realm = try! Realm()
    
    // MARK: - Methods
    func addToRealm(word: String, meaning: String) {
        if realm.objects(Word.self).filter({$0.word == word}).count == 0 {
            let newWord = Word()
            newWord.word = word
            newWord.meaning = meaning
            do {
                try realm.write {
                    realm.add(newWord)
                    print("saved")
                }
            } catch {
                print(error)
            }
        }
        
    }
    
    func delete(word: String) {
        guard let wordObject = realm.objects(Word.self).filter({$0.word == word}).first else {return}
        do {
            try realm.write {
                realm.delete(wordObject)
                print("deleted")
            }
        } catch {
            print(error)
        }
    }
    
    func getWords() -> [Word] {
        let object = Array(realm.objects(Word.self))
        return object
    }
    
    
    func getWord(byTitle: String) -> (bool: Bool, value: String) {
        if let wordObject = Array(realm.objects(Word.self).filter({$0.word == byTitle})).first {
            return (true, wordObject.word)
        } else {
            return (false, "")
        }
    }
}
