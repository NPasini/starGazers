//
//  StarGazersListEntity.swift
//  starGazers
//
//  Created by nicolo.pasini on 11/02/25.
//

struct StarGazersListEntity {
    let repoName: String
    let repoOwner: String
    
    private(set) var pageNumber: Int
    private(set) var starGazers: [StarGazer]
    
    mutating func increasePageNumber() {
        pageNumber += 1
    }
    
    mutating func appendStarGazers(_ gazers: [StarGazer]) {
        starGazers.append(contentsOf: gazers)
    }
    
    // MARK: Initializers
    
    init(repoName: String, repoOwner: String) {
        self.pageNumber = 1
        self.starGazers = []
        self.repoName = repoName
        self.repoOwner = repoOwner
    }
}
