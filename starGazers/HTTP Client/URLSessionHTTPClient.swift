//
//  URLSessionHTTPClient.swift
//  starGazers
//
//  Created by nicolo.pasini on 11/02/25.
//

import Foundation

protocol HTTPClientProtocol {
    func getData(from url: URL) async throws -> Data
}

class URLSessionHTTPClient: HTTPClientProtocol {
    private let urlSession: URLSession
    
    init() {
        urlSession = .shared
    }
    
    func getData(from url: URL) async throws -> Data {
        let (data, response) = try await urlSession.data(from: url)
        guard let response = response as? HTTPURLResponse, response.isOK else {
            throw URLError(.badServerResponse)
        }
        return data
    }
}
