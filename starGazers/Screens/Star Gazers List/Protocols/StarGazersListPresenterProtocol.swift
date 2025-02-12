//
//  StarGazersListPresenterProtocol.swift
//  starGazers
//
//  Created by nicolo.pasini on 12/02/25.
//

protocol StarGazersListPresenterProtocol: AnyObject {
    var title: String { get }
    
    func viewWillAppear()
    func viewWillDisappear()
    func fetchNewStarGazers()
}
