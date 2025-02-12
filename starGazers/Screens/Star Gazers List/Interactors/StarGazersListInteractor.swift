//
//  StarGazersListInteractor.swift
//  starGazers
//
//  Created by nicolo.pasini on 12/02/25.
//

class StarGazersListInteractor {
    private var entity: StarGazersListEntity
    private let httpClient: HTTPClientProtocol
    
    // MARK: Initializers
    
    init(entity: StarGazersListEntity, httpClient: HTTPClientProtocol) {
        self.entity = entity
        self.httpClient = httpClient
    }
}

// MARK: StarGazersListInteractorProtocol

extension StarGazersListInteractor: StarGazersListInteractorProtocol {
    func getStarGazers() -> [StarGazer] {
        entity.starGazers
    }
    
    func fetchStarGazers() async throws {
        let newStarGazers = try await fetchStarGazersFromRemote()
        entity.increasePageNumber()
        entity.appendStarGazers(newStarGazers)
    }
}

// MARK: Private Methods

private extension StarGazersListInteractor {
    func fetchStarGazersFromRemote() async throws -> [StarGazer] {
        let data = try await httpClient.getData(
            from: StarGazersEndpoint.get(
                page: .init(
                    pageNumber: entity.pageNumber,
                    repoName: entity.repoName,
                    repoOwner: entity.repoOwner
                )
            ).url
        )
        return try StarGazersMapper.map(data)
    }
}
