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
    let remoteURL: URL?
    let photoID: String
    let dateTaken: Date

    enum CodingKeys: String, CodingKey {
        case title
        case photoID = "id"
        case dateTaken = "datetaken"
        case remoteURL = "url_z"
    }
}

extension Photo: Equatable {
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        if lhs.photoID == rhs.photoID {
            return true
        }
        return false
    }
}
