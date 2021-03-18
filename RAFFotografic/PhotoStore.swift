//
//  PhotoStore.swift
//  RAFFotografic
//
//  Created by Volare on 3/14/21.
//  Copyright © 2021 Raf. All rights reserved.
//

import UIKit

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
    
    func fetchInterestingPhotos(completion: @escaping (Result<[Photo], Error>)->Void) {
        let url = FlickrAPI.interestingPhotosURL
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (data, response, error) in
            if let jsonData = data {
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                }
                let result = self.processPhotoRequest(data: data, error: error)
                completion(result)
            } else if let requestError = error {
//                print("Error fetching interesting photos: \(requestError)")
                completion(.failure(requestError))
            } else {
//                print("Unexpected error with the request")
                fatalError()
            }
        }
        task.resume()
        
    }
}
