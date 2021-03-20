//
//  ImageStore.swift
//  LootLogger2
//
//  Created by Volare on 2/28/21.
//  Copyright © 2021 Raf. All rights reserved.
//

import UIKit
import Foundation

class ImageStore {
    let cache = NSCache<NSString, UIImage>()
    
    private func imageUrl(forKey key: String) -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        var baseDir = url.first!
        baseDir.appendPathComponent(key)
        return baseDir
    }

    func image(forKey key: String)->UIImage? {
        
        if let cachedImg = cache.object(forKey: key as NSString) {
            return cachedImg
        }
        
        let persistentImgUrl = imageUrl(forKey: key)
        guard let persistentImg = UIImage(contentsOfFile: persistentImgUrl.path) else {
            return nil
        }
        setImage(forKey: key, image: persistentImg) // save on cache miss!
        return persistentImg
    }

    func setImage(forKey key: String, image: UIImage) {
        // (1) save to cache
        cache.setObject(image, forKey: key as NSString)
        
        // (2) save to sandbox
        let url = imageUrl(forKey: key)
        if let data = image.jpegData(compressionQuality: 0.5) {
            try? data.write(to: url)
        } else {
            fatalError("Can't save image into docs directory")
        }
    }
    func removeImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
        let persistentImgUrl = imageUrl(forKey: key)
        do {
            try FileManager.default.removeItem(at: persistentImgUrl)
        } catch let err {
            print("Unable to remove corresponding file from disk: \(err)")
        }
    }
}
