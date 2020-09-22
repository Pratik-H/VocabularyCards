//
// CommonMethods.swift
// VocabularyCards
//
// Created by: Pratik Hirve on 22/09/20
// MIT License
// Copyright (c) 2020 Pratik-H
//

import Foundation
import UIKit

func generateImpactFeedBack(style: UIImpactFeedbackGenerator.FeedbackStyle = .soft) {
    let generator = UIImpactFeedbackGenerator(style: style)
    generator.impactOccurred()
}
