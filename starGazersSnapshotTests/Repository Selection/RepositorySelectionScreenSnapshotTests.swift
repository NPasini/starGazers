//
//  RepositorySelectionScreenSnapshotTests.swift
//  starGazers
//
//  Created by nicolo.pasini on 13/02/25.
//

@testable import starGazers
import UIKit
import XCTest

class RepositorySelectionScreenSnapshotTests: XCTestCase {
    func test_feedWithContent() {
        let sut = makeSUT()
        
        assert(snapshot: sut.snapshot(for: .iPhone16(style: .light)), named: "REPOSITORY_SELECTION_light")
        assert(snapshot: sut.snapshot(for: .iPhone16(style: .dark)), named: "REPOSITORY_SELECTION_dark")
        assert(snapshot: sut.snapshot(for: .iPhone16(style: .light, contentSize: .extraExtraExtraLarge)), named: "REPOSITORY_SELECTION_light_extraExtraExtraLarge")
    }
}

// MARK: Private Methods

private extension RepositorySelectionScreenSnapshotTests {
    func makeSUT() -> UIViewController {
        let vc = RepositorySelectionScreenAssembler(httpClient: HTTPProtocolStub()).assemble()
        vc.loadViewIfNeeded()
        return vc
    }
}

private class HTTPProtocolStub: HTTPClientProtocol {
    func getData(from url: URL) async throws -> Data {
        Data()
    }
}
