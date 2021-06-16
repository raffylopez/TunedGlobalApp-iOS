// PrimaryRelease.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let primaryRelease = try? newJSONDecoder().decode(PrimaryRelease.self, from: jsonData)
//
// To read values from URLs:
//
//   let task = URLSession.shared.primaryReleaseTask(with: url) { primaryRelease, response, error in
//     if let primaryRelease = primaryRelease {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - PrimaryRelease
struct PrimaryRelease: Codable {
    let releaseID, albumID: Int
    let artists: [Artist]
    let name: String
    let originalCredit: String?
    let isExplicit: Bool
    let numberOfVolumes: Int
    let trackIDS: [Int]
    let duration: Int
    let volumes: [Volume]
    let image: String?
    let webPath, copyright: String?
    let label: Label
    let releaseDate, originalReleaseDate: Date
    let physicalReleaseDate, digitalReleaseDate: String?
    let saleAvailabilityDateTime, streamAvailabilityDateTime: Date
    let allowDownload, allowStream: Bool
    let contentLanguage: String?

    enum CodingKeys: String, CodingKey {
        case releaseID = "ReleaseId"
        case albumID = "AlbumId"
        case artists = "Artists"
        case name = "Name"
        case originalCredit = "OriginalCredit"
        case isExplicit = "IsExplicit"
        case numberOfVolumes = "NumberOfVolumes"
        case trackIDS = "TrackIds"
        case duration = "Duration"
        case volumes = "Volumes"
        case image = "Image"
        case webPath = "WebPath"
        case copyright = "Copyright"
        case label = "Label"
        case releaseDate = "ReleaseDate"
        case originalReleaseDate = "OriginalReleaseDate"
        case physicalReleaseDate = "PhysicalReleaseDate"
        case digitalReleaseDate = "DigitalReleaseDate"
        case saleAvailabilityDateTime = "SaleAvailabilityDateTime"
        case streamAvailabilityDateTime = "StreamAvailabilityDateTime"
        case allowDownload = "AllowDownload"
        case allowStream = "AllowStream"
        case contentLanguage = "ContentLanguage"
    }
}
extension PrimaryRelease: Equatable {
    static func == (lhs: PrimaryRelease, rhs: PrimaryRelease) -> Bool {
        if lhs.albumID == rhs.albumID {
            return true
        }
        return false
    }
}
