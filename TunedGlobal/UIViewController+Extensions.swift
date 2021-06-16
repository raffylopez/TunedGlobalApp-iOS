//
//  UIViewController+Extensions.swift
//  TunedGlobal
//
//  Copyright © 2021 Raf. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func configureView<T: UIView, U: UIView>(_ view: T, parent: U?, constraints: [NSLayoutConstraint] = []) {
        view.translatesAutoresizingMaskIntoConstraints = false
        parent?.addSubview(view)
        if !constraints.isEmpty {
            NSLayoutConstraint.activate(constraints)
            return
        }
        view.sizeToFit()
        if let parent = parent {
            view.center = parent.center
        }
    }

}
