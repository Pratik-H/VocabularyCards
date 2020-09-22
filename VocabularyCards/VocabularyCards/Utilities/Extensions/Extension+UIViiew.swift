//
// Extension+UIViiew.swift
// VocabularyCards
//
// Created by: Pratik Hirve on 17/09/20
// MIT License
// Copyright (c) 2020 Pratik-H
//

import Foundation
import UIKit

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    var globalFrame: CGRect? {
        let rootView = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        return self.superview?.convert(self.frame, to: rootView)
    }
}
