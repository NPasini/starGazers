//
//  RepositorySelectionModel.swift
//  starGazers
//
//  Created by nicolo.pasini on 12/02/25.
//

struct RepositorySelectionModel {
    private(set) var repoName: String
    private(set) var repoOwner: String
    
    mutating func setRepositoryName(_ name: String) {
        self.repoName = name
    }
    
    mutating func setRepositoryOwner(_ owner: String) {
        self.repoOwner = owner
    }
    
    func isValid() -> Bool {
        !repoName.isEmpty && !repoOwner.isEmpty
    }
    
    // MARK: Initializers
    
    init() {
        self.repoName = ""
        self.repoOwner = ""
    }
}
