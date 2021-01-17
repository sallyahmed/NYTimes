//
//  NewsDetailsTests.swift
//  NYTimesTests
//
//  Created by Sally Ahmed1 on 17/01/2021.
//

import Nimble
@testable import NYTimes
import OHHTTPStubs
import Quick
import RxBlocking
import RxSwift
import RxTest

final class NewsDetailsTests: QuickSpec {
    override func spec() {
        describe("Test News details") {
            let viewModel = NewsViewModel()
            var detailsViewModel: NewsDetailsViewModel?
            beforeEach {
                OHHTTPStubs.setEnabled(true, for: URLSessionConfiguration.default)
                stub(condition: isAbsoluteURLString(baseApiURL + "viewed/7.json?api-key=\(apiKey)")) { _ in
                    let stubPath = OHPathForFile("news.json", type(of: self))
                    if let stubPath = stubPath {
                        return fixture(filePath: stubPath, status: 200, headers: ["Content-Type": "application/json"])
                    } else {
                        return OHHTTPStubsResponse()
                    }
                }
            }

            afterEach {
                OHHTTPStubs.removeAllStubs()
            }

            context("test news details module") {
                it("test fetch first topic") {
                    viewModel.fetchNews()
                    let news = try? viewModel.newsDriver.toBlocking(timeout: 5).first()!
                    expect(news?.count).toEventually(equal(19))
                    if let topic = news?.first {
                        detailsViewModel = NewsDetailsViewModel(topic: topic)
                        detailsViewModel?.getTopic()
                        let topicResults = try? detailsViewModel?.topicObservable.toBlocking(timeout: 5).first()!
                        if let topicResults = topicResults {
                            expect(topicResults.title).toEventually(equal("Photos of Trump ally who visited the White House capture notes about martial law."))
                            expect(topicResults.abstract).toEventually(equal("President Trump, isolated and watching the clock count down on his time in the White House, spent some of it on Friday with the C.E.O. of MyPillow, Mike Lindell, who brought some notes with him."))
                        }
                    }
                }
            }
        }
    }
}
