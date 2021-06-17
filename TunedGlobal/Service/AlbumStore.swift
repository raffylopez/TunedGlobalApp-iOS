//
//  AlbumStore.swift
//  TunedGlobal
//
//  Copyright © 2021 Raf. All rights reserved.
//

import UIKit

enum AppError: Error {
    case imageCreationError
    case missingImageUrl
}

enum ImageSource {
    case cache
    case network
}

enum ImageResult<UIImage, Error> {
    case successFromNetwor(UIImage)
    case successFromCache(UIImage)
    case failure(Error)
}

/// Service for downloading photos, photo data, and decoding
class AlbumStore {
    let imageStore = ImageStore()
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchAlbums(completion: @escaping (Result<[PrimaryRelease], Error>) -> Void) {
        let request = TunedGlobalAPI.trendingAlbumsURLRequest

        let task = session.albumDataTask(withUrlRequest: request) { albumData, response, error in
            guard let releases = albumData?.results.map({ result in
                result.primaryRelease
            }) else {
                if let requestError = error {
                    completion(.failure(requestError))
                    return
                }
                completion(.failure(AppError.missingImageUrl))
                return
            }
            OperationQueue.main.addOperation {
                completion(.success(releases))
            }
        }
        task.resume()
    }
    
    /// Download image (no downsampling)
    func fetchImage(for photo: PrimaryRelease, completion: @escaping (Result<(UIImage, ImageSource), Error>) -> Void) {
        let photoKey = "\(photo.albumID)"
        if let image = imageStore.image(forKey: photoKey) {
            DispatchQueue.main.async {
                completion(.success((image, .cache)))
            }
        }
        guard let photoUrl = photo.image else {
            completion(.failure(AppError.missingImageUrl))
            return
        }
        let request = URLRequest(url: URL(string:photoUrl)!)

        let task = session.dataTask(with: request) {
            data, _, error in
            let result = self.processImageRequest(data: data, error: error)
            
            if case let .success(image) = result {
                self.imageStore.setImage(forKey: photoKey, image: image.0)
            }

            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    /// Download actual image with downsampling
    func fetchImage(for photo: PrimaryRelease, downsampleTo size: CGSize, scaleTo scale: CGFloat, completion: @escaping (Result<(UIImage, ImageSource), Error>) -> Void) {
        let photoKey = "\(photo.albumID)"
        if let image = imageStore.image(forKey: photoKey) {
            DispatchQueue.main.async {
                completion(.success((image, .cache)))
            }
            return
        }
        guard let photoUrl = photo.image else {
            completion(.failure(AppError.missingImageUrl))
            return
        }
        let request = URLRequest(url: URL(string:photoUrl)!)
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let self = self {
                let image: (UIImage, ImageSource) = (self.downsample(imageAt: request.url!, to: size, scale: scale), .network)
                    self.imageStore.setImage(forKey: photoKey, image: image.0)

                OperationQueue.main.addOperation {
                    completion(.success(image))
                }
            }
        }
    }
    
    func processImageRequest(data: Data?, error: Error?) -> Result<(UIImage, ImageSource), Error> {
        guard let imageData = data, let image = UIImage(data: imageData) else {
            if data == nil {
                return .failure(error!)
            }
            return .failure(AppError.imageCreationError)
        }
        return .success((image, .network))
    }
    
    // Attribution: WWDC 2018 - Image Downsampling
    private func downsample(imageAt imageURL: URL, to pointSize: CGSize, scale: CGFloat) -> UIImage {
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        let imageSource = CGImageSourceCreateWithURL(imageURL as CFURL, imageSourceOptions)!

        let maxDimentionInPixels = max(pointSize.width, pointSize.height) * scale
     
        let downsampledOptions = [kCGImageSourceCreateThumbnailFromImageAlways: true,
        kCGImageSourceShouldCacheImmediately: true,
        kCGImageSourceCreateThumbnailWithTransform: true,
        kCGImageSourceThumbnailMaxPixelSize: maxDimentionInPixels] as CFDictionary
        let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampledOptions)!
     
        return UIImage(cgImage: downsampledImage)
    }
    
}


