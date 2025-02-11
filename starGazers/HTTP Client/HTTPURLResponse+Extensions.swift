//
//  HTTPURLResponse+Extensions.swift
//  starGazers
//
//  Created by nicolo.pasini on 11/02/25.
//

import Foundation

extension HTTPURLResponse {
    var isOK: Bool {
        (200...299).contains(statusCode)
    }
}
