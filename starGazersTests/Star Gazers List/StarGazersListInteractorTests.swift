//
//  StarGazersListInteractorTests.swift
//  starGazers
//
//  Created by nicolo.pasini on 12/02/25.
//

@testable import starGazers
import Testing

struct StarGazersListInteractorTests {
    let sut: StarGazersListInteractor
    let page = GazersPage(pageNumber: 1, repoName: "Test repo", repoOwner: "Test owner")
    let starGazer1 = StarGazer(id: 1, name: "Name 1", imageURL: nil)
    let starGazer2 = StarGazer(id: 2, name: "Name 2", imageURL: nil)
    let starGazer3 = StarGazer(id: 3, name: "Name 3", imageURL: nil)
    let starGazer4 = StarGazer(id: 4, name: "Name 4", imageURL: nil)

    private let dataSource: StarGazersDataSourceProtocolMock
    
    init() {
        dataSource = StarGazersDataSourceProtocolMock()
        sut = StarGazersListInteractor(
            entity: StarGazersListEntity(repoName: page.repoName, repoOwner: page.repoOwner),
            dataSource: dataSource
        )
    }
    
    @Test("Get Star Gazers return empty list when empty")
    func getStarGazersWithEmptyListBeforeFetching() {
        // When
        let starGazers = sut.getStarGazers()
        
        // Then
        #expect(starGazers.isEmpty)
    }
    
    @Test("Fetching empty list returns empty list")
    func getStarGazersWithEmptyWhenFetchingEmptyList() async {
        // Given
        dataSource.returnedStarGazers = []
        
        // When
        await #expect(throws: StarGazersListInteractor.FetchError.noMoreStarGazers, "Should have throw error because no more star gazers are available") {
            try await sut.fetchStarGazers()
        }
        let starGazers = sut.getStarGazers()
        
        // Then
        #expect(starGazers.isEmpty)
        #expect(dataSource.fetchStarGazersCallCount == 1)
    }
    
    @Test("Fetching multiple times append star gazers")
    func getStarGazersAppendsNewStarGazes() async {
        // Given
        let firstBatch = [starGazer1, starGazer2]
        let secondBatch = [starGazer3, starGazer4]
        dataSource.returnedStarGazers = firstBatch
        
        // When
        await #expect(throws: Never.self, "Should have not thrown error because star gazers are fetched") {
            try await sut.fetchStarGazers()
        }
        let starGazers = sut.getStarGazers()
        
        // Then
        #expect(starGazers.isEqualTo(firstBatch))
        #expect(dataSource.fetchStarGazersCallCount == 1)
        
        // When
        dataSource.returnedStarGazers = secondBatch
        await #expect(throws: Never.self, "Should have not thrown error because star gazers are fetched") {
            try await sut.fetchStarGazers()
        }
        let newStarGazers = sut.getStarGazers()
        
        // Then
        #expect(newStarGazers.isEqualTo(firstBatch + secondBatch))
        #expect(dataSource.fetchStarGazersCallCount == 2)
        
        // When
        dataSource.returnedStarGazers = []
        await #expect(throws: StarGazersListInteractor.FetchError.noMoreStarGazers, "Should have throw error because no more star gazers are available") {
            try await sut.fetchStarGazers()
        }
        let finalStarGazers = sut.getStarGazers()
        
        // Then
        #expect(finalStarGazers.isEqualTo(firstBatch + secondBatch))
        #expect(dataSource.fetchStarGazersCallCount == 3)
    }
}

private extension Array where Element == StarGazer {
    func isEqualTo(_ other: [Element]) -> Bool {
        var isEqual = true
        for (index, value) in other.enumerated() {
            if value.id != self[index].id || value.name != self[index].name || value.imageURL != self[index].imageURL {
                isEqual = false
                break
            }
        }
        return isEqual
    }
}

fileprivate class StarGazersDataSourceProtocolMock: StarGazersDataSourceProtocol {
    var fetchStarGazersCallCount = 0
    var returnedStarGazers: [starGazers.StarGazer] = []
    
    func fetchStarGazers(pageNumber: Int, repoName: String, repoOwner: String) async throws -> [starGazers.StarGazer] {
        fetchStarGazersCallCount += 1
        return returnedStarGazers
    }
}
