//
//  RepositorySelectorModel.swift
//  starGazers
//
//  Created by nicolo.pasini on 12/02/25.
//

struct RepositorySelectorModel {
    private var repoName: String
    private var repoOwner: String
    
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
