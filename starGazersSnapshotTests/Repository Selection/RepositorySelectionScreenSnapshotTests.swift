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
        
        assert(snapshot: sut.snapshot(for: .iPhone16(style: .light)), named: "FEED_WITH_CONTENT_light")
        assert(snapshot: sut.snapshot(for: .iPhone16(style: .dark)), named: "FEED_WITH_CONTENT_dark")
        assert(snapshot: sut.snapshot(for: .iPhone16(style: .light, contentSize: .extraExtraExtraLarge)), named: "FEED_WITH_CONTENT_light_extraExtraExtraLarge")
    }
}

// MARK: Private Methods

private extension RepositorySelectionScreenSnapshotTests {
    func makeSUT() -> UIViewController {
        RepositorySelectionScreenAssembler(httpClient: HTTPProtocolStub()).assemble()
    }
}

private class HTTPProtocolStub: HTTPClientProtocol {
    func getData(from url: URL) async throws -> Data {
        Data()
    }
}
