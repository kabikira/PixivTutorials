//
//  RankingIllustCell.swift
//  PixivTutorials1
//
//  Created by koala panda on 2024/04/28.
//

import IllustAPIMock
import Nuke
import NukeExtensions
import UIKit

class RankingIllustCell: UICollectionViewCell {
    @IBOutlet private weak var imageView: UIImageView! {
        didSet {
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 8
            imageView.layer.masksToBounds = true
        }
    }

    func bind(_ illust: Illust) {
        loadImage(with: illust.imageURL, into: imageView)
    }
}
