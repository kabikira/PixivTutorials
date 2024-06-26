import IllustAPIMock
import UIKit

struct IllustSection: Section {
    let illusts: [Illust]
    let parentWidht: CGFloat

    var numberOfItems: Int {
        return illusts.count
    }

    func layoutSection() -> NSCollectionLayoutSection {
        let spacing: CGFloat = 8
        let size: CGFloat = (parentWidht - spacing) / 2

        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(size), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(size))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(spacing)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing

        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(32)),
            elementKind: "RecommendedHeader",
            alignment: .top
        )
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }

    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IllustCell", for: indexPath) as? IllustCell else {
            fatalError()
        }
        cell.bind(illusts[indexPath.item])
        return cell
    }
}
