// Volume.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let volume = try? newJSONDecoder().decode(Volume.self, from: jsonData)
//
// To read values from URLs:
//
//   let task = URLSession.shared.volumeTask(with: url) { volume, response, error in
//     if let volume = volume {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - Volume
struct Volume: Codable {
    let firstTrackIndex, lastTrackIndex: Int

    enum CodingKeys: String, CodingKey {
        case firstTrackIndex = "FirstTrackIndex"
        case lastTrackIndex = "LastTrackIndex"
    }
}
