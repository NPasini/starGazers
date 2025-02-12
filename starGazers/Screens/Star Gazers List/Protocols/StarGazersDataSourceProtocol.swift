//
//  StarGazersDataSourceProtocol.swift
//  starGazers
//
//  Created by nicolo.pasini on 12/02/25.
//

protocol StarGazersDataSourceProtocol {
    func fetchStarGazers(pageNumber: Int, repoName: String, repoOwner: String) async throws -> [StarGazer]
}
