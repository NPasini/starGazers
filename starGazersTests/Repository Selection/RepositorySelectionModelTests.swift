//
//  starGazersTests.swift
//  starGazersTests
//
//  Created by nicolo.pasini on 11/02/25.
//

@testable import starGazers
import Testing

struct RepositorySelectionModelTests {
    var model: RepositorySelectionModel
    
    init() {
        model = RepositorySelectionModel()
    }
    
    @Test("Setting repository name")
    mutating func setRepoName() {
        // Given
        let newRepoName = "Test Repo"
        
        // When
        model.setRepositoryName(newRepoName)
        
        // Then
        #expect(!model.isValid())
        #expect(model.repoOwner.isEmpty)
        #expect(model.repoName == newRepoName)
    }
    
    @Test("Setting repository owner")
    mutating func setRepoOwner() {
        // Given
        let newRepoOwner = "Test Owner"
        
        // When
        model.setRepositoryOwner(newRepoOwner)
        
        // Then
        #expect(!model.isValid())
        #expect(model.repoName.isEmpty)
        #expect(model.repoOwner == newRepoOwner)
    }
    
    @Test("Setting both repository owner and repository name")
    mutating func setRepoOwnerAndName() {
        // Given
        let newRepoName = "Test Repo"
        let newRepoOwner = "Test Owner"
        
        // When
        model.setRepositoryName(newRepoName)
        model.setRepositoryOwner(newRepoOwner)
        
        // Then
        #expect(model.isValid())
        #expect(model.repoName == newRepoName)
        #expect(model.repoOwner == newRepoOwner)
    }
}
