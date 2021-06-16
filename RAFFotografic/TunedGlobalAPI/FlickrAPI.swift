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
    private static let baseURLString = "https://api-metadata-connect.tunedglobal.com/api/v2.1/albums/trending?offset=1&count=50"
    private static let apiKey = "luJdnSN3muj1Wf1Q"

    
    /// Decode JSON data, trim out photos with no remote url's
//    static func photos(fromJson data: Data) -> Result<[PrimaryRelease], Error> {
//        do {
//            let decoder = JSONDecoder()
//            let formatter = DateFormatter()
//            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//            formatter.locale = Locale(identifier: "en_US_POSIX")
//            formatter.timeZone = TimeZone(secondsFromGMT: 0)
//            decoder.dateDecodingStrategy = .formatted(formatter)
//
//            let flickrResponse = try decoder.decode(FlickrResponse.self, from: data)
//            return .success(flickrResponse.photosInfo.photos.filter({ $0.remoteURL != nil
//            }))
//        } catch {
//            return .failure(error)
//        }
//    }
    /// Assemble URL
    private static func flickrURL(endPoint: Endpoint, parameters: [String: String]?) -> URL {
        var request = URLRequest(url: URL(string:baseURLString)!)
        request.setValue(apiKey, forHTTPHeaderField: "StoreId")
        return request.url!
    }
    
    private static func flickrURLRequest(endPoint: Endpoint, parameters: [String: String]?) -> URLRequest {
        var request = URLRequest(url: URL(string:baseURLString)!)
        request.setValue(apiKey, forHTTPHeaderField: "StoreId")
        return request
    }

    static let interestingPhotosURLRequest: URLRequest = flickrURLRequest(endPoint: .interestingPhotos, parameters: nil)
    static let interestingPhotosURL: URL = flickrURL(endPoint: .interestingPhotos, parameters: nil)
    static let recentPhotosURL: URL = flickrURL(endPoint: .recentPhotos, parameters: ["extras": "url_z,date_taken"])
}

/// Represents a group of photos info
struct FlickrResponse: Codable {
    let photosInfo: FlickrPhotosResponse

    enum CodingKeys: String, CodingKey {
        case photosInfo = "photos"
    }
}

struct TuneGlobalResponse: Codable {
    let image: Photo
    enum CodingKeys: String, CodingKey {
        case image = "Image"
    }
}

/// Represents photos info { photos: [photo] }
struct FlickrPhotosResponse: Codable {
    var photos: [Photo]

    enum CodingKeys: String, CodingKey {
        case photos = "photo"
    }
}
