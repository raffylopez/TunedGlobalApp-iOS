//
//  Volume.swift
//  TunedGlobal
//
//  Copyright © 2021 Raf. All rights reserved.

//  Usage:
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
