//
//  UIViewController+Extensions.swift
//  starGazers
//
//  Created by nicolo.pasini on 12/02/25.
//

import UIKit

extension UIViewController {
    func setTitle(_ title: String, color: UIColor) {
        let fullTitle = NSMutableAttributedString(attributedString: NSAttributedString(string: title, attributes: [.font: UIFont.preferredFont(forTextStyle: .title1), .foregroundColor: color]))
        
        let titleLabel = UILabel()
        titleLabel.attributedText = fullTitle
        self.navigationItem.titleView = titleLabel
    }
    
    func customizeNavigationBar(backgroundColor: UIColor, backButtonColor: UIColor) {
        // Make the navigation bar's background to backGrey.
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        navigationItem.compactAppearance = appearance
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        
        // Make back button with lightText color text.
        navigationController?.navigationBar.tintColor = UIColor.lightText
        
        let buttonAppearance = UIBarButtonItemAppearance()
        buttonAppearance.normal.titleTextAttributes = [.foregroundColor: backButtonColor]
        navigationItem.compactAppearance?.buttonAppearance = buttonAppearance
        navigationItem.standardAppearance?.buttonAppearance = buttonAppearance
    }
}
