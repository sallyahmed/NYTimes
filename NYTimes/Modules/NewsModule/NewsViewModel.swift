//
//  NewsViewModel.swift
//  NYTimes
//
//  Created by Sally Ahmed1 on 16/01/2021.
//

import Foundation
import RxCocoa
import RxSwift

protocol NewsViewModelType {
    var newsDriver: Driver<[Result]> { get }
    var errorDriver: Driver<String> { get }
    var loadingDriver: Driver<Bool> { get }
    func fetchNews()
}

class NewsViewModel: BaseViewModel, NewsViewModelType {
    var newsDriver: Driver<[Result]>
    var errorDriver: Driver<String>
    var loadingDriver: Driver<Bool>

    private let newsSubject = PublishSubject<[Result]>()
    private let errorSubject = PublishSubject<String>()
    private let loadingSubject = PublishSubject<Bool>()
    private let network = NewsServiceManager()

    override init() {
        errorDriver = errorSubject.asDriver(onErrorJustReturn: "")
        newsDriver = newsSubject.asDriver(onErrorJustReturn: [])
        loadingDriver = loadingSubject.asDriver(onErrorJustReturn: true)
        super.init()
    }

    func fetchNews() {
        loadingSubject.onNext(true)
        network.getNews(7).subscribe { [weak self] news in
            if let results = news.results {
                self?.loadingSubject.onNext(false)
                self?.newsSubject.onNext(results)
            }
        } onError: { [weak self] error in
            self?.errorSubject.onNext(error.localizedDescription)
            self?.loadingSubject.onNext(false)
        }.disposed(by: disposeBag)
    }
}
