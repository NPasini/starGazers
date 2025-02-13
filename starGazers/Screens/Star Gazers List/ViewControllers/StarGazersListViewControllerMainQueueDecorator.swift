//
//  StarGazersListViewControllerMainQueueDecorator.swift
//  starGazers
//
//  Created by nicolo.pasini on 13/02/25.
//

import UIKit

class StarGazersListViewControllerMainQueueDecorator  {
    private weak var decoratee: StarGazersListViewProtocol?
    
    init(decoratee: StarGazersListViewProtocol) {
        self.decoratee = decoratee
    }
}

extension StarGazersListViewControllerMainQueueDecorator: StarGazersListViewProtocol {
    func showSpinner() {
        DispatchQueue.main.async {
            self.decoratee?.showSpinner()
        }
    }
    
    func hideSpinner() {
        DispatchQueue.main.async {
            self.decoratee?.hideSpinner()
        }
    }
    
    func setHasReachEndOfData() {
        decoratee?.setHasReachEndOfData()
    }
    
    func displayMessage(text: String) {
        DispatchQueue.main.async {
            self.decoratee?.displayMessage(text: text)
        }
    }
    
    func displayData(_ starGazers: [StarGazer]) {
        DispatchQueue.main.async {
            self.decoratee?.displayData(starGazers)
        }
    }
}
