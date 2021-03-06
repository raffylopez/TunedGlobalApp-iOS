//
//  Album.swift
//  TunedGlobal
//
//  Copyright © 2021 Raf. All rights reserved.

//  Usage:
//
//   let result = try? newJSONDecoder().decode(Result.self, from: jsonData)
//
//   To read values from URLs:
//
//   let task = URLSession.shared.resultTask(with: url) { result, response, error in
//     if let result = result {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - Result
struct Album: Codable {
    
    let albumID: Int
    let name, upc: String
    let artists: [Artist]
    let albumType: AlbumType
    let primaryRelease: PrimaryRelease
    let primaryReleaseID: Int
    let releaseIDS: [Int]
    let translations: [String]

    enum CodingKeys: String, CodingKey {
        case albumID = "AlbumId"
        case name = "Name"
        case upc = "Upc"
        case artists = "Artists"
        case albumType = "AlbumType"
        case primaryRelease = "PrimaryRelease"
        case primaryReleaseID = "PrimaryReleaseId"
        case releaseIDS = "ReleaseIds"
        case translations = "Translations"
    }
}
