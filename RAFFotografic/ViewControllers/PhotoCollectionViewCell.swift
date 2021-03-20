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
    
    func update (displaying image: UIImage?) {
        if let imageToDisplay = image {
            spinner.stopAnimating()
            imageView.image = image
            return
        }
        spinner.startAnimating()
        imageView.image = nil
    }
    
}
