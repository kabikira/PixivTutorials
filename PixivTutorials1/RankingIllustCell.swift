//
//  RankingIllustCell.swift
//  PixivTutorials1
//
//  Created by koala panda on 2024/04/28.
//

import UIKit

class RankingIllustCell: UICollectionViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .green
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
}
