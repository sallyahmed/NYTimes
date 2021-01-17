//
//  NewsDetailsBuilder.swift
//  NYTimes
//
//  Created by Sally Ahmed1 on 17/01/2021.
//

import UIKit
struct NewsDetailsBuilder {
    static func viewController(_ topic: Result) -> UIViewController {
        let viewModel = NewsDetailsViewModel(topic: topic)
        let viewController = NewsDetailsViewController(withViewModel: viewModel)
        return viewController
    }
}
