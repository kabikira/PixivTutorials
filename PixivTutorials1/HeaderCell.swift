//
//  HederCell.swift
//  PixivTutorials1
//
//  Created by koala panda on 2024/04/28.
//

import UIKit

class HeaderCell: UICollectionReusableView {
    @IBOutlet private weak var label: UILabel!

    func bind(_ title: String) {
        label.text = title
    }
}
