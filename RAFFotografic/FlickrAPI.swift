//
//  FlickrAPI.swift
//  RAFFotografic
//
//  Created by Volare on 3/14/21.
//  Copyright © 2021 Raf. All rights reserved.
//

import UIKit

enum Endpoint: String {
    case interestingPhotos = "flickr.interestingness.getList"
}

struct FlickrAPI {
    private static let baseURLString = "https://api.flickr.com/services/rest"
    private static let apiKey = "a6d819499131071f158fd740860a5a88"
    
    static func photos(fromJson data: Data) -> Result<[Photo], Error> {
        do {
            let decoder = JSONDecoder()
            let flickrResponse = try decoder.decode(FlickrResponse.self, from: data)
            return .success(flickrResponse.photosInfo.photos)
        } catch {
            return .failure(error)
        }
    }
    
    private static func flickrURL(endPoint: Endpoint, parameters: [String: String]?) -> URL {
        var components = URLComponents(string: baseURLString)!
        var queryItems = [URLQueryItem]()
        
        let baseParams = [
            "method": endPoint.rawValue,
            "format": "json",
            "nojsoncallback": "1",
            "api_key": apiKey,
        ]

        queryItems.append(contentsOf: baseParams.compactMap {
            URLQueryItem(name: $0.key, value: $0.value)
        })
        
        if let additionalParams = parameters {
            queryItems.append(contentsOf: additionalParams.compactMap {
                URLQueryItem(name: $0.key, value: $0.value)
            })
        }
        components.queryItems = queryItems
        return components.url!
    }

    static let interestingPhotosURL: URL = flickrURL(endPoint: .interestingPhotos, parameters: ["extras": "url_z,date_taken"])
}

struct FlickrResponse: Codable {
    let photosInfo: FlickrPhotosResponse
    
    enum CodingKeys: String, CodingKey {
        case photosInfo = "photos"
    }
}

struct FlickrPhotosResponse: Codable {
    let photos: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case photos = "photo"
    }
}
