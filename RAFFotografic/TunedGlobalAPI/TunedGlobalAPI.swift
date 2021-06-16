//
//  TunedGlobalAPI.swift
//  RAFFotografic
//

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

// Result.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let result = try? newJSONDecoder().decode(Result.self, from: jsonData)
//
// To read values from URLs:
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

// AlbumType.swift

import Foundation

enum AlbumType: String, Codable {
    case album = "Album"
}

// Artist.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
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

// Label.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let label = try? newJSONDecoder().decode(Label.self, from: jsonData)
//
// To read values from URLs:
//
//   let task = URLSession.shared.labelTask(with: url) { label, response, error in
//     if let label = label {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - Label
struct Label: Codable {
    let labelID, name: String?

    enum CodingKeys: String, CodingKey {
        case labelID = "LabelId"
        case name = "Name"
    }
}

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

// JSONSchemaSupport.swift

import Foundation

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with urlRequest: URLRequest, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
    
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func albumDataTask(with url: URL, completionHandler: @escaping (AlbumsData?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
    
    func albumDataTask(withUrlRequest urlRequest: URLRequest, completionHandler: @escaping (AlbumsData?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: urlRequest, completionHandler: completionHandler)
    }
}
