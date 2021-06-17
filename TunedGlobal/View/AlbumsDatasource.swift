//
//  AlbumsDatasource.swift
//  TunedGlobal
//
//  Copyright © 2021 Raf. All rights reserved.
//

import UIKit

class AlbumsDatasource: NSObject, UICollectionViewDataSource {
    
    var primaryReleases = [PrimaryRelease]()
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return primaryReleases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "AlbumPhotoCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! AlbumPhotoCell
        cell.update(displaying: nil)
        return cell
    }

}
