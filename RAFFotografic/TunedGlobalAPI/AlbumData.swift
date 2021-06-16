// AlbumData.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let albumData = try? newJSONDecoder().decode(AlbumData.self, from: jsonData)
//
// To read values from URLs:
//
//   let task = URLSession.shared.albumDataTask(with: url) { albumData, response, error in
//     if let albumData = albumData {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - AlbumData
struct AlbumsData: Codable {
    let offset, count, total: Int
    let results: [Album]

    enum CodingKeys: String, CodingKey {
        case offset = "Offset"
        case count = "Count"
        case total = "Total"
        case results = "Results"
    }
}
