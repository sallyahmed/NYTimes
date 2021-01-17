//
//  NewsRouter.swift
//  NYTimes
//
//  Created by Sally Ahmed1 on 17/01/2021.
//

import Foundation
import UIKit
protocol NewsRouterType {
    func navigateToDetails(_ topic: Result)
}

final class NewsRouter: NewsRouterType {
    weak var viewController: NewsViewController?
    func navigateToDetails(_ topic: Result) {
        viewController?.navigationController?.pushViewController(NewsDetailsBuilder.viewController(topic), animated: true)
    }
}
