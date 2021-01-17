//
//  NYTimesTests.swift
//  NYTimesTests
//
//  Created by Sally Ahmed1 on 16/01/2021.
//

import Nimble
@testable import NYTimes
import OHHTTPStubs
import Quick
import RxBlocking
import RxSwift
import RxTest

final class NewsTests: QuickSpec {
    override func spec() {
        describe("Test News") {
            let viewModel = NewsViewModel()
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

            context("test news module") {
                it("test fetch news") {
                    viewModel.fetchNews()
                    let news = try? viewModel.newsDriver.toBlocking().first()!
                    expect(news?.count).toEventually(equal(19))
                }
            }

            context("test news module") {
                it("test loading") {
                    viewModel.fetchNews()
                    let isLoading = try? viewModel.loadingDriver.toBlocking().first()!
                    expect(isLoading).toEventually(beFalse())
                }
            }

            context("test news module") {
                it("test error value nil") {
                    viewModel.fetchNews()
                    let error = try? viewModel.errorDriver.toBlocking(timeout: 2).first()!
                    expect(error).toEventually(beNil())
                }
            }
        }
    }
}
