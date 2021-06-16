//
// Artist.swift
// TunedGlobal

// Usage:
//
//   let artist = try? newJSONDecoder().decode(Artist.self, from: jsonData)
//
// To read values from URLs:
//
//   let task = URLSession.shared.artistTask(with: url) { artist, response, error in
//     if let artist = artist {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - Artist
struct Artist: Codable {
    let artistID: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case artistID = "ArtistId"
        case name = "Name"
    }
}
