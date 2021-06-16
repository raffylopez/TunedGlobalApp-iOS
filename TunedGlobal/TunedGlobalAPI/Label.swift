//
//  Label.swift
//  TunedGlobal
//
//  Usage:
//
//   let label = try? newJSONDecoder().decode(Label.self, from: jsonData)
//
//   To read values from URLs:
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
