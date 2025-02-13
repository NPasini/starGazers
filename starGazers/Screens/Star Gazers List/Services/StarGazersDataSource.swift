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
        try await Task.sleep(nanoseconds: 1_000_000_000)
        throw NSError(domain: "", code: 0, userInfo: nil)
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
