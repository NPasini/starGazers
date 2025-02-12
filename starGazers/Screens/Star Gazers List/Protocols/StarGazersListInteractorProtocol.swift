//
//  StarGazersListInteractorProtocol.swift
//  starGazers
//
//  Created by nicolo.pasini on 12/02/25.
//

protocol StarGazersListInteractorProtocol {
    func getStarGazers() -> [StarGazer]
    func fetchStarGazers() async throws
}
