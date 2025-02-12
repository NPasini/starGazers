//
//  UIView+Extensions.swift
//  starGazers
//
//  Created by nicolo.pasini on 12/02/25.
//

import UIKit

extension UIView {
    /// Returns the *Nib* file with the same name of the current view class.
    ///
    /// - Returns: A `UINib`object.
    /// - Parameter fromBundle: The bundle associated with the view.
    ///
    /// This method tries to infer the right bundle in case none is specified.
    static func nib(fromBundle: Bundle? = nil) -> UINib {
        let nibName = String(describing: self)
        let bundle = fromBundle ?? Bundle(for: self)
        return UINib(nibName: nibName, bundle: bundle)
    }
}
