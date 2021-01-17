//
//  NewsDetailsViewController.swift
//  NYTimes
//
//  Created by Sally Ahmed1 on 17/01/2021.
//

import RxCocoa
import RxSwift
import UIKit

class NewsDetailsViewController: UIViewController {
    private var viewModel: NewsDetailsViewModelType
    @IBOutlet private var titleLbl: UILabel!
    @IBOutlet private var topicImg: UIImageView!
    @IBOutlet private var topicDetailsLbl: UILabel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        adjustUI()
        viewModel.getTopic()
    }

    init(withViewModel viewModel: NewsDetailsViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: "NewsDetailsViewController", bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func adjustUI() {
        viewModel.topicObservable.subscribe { [weak self] topic in
            self?.titleLbl.text = topic.title
            if let link = topic.media?.first?.mediaMetadata?.first?.url, let url = URL(string: link) {
                self?.topicImg.af.setImage(withURL: url, placeholderImage: UIImage(named: "placeholder"))
            }
            self?.topicDetailsLbl.text = topic.abstract

        } onError: { _ in
        }.disposed(by: disposeBag)
    }
}
