//
//  ViewController.swift
//  PixivTutorials1
//
//  Created by koala panda on 2024/04/28.
//

import Combine
import IllustAPIMock
import UIKit

class MainViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            registerCells()
        }
    }

    private var sections: [Section] = [] {
        didSet {
            Task { @MainActor in
                self.collectionView.collectionViewLayout = {
                    let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
                        return self.sections[sectionIndex].layoutSection()
                    }
                    return layout
                }()
                self.collectionView.reloadData()
            }
        }
    }

    private let viewModel = IllustViewModel(api: IllustAPIMock())
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.$rankingIllsts
            .combineLatest(viewModel.$recommendedIllusts)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] rankingIllsts, recommendedIllusts in
                guard let self = self else {
                    return
                }
                self.sections = [
                    RankingIllustSection(illusts: rankingIllsts),
                    IllustSection(illusts: recommendedIllusts, parentWidht: self.view.bounds.width)
                ]
            }
            .store(in: &cancellables)
        
        Task {
            await viewModel.fetchIllusts()
        }

    }
}

extension MainViewController {
    private func registerCells() {
        collectionView.register(UINib(nibName: "HeaderCell", bundle: nil), forSupplementaryViewOfKind: "RecommendedHeader", withReuseIdentifier: "HeaderCell")
        collectionView.register(UINib(nibName: "HeaderCell", bundle: nil), forSupplementaryViewOfKind: "RankingHeader", withReuseIdentifier: "HeaderCell")
        collectionView.register(UINib(nibName: "IllustCell", bundle: nil), forCellWithReuseIdentifier: "IllustCell")
        collectionView.register(UINib(nibName: "RankingIllustCell", bundle: nil), forCellWithReuseIdentifier: "RankingIllustCell")
    }
}

extension MainViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return sections[indexPath.section].configureCell(collectionView: collectionView, indexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCell", for: indexPath) as? HeaderCell else {
            fatalError()
        }
        switch kind {
        case "RecommendedHeader":
            header.bind("Recommended")
            return header
        case "RankingHeader":
            header.bind("Ranking")
            return header
        default:
            fatalError()
        }
    }
}
