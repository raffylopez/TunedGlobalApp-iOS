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

struct TunedAPI {
    private static let baseURLString = "https://api-metadata-connect.tunedglobal.com/api/v2.1/albums/trending"
    private static let basicSecurityHeaderField = "StoreId"
    private static let storeIdValue = "luJdnSN3muj1Wf1Q"
    
    private static func flickrURLRequest(endPoint: Endpoint, parameters: [String: String]?) -> URLRequest {
        var urlComponents = URLComponents(string: baseURLString)
        let queryItems = [URLQueryItem(name: "offset", value: "1"), URLQueryItem(name: "count", value: "50")]
        urlComponents?.queryItems = queryItems
        var request = URLRequest(url: (urlComponents?.url)!)
        request.setValue(storeIdValue, forHTTPHeaderField: basicSecurityHeaderField)
        return request
    }

    static let interestingPhotosURLRequest: URLRequest = flickrURLRequest(endPoint: .interestingPhotos, parameters: nil)
}
