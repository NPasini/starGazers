//
//  NavigationControllerMock.swift
//  starGazers
//
//  Created by nicolo.pasini on 13/02/25.
//

import UIKit

class NavigationControllerMock: UINavigationController {
    var pushedViewControllerArgument: UIViewController?
    var presentedViewControllerArgument: UIViewController?
    
    var pushViewControllerCallCount = 0
    var presentViewControllerCallCount = 0
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerCallCount += 1
        pushedViewControllerArgument = viewController
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentViewControllerCallCount += 1
        presentedViewControllerArgument = viewControllerToPresent
    }
}
