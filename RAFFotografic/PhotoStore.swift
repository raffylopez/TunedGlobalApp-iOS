//
//  PhotoStore.swift
//  RAFFotografic
//
//  Created by Volare on 3/14/21.
//  Copyright © 2021 Raf. All rights reserved.
//

import UIKit

enum PhotoError: Error {
    case imageCreationError
    case missingImageUrl
}

/// Service responsible for downloading photos, photo data, and decoding
class PhotoStore {
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()

    func processPhotoRequest(data: Data?, error: Error?) -> Result<[Photo], Error> {
        guard let jsonData = data else {
            return .failure(error!)
        }
        return FlickrAPI.photos(fromJson: jsonData)
    }

    func fetchPhotos(endpoint: Endpoint, completion: @escaping (Result<[Photo], Error>) -> Void) {
        let url: URL
        switch endpoint{
        case .interestingPhotos:
            url = FlickrAPI.interestingPhotosURL
        case .recentPhotos:
            url = FlickrAPI.recentPhotosURL
        }
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) {
            data, response, error in
            if let response = response, let httpResponse = response as? HTTPURLResponse {
                print("Status Code: \(httpResponse.statusCode)")
                let headers = (httpResponse.allHeaderFields as? [String: String])?.compactMap({ (k,v) in
                    return "\(k): \(v)"
                }).joined(separator: ", ")
                print("Headers: \(headers ?? "<none>")")
            }
            if let jsonData = data {
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                }
                let result = self.processPhotoRequest(data: data, error: error)
                OperationQueue.main.addOperation {
                    completion(result)
                }
            } else if let requestError = error {
                completion(.failure(requestError))
            } else {
                fatalError()
            }
        }
        task.resume()
    }
    func fetchInterestingPhotos(completion: @escaping (Result<[Photo], Error>) -> Void) {
        let url = FlickrAPI.interestingPhotosURL
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) {
            data, response, error in
            if let response = response, let httpResponse = response as? HTTPURLResponse {
                print("Status Code: \(httpResponse.statusCode)")
                let headers = (httpResponse.allHeaderFields as? [String: String])?.compactMap({ (k,v) in
                    return "\(k): \(v)"
                    }).joined(separator: ", ")
                print("Headers: \(headers ?? "<none>")")
            }
            if let jsonData = data {
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                }
                let result = self.processPhotoRequest(data: data, error: error)
                OperationQueue.main.addOperation {
                    completion(result)
                }
            } else if let requestError = error {
                completion(.failure(requestError))
            } else {
                fatalError()
            }
        }
        task.resume()
    }
    
    func fetchImage(for photo: Photo, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let photoUrl = photo.remoteURL else {
            completion(.failure(PhotoError.missingImageUrl))
            return
        }
        let request = URLRequest(url: photoUrl)
        let task = session.dataTask(with: request) {
            data, _, error in
            let result = self.processImageRequest(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    func processImageRequest(data: Data?, error: Error?) -> Result<UIImage, Error> {
        guard let imageData = data, let image = UIImage(data: imageData) else {
            if data == nil {
                return .failure(error!)
            }
            return .failure(PhotoError.imageCreationError)
        }
        return .success(image)
    }
}
