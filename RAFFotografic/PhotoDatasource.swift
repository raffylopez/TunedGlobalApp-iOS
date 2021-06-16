//
//  PhotoDatasource.swift
//  RAFFotografic
//
//  Created by Volare on 3/19/21.
//  Copyright © 2021 Raf. All rights reserved.
//

import UIKit

class PhotoDatasource: NSObject, UICollectionViewDataSource {
    var photos = [PrimaryRelease]()
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "PhotoCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! AlbumPhotoCell
        cell.update(displaying: nil)
        return cell
    }

}
