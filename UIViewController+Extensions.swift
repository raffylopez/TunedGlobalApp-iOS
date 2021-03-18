//
//  UIViewController+Extensions.swift
//  RAFFotografic
//
//  Created by Volare on 3/14/21.
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
