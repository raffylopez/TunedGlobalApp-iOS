//
//  FlickrAPI.swift
//  TunedGlobal
//
//  Copyright © 2021 Raf. All rights reserved.
//

import UIKit


struct TunedGlobalAPI {

    enum Endpoint: String {
        
        case trendingAlbums = "/albums/trending"
    }

    private static let baseURLString = "https://api-metadata-connect.tunedglobal.com/api/v2.1"
    private static let params = [ "offset": "1",
                                  "count": "50" ]
    private static let headers = [ "StoreId": "luJdnSN3muj1Wf1Q" ]
    
    private static func tunedURLRequest(endPoint: Endpoint, parameters: [String: String]?, headers: [String: String]?) -> URLRequest {
        var urlComponents = URLComponents(string: "\(baseURLString)\(endPoint.rawValue)")
        let queryItems = parameters?.compactMap({ (k,v) in
            return URLQueryItem(name: k, value: v)
        })
        urlComponents?.queryItems = queryItems
        var request = URLRequest(url: (urlComponents?.url)!)
        headers?.forEach { (k, v) in
            request.addValue(v, forHTTPHeaderField: k)
        }
        return request
    }

    static let trendingAlbumsURLRequest: URLRequest = tunedURLRequest(endPoint: .trendingAlbums, parameters: params, headers: headers)
}
