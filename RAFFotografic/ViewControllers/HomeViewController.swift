//
//  ViewController.swift
//  RAFFotografic
//
//  Created by Volare on 3/14/21.
//  Copyright © 2021 Raf. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var segmentedControl: UISegmentedControl!
    var imageView: UIImageView!
    var store: PhotoStore!
    
    override func loadView() {
        super.loadView()
        setupViews()
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            store.fetchPhotos(endpoint: .interestingPhotos) {
                result in
                switch result {
                case .success(let photos):
                    print("Successfully found \(photos.count) photos.")
                    if let firstPhoto = photos.first {
                        self.updateImageView(for: firstPhoto)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        case 1:
            store.fetchPhotos(endpoint: .recentPhotos) {
                result in
                switch result {
                case .success(let photos):
                    print("Successfully found \(photos.count) photos.")
                    if let firstPhoto = photos.first {
                        self.updateImageView(for: firstPhoto)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        default:
            fatalError()
        }
    }
    func setupViews() {
        segmentedControl = {
            segmentedControl = UISegmentedControl()
            segmentedControl.insertSegment(withTitle: "Interesting", at: 0, animated: true)
            segmentedControl.insertSegment(withTitle: "Recent", at: 1, animated: true)
            segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)

            let constraints = [
                segmentedControl.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
                segmentedControl.heightAnchor.constraint(equalToConstant: 60),
                segmentedControl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                segmentedControl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            ]
            configureView(segmentedControl, parent: self.view, constraints: constraints)
            return segmentedControl
        }()
        imageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            let constraints = [
                imageView.topAnchor.constraint(equalTo: self.segmentedControl.layoutMarginsGuide.bottomAnchor),
                imageView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor),
                imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            ]
            imageView.backgroundColor = .red
            configureView(imageView, parent: self.view, constraints: constraints)
            return imageView
        }()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        setupViewController()
        store.fetchPhotos(endpoint: .recentPhotos) {
            result in
            switch result {
            case .success(let photos):
                print("Successfully found \(photos.count) photos.")
                if let firstPhoto = photos.first {
                    self.updateImageView(for: firstPhoto)
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func updateImageView(for photo: Photo) {
        store.fetchImage(for: photo) { result in
            switch result {
            case .failure(let error):
                print("ERROR: \(error)")
            case .success(let img):
                DispatchQueue.main.async {
                    self.imageView.image = img.0
                }
            }
        }
    }
    
    private func setupViewController() {
        title = "Home"
    }
}
