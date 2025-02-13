//
//  StarGazersListViewController.swift
//  starGazers
//
//  Created by nicolo.pasini on 13/02/25.
//

@testable import starGazers
import UIKit
import XCTest

class StarGazersListViewControllerSnapshotTests: XCTestCase {
    func test_feedWithContent() {
        let sut = makeSUT()
        
        guard let vc = sut as? StarGazersListViewController else {
            XCTFail("Could not cast sut to StarGazersListViewController")
            return
        }
        
        vc.displayData()
        
        assert(snapshot: sut.snapshot(for: .iPhone16(style: .light)), named: "GAZERS_LIST_light")
        assert(snapshot: sut.snapshot(for: .iPhone16(style: .dark)), named: "GAZERS_LIST_dark")
        assert(snapshot: sut.snapshot(for: .iPhone16(style: .light, contentSize: .extraExtraExtraLarge)), named: "GAZERS_LIST_light_extraExtraExtraLarge")
    }
    
    func test_feedWithNoMoreContent() {
        let sut = makeSUT()
        
        guard let vc = sut as? StarGazersListViewController else {
            XCTFail("Could not cast sut to StarGazersListViewController")
            return
        }
        
        vc.displayData()
        vc.signalNoMoreStarGazers()
        
        assert(snapshot: sut.snapshot(for: .iPhone16(style: .light)), named: "NO_MORE_GAZERS_LIST_light")
        assert(snapshot: sut.snapshot(for: .iPhone16(style: .dark)), named: "NO_MORE_GAZERS_LIST_dark")
        assert(snapshot: sut.snapshot(for: .iPhone16(style: .light, contentSize: .extraExtraExtraLarge)), named: "NO_MORE_GAZERS_LIST_light_extraExtraExtraLarge")
    }
}

// MARK: Private Methods

private extension StarGazersListViewControllerSnapshotTests {
    func makeSUT() -> UIViewController {
        let vc = StarGazersListScreenAssembler(
            httpClient: HTTPProtocolStub(),
            navigationController: UINavigationController()
        ).assemble(repoName: "", repoOwner: "")
        vc.loadViewIfNeeded()
        vc.viewWillAppear(false)
        return vc
    }
}

private extension StarGazersListViewController {
    func displayData() {
        displayData([
            StarGazer(
                id: 25373700,
                name: "luke-s-snyder",
                imageURL: URL(string: "")
            ),
            StarGazer(
                id: 22296717,
                name: "slyviacassell",
                imageURL: URL(string: "")
            ),
            StarGazer(
                id: 10009114,
                name: "seshurajup",
                imageURL: URL(string: "")
            )
        ])
    }
    
    func signalNoMoreStarGazers() {
        displayMessage(text: "No More Star Gazers")
    }
}

private class HTTPProtocolStub: HTTPClientProtocol {
    private var firstGazer: [String: Any] {
        [
            "login": "luke-s-snyder",
            "id": 25373700,
            "avatar_url": ""
        ]
    }

    private var secondGazer: [String: Any] {
        [
            "login": "slyviacassell",
            "id": 22296717,
            "avatar_url": ""
        ]
    }

    private var thirdGazer: [String: Any] {
        [
            "login": "seshurajup",
            "id": 10009114,
            "avatar_url": ""
        ]
    }
     
    private func gazersData() -> Data {
        let json = [firstGazer, secondGazer, thirdGazer]
        return try! JSONSerialization.data(withJSONObject: json)
    }
    
    func getData(from url: URL) async throws -> Data {
        gazersData()
    }
}
