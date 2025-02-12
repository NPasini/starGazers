//
//  StarGazersListInteractor.swift
//  starGazers
//
//  Created by nicolo.pasini on 12/02/25.
//

class StarGazersListInteractor {
    enum FetchError: Error {
        case noMoreStarGazers
    }
    
    private var entity: StarGazersListEntity
    private let dataSource: StarGazersDataSourceProtocol
    
    // MARK: Initializers
    
    init(entity: StarGazersListEntity, dataSource: StarGazersDataSourceProtocol) {
        self.entity = entity
        self.dataSource = dataSource
    }
}

// MARK: StarGazersListInteractorProtocol

extension StarGazersListInteractor: StarGazersListInteractorProtocol {
    func getStarGazers() -> [StarGazer] {
        entity.starGazers
    }
    
    func fetchStarGazers() async throws {
        let newStarGazers = try await fetchStarGazersFromRemote()
        
        if newStarGazers.count > 0 {
            entity.increasePageNumber()
            entity.appendStarGazers(newStarGazers)
        } else {
            throw FetchError.noMoreStarGazers
        }
    }
}

// MARK: Private Methods

private extension StarGazersListInteractor {
    func fetchStarGazersFromRemote() async throws -> [StarGazer] {
        try await dataSource.fetchStarGazers(
            pageNumber: entity.pageNumber,
            repoName: entity.repoName,
            repoOwner: entity.repoOwner
        )
    }
}
