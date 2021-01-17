//
//  NewsServiceManager.swift
//  NYTimes
//
//  Created by Sally Ahmed1 on 16/01/2021.
//
import Moya
import RxSwift

struct NewsServiceManager {
    // This is the provider for the service we defined earlier
    private let provider = MoyaProvider<NewsService>()

    func getNews(_ period: Int) -> Single<NewModel> {
        provider.rx
            .request(.getNews(period: period))
            .filterSuccessfulStatusAndRedirectCodes()
            .map(NewModel.self)
    }
}
