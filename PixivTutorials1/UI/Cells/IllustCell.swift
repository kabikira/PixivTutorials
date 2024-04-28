//
//  IllustCell.swift
//  PixivTutorials1
//
//  Created by koala panda on 2024/04/28.
//

import IllustAPIMock
import Nuke
import NukeExtensions
import UIKit

class IllustCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView! {
        didSet {
            imageView.contentMode = .scaleAspectFit
        }
    }

    func bind(_ illst: Illust) {
        loadImage(with: illst.imageURL, into: imageView)
    }

}
