//
//  StarGazersListPresenter.swift
//  starGazers
//
//  Created by nicolo.pasini on 12/02/25.
//

protocol StarGazersListPresenterProtocol: AnyObject {
    var title: String { get }
    
    func viewWillAppear()
    func fetchNewStarGazers()
//    func getStarGazers() -> [StarGazer]
}

protocol StarGazersListViewProtocol: AnyObject {
    func displayData(_ starGazers: [StarGazer])
}

class StarGazersListPresenter {
    private var interactor: StarGazersListInteractor
    weak var view: StarGazersListViewProtocol?
    
    var title: String { "Star Gazers" }
    
    // MARK: Initializers
    
    init(interactor: StarGazersListInteractor) {
        self.interactor = interactor
    }
}

// MARK: StarGazersListPresenterProtocol

extension StarGazersListPresenter: StarGazersListPresenterProtocol {
    func viewWillAppear() {
        fetchNewStarGazers()
    }
    
//    func getStarGazers() -> [StarGazer] {
//        interactor.getStarGazers()
//    }
    
    func fetchNewStarGazers() {
        // Dispose?
        Task {
            do {
                try await interactor.fetchStarGazers()
                view?.displayData(interactor.getStarGazers())
            } catch {
                print("Error")
            }
        }
    }
}
