//
//  NewsBuilder.swift
//  NYTimes
//
//  Created by Sally Ahmed1 on 16/01/2021.
//

import UIKit
struct NewsBuilder {
    static func viewController() -> UIViewController {
        let viewModel = NewsViewModel()
        let router = NewsRouter()
        let viewController = NewsViewController(withViewModel: viewModel, router: router)
        router.viewController = viewController
        return viewController
    }
}
