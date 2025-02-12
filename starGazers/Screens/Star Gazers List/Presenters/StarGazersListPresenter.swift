//
//  StarGazersListPresenter.swift
//  starGazers
//
//  Created by nicolo.pasini on 12/02/25.
//

class StarGazersListPresenter {
    private var interactor: StarGazersListInteractorProtocol
    
    weak var view: StarGazersListViewProtocol?
    
    var title: String { "Star Gazers" }
    
    // MARK: Initializers
    
    init(interactor: StarGazersListInteractorProtocol) {
        self.interactor = interactor
    }
}

// MARK: StarGazersListPresenterProtocol

extension StarGazersListPresenter: StarGazersListPresenterProtocol {
    func viewWillAppear() {
        fetchNewStarGazers()
    }
    
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
