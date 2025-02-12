//
//  StarGazersListViewProtocol.swift
//  starGazers
//
//  Created by nicolo.pasini on 12/02/25.
//

protocol StarGazersListViewProtocol: AnyObject {
    func showSpinner()
    func hideSpinner()
    func setHasReachEndOfData()
    func displayMessage(text: String)
    func displayData(_ starGazers: [StarGazer])
}
