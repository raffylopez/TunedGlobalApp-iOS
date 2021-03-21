//
//  PhotoCollectionViewCell.swift
//  RAFFotografic
//
//  Created by Volare on 3/19/21.
//  Copyright © 2021 Raf. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var spinner: UIActivityIndicatorView!

    fileprivate func makeImageVisible(img: UIImage) {
        self.imageView.layer.opacity = 1
        self.imageView.image = img
    }
    
    func update(displaying image: (UIImage, ImageSource)?) {
        if let imageResultSet = image {
            let imageToDisplay = imageResultSet.0
            let imageSource = imageResultSet.1
            spinner.stopAnimating()
            switch imageSource {
            case .network:
                UIView.animate(withDuration: 2) {
                    self.makeImageVisible(img: imageToDisplay)
                }
            case .cache:
                makeImageVisible(img: imageToDisplay)
            }
            return
        }
        spinner.startAnimating()
        imageView.layer.opacity = 0
        imageView.image = nil
    }

}
