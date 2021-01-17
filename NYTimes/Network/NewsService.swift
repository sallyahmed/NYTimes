//
//  ApiClient.swift
//  NYTimes
//
//  Created by Sally Ahmed1 on 16/01/2021.
//

import Foundation
import Moya

enum NewsService {
    case getNews(period: Int)
}

extension NewsService: TargetType {
    var baseURL: URL {
        URL(string: baseApiURL)!
    }

    var path: String {
        switch self {
        case let .getNews(period: period):
            return "viewed/\(period).json"
        }
    }

    // Here we specify which method our calls should use.
    var method: Moya.Method {
        switch self {
        case .getNews(period: _):
            return .get
        }
    }

    var task: Task {
        .requestParameters(parameters: ["api-key": apiKey], encoding: URLEncoding.default)
    }

    var headers: [String: String]? {
        ["Content-type": "application/json"]
    }

    var sampleData: Data {
        Data()
    }
}
