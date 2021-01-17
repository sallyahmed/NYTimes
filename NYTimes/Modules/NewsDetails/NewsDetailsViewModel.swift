//
//  NewsDetailsViewModel.swift
//  NYTimes
//
//  Created by Sally Ahmed1 on 17/01/2021.
//

import Foundation
import RxSwift

protocol NewsDetailsViewModelType {
    var topicObservable: Observable<Result> { get }
    func getTopic()
}

class NewsDetailsViewModel: BaseViewModel, NewsDetailsViewModelType {
    var topicObservable: Observable<Result>
    private var topic: Result
    private let topicSubject = PublishSubject<Result>()

    init(topic: Result) {
        self.topic = topic
        topicObservable = topicSubject.asObservable()
        super.init()
    }

    func getTopic() {
        topicSubject.onNext(topic)
    }
}
