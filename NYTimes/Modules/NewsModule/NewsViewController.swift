//
//  NewsViewController.swift
//  NYTimes
//
//  Created by Sally Ahmed1 on 16/01/2021.
//

import RxCocoa
import RxSwift
import UIKit

final class NewsViewController: UIViewController, UIScrollViewDelegate {
    private var viewModel: NewsViewModelType
    private var router: NewsRouterType

    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var loader: UIActivityIndicatorView!

    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
    }

    init(withViewModel viewModel: NewsViewModelType, router: NewsRouterType) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: "NewsViewController", bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTableView() {
        // register cell
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "NewsTableViewCell")
        // binding table
        viewModel.newsDriver.drive(tableView.rx.items(cellIdentifier: "NewsTableViewCell",
                                                      cellType: NewsTableViewCell.self)) { _, element, cell in
            cell.item = element
        }.disposed(by: disposeBag)
        // fetch news
        viewModel.fetchNews()

        tableView.rx.modelSelected(Result.self).subscribe { [weak self] topic in
            self?.router.navigateToDetails(topic)
        }.disposed(by: disposeBag)
    }

    private func setupView() {
        viewModel.loadingDriver.drive { [weak self] isloading in
            isloading == true ? self?.loader.startAnimating() : self?.loader.stopAnimating()
            self?.tableView.isHidden = isloading
        }.disposed(by: disposeBag)

        viewModel.errorDriver.drive { [weak self] message in
            self?.showAlert(message)
        }.disposed(by: disposeBag)
    }

    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { [weak self] _ in
            self?.viewModel.fetchNews()
        }))
        present(alert, animated: true, completion: nil)
    }
}
