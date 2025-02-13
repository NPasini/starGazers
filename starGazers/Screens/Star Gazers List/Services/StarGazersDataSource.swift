//
//  StarGazersDataSource.swift
//  starGazers
//
//  Created by nicolo.pasini on 12/02/25.
//

import Foundation

struct StarGazersDataSource: StarGazersDataSourceProtocol {
    private let httpClient: HTTPClientProtocol
    
    func fetchStarGazers(pageNumber: Int, repoName: String, repoOwner: String) async throws -> [StarGazer] {
        let data = try await httpClient.getData(
            from: StarGazersEndpoint.get(
                page: .init(
                    pageNumber: pageNumber,
                    repoName: repoName,
                    repoOwner: repoOwner
                )
            ).url
        )
        return try StarGazersMapper.map(data)
    }
    
    // MARK: Initializers
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
}
