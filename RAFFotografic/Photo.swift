//
//  Photo.swift
//  RAFFotografic
//
//  Created by Volare on 3/17/21.
//  Copyright © 2021 Raf. All rights reserved.
//

import UIKit

class Photo: Codable {
    let title: String
    let remoteURL: URL
    let photoID: String
    let _dateTaken: String
    
    static let formatter = DateFormatter()
    var dateTaken: Date {
        Self.formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return Self.formatter.date(from: _dateTaken)!
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case photoID = "id"
        case _dateTaken = "datetaken"
        case remoteURL = "url_z"
    }
}
