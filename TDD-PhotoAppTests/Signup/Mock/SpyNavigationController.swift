//
//  SpyNavigationController.swift
//  TDD-PhotoAppTests
//
//  Created by Jyoti Sahoo on 10/16/20.
//  Copyright © 2020 Jyoti Sahoo. All rights reserved.
//

import UIKit

class SpyNavigationController: UINavigationController {
    var pushedViewController: UIViewController!

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        pushedViewController = viewController
    }
}
