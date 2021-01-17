//
//  NewsTableViewCell.swift
//  NYTimes
//
//  Created by Sally Ahmed1 on 16/01/2021.
//

import AlamofireImage
import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet private var topicImage: UIImageView!
    @IBOutlet private var topicLbl: UILabel!
    var item: Result? {
        didSet {
            self.topicLbl.text = item?.title
            if let link = item?.media?.first?.mediaMetadata?.first?.url, let url = URL(string: link) {
                topicImage.af.setImage(withURL: url, placeholderImage: UIImage(named: "placeholder"))
            }
        }
    }
}
