//
//  StarGazersEndpoint.swift
//
//
//  Created by nicolo.pasini on 10/02/23.
//

import Foundation

struct GazersPage {
    let pageNumber: Int
    let repoName: String
    let repoOwner: String
}

enum StarGazersEndpoint {
    case get(page: GazersPage)
    
    var url: URL {
        switch self {
        case let .get(page):
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.github.com"
            components.path = "repos/\(page.repoOwner)/\(page.repoName)/stargazers"
            components.queryItems = [
                URLQueryItem(name: "page", value: "\(page.pageNumber)"),
                URLQueryItem(name: "per_page", value: "30")
            ].compactMap { $0 }
            return components.url!
        }
    }
}
