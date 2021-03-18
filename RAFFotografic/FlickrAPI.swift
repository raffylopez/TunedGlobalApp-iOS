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
    case recentPhotos = "flickr.photos.getRecent"
}

struct FlickrAPI {
    private static let baseURLString = "https://api.flickr.com/services/rest"
    private static let apiKey = "a6d819499131071f158fd740860a5a88"

    
    /// Decode JSON data, trim out photos with no remote url's
    static func photos(fromJson data: Data) -> Result<[Photo], Error> {
        do {
            let decoder = JSONDecoder()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            decoder.dateDecodingStrategy = .formatted(formatter)

            let flickrResponse = try decoder.decode(FlickrResponse.self, from: data)
            return .success(flickrResponse.photosInfo.photos.filter({ $0.remoteURL != nil
            }))
        } catch {
            return .failure(error)
        }
    }
    /// Assemble URL
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
    static let recentPhotosURL: URL = flickrURL(endPoint: .recentPhotos, parameters: ["extras": "url_z,date_taken"])
}

/// Represents a group of photos info
struct FlickrResponse: Codable {
    let photosInfo: FlickrPhotosResponse

    enum CodingKeys: String, CodingKey {
        case photosInfo = "photos"
    }
}

/// Represents photos info { photos: [photo] }
struct FlickrPhotosResponse: Codable {
    let photos: [Photo]

    enum CodingKeys: String, CodingKey {
        case photos = "photo"
    }
}
