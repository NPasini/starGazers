//
//  StarGazersMapper.swift
//  starGazers
//
//  Created by nicolo.pasini on 11/02/25.
//

import Foundation

public enum StarGazersMapper {
    private struct RemoteStarGazer: Decodable {
        let id: Int
        let login: String?
        let avatar_url: String?
        
        func toModel() -> StarGazer {
            let imageURL = avatar_url != nil ? URL(string: avatar_url!) : nil
            return StarGazer(id: id, name: login, imageURL: imageURL)
        }
    }
    
    static func map(_ data: Data) throws -> [StarGazer] {
        guard let gazers = try? JSONDecoder().decode([RemoteStarGazer].self, from: data) else {
            throw APIError.invalidData
        }
        
        return gazers.map { $0.toModel() }
    }
}
