//
//  ViewController.swift
//  RAFFotografic
//
//  Created by Volare on 3/14/21.
//  Copyright © 2021 Raf. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var imageView: UIImageView!
    var store: PhotoStore!
    override func loadView() {
        super.loadView()
        imageView = UIImageView()
        let constraints = [
            imageView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ]
//        imageView.layer.borderWidth = 2
//        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.backgroundColor = .red
        configureView(imageView, parent: self.view, constraints: constraints)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .systemBackground
        setupViewController()
        store.fetchInterestingPhotos {
            result in
            switch result {
            case .success(let photos):
                let dates = photos.compactMap { (photo) in
                    photo.dateTaken
                }
                dates.forEach { print($0) }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    private func setupViewController() {
        self.title = "Home"
    }
}


